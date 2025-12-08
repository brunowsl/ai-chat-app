# Especificação do Sistema - Aplicação Multitenant para Automação de Documentos Jurídicos

## 1. Visão Geral

Sistema multitenant para geração automatizada de documentos jurídicos, integrado com n8n para execução de automações, utilizando Keycloak para autenticação/autorização e sistema de créditos por empresa.

## 2. Arquitetura

### 2.1 Stack Tecnológica
- **Frontend**: Nuxt 3 + TypeScript
- **Backend**: Nuxt API Routes + TypeScript
- **Banco de Dados**: PostgreSQL
- **Autenticação**: Keycloak
- **Automações**: n8n (serviço externo)

### 2.2 Modelo de Tenancy
- Multi-tenant com isolamento por empresa
- Usuários vinculados a uma única empresa
- Controle de acesso baseado em roles (Keycloak)

## 3. Módulos do Sistema

### 3.1 Autenticação e Autorização (Keycloak)

#### 3.1.1 Estrutura de Realms/Clients/Groups
- **Realm**: Realm dedicado para a aplicação (ex: `lextech-chat`)
- **Client**: Cliente OAuth configurado para o frontend
- **Groups**: Cada empresa é representada por um Group no Keycloak
  - Nome do grupo: slug da empresa (ex: `/empresa-abc`)
  - ID do grupo armazenado em `companies.keycloak_company_id`
  - Usuários são membros do grupo da sua empresa
  - Attributes personalizados no grupo:
    - `company_slug`: slug da empresa para referência

#### 3.1.2 Estrutura de Groups
```
Keycloak Realm: "lextech-chat"
├── Group: "/empresa-abc" (id: uuid-123-abc)
│   ├── User: joao@empresa-abc.com
│   ├── User: maria@empresa-abc.com
│   └── Attributes:
│       └── company_slug: "empresa-abc"
│
└── Group: "/empresa-xyz" (id: uuid-789-xyz)
    ├── User: carlos@empresa-xyz.com
    └── Attributes:
        └── company_slug: "empresa-xyz"
```

#### 3.1.3 Roles Sugeridas
- `company_admin`: Administrador da empresa (gerencia usuários e visualiza uso de créditos)
- `company_user`: Usuário padrão (executa automações)
- `super_admin`: Administrador do sistema (gerencia empresas e grupos)

#### 3.1.4 Configuração de Token Mapper
Configure um **Group Mapper** no Keycloak Client para incluir o `company_id` no token JWT:
- Mapper Type: Group Membership
- Token Claim Name: `company_id`
- Full group path: false
- Add to ID token: true
- Add to access token: true
- Add to userinfo: true

#### 3.1.5 Fluxo de Autenticação
1. Usuário faz login via Keycloak
2. Token JWT contém informações do grupo:
   ```json
   {
     "sub": "user-uuid-123",
     "email": "joao@empresa-abc.com",
     "groups": ["/empresa-abc"],
     "company_id": "uuid-123-abc"
   }
   ```
3. Backend valida token e extrai `company_id` (ID do grupo)
4. Backend busca empresa no banco: `SELECT * FROM companies WHERE keycloak_company_id = 'uuid-123-abc'`
5. Todas as operações são filtradas por `company_id` do banco de dados

### 3.2 Gestão de Empresas

#### 3.2.1 Entidade: Company
- **Campos**:
  - `id`: UUID (PK)
  - `name`: Nome da empresa
  - `slug`: Identificador único em URL
  - `keycloak_company_id`: ID do Group no Keycloak (UUID)
  - `n8n_instance_url`: URL da instância n8n dedicada da empresa
  - `n8n_api_key_encrypted`: API key da instância n8n (criptografada)
  - `n8n_webhook_secret`: Secret para validar webhooks da instância n8n
  - `credits_balance`: Saldo atual de créditos (DECIMAL)
  - `credits_total_purchased`: Total de créditos já comprados (DECIMAL)
  - `credits_total_consumed`: Total de créditos já consumidos (DECIMAL)
  - `is_active`: Status ativo/inativo
  - `created_at`: Data de criação
  - `updated_at`: Data de atualização

#### 3.2.2 Funcionalidades
- Cadastro de novas empresas (cria empresa no banco + Group no Keycloak)
- Sincronização empresa ↔ Keycloak Group
- Ativação/desativação de empresas
- Consulta de saldo de créditos
- Histórico de uso

#### 3.2.3 Fluxo de Criação de Empresa
1. Super admin cria empresa no sistema
2. Sistema cria Group no Keycloak com o slug da empresa
3. Sistema armazena ID do Group em `keycloak_company_id`
4. Sistema provisiona instância n8n dedicada para a empresa (Docker/Kubernetes)
5. Sistema armazena credenciais da instância n8n (`n8n_instance_url`, `n8n_api_key_encrypted`, `n8n_webhook_secret`)
6. Sistema adiciona attributes ao Group (company_slug)
7. Novos usuários são adicionados ao Group correspondente
8. Empresa pode criar suas próprias automações na instância n8n dedicada

### 3.3 Sistema de Créditos

#### 3.3.1 Conceito
- Cada automação consome uma quantidade específica de créditos baseada no uso de tokens dos modelos LLM
- Empresa deve ter saldo suficiente para executar automação
- Transações de crédito são registradas para auditoria
- Conversão de tokens para créditos é configurável por modelo de LLM

#### 3.3.2 Entidade: LlmModel
- **Campos**:
  - `id`: UUID (PK)
  - `name`: Nome do modelo (ex: "claude-sonnet-4.5", "gpt-4o")
  - `provider`: Provedor do modelo (anthropic, openai, etc)
  - `credits_per_input_token`: Quantidade de créditos que cada token de entrada custa (DECIMAL)
  - `credits_per_output_token`: Quantidade de créditos que cada token de saída custa (DECIMAL)
  - `cost_per_million_input_tokens`: Custo em USD por milhão de tokens de entrada (DECIMAL)
  - `cost_per_million_output_tokens`: Custo em USD por milhão de tokens de saída (DECIMAL)
  - `is_active`: Status ativo/inativo
  - `created_at`: Data de criação
  - `updated_at`: Data de atualização

**Exemplo**:
- Modelo: "claude-sonnet-4.5"
- credits_per_input_token: 0.00000300 (cada token input custa 0.000003 créditos)
- credits_per_output_token: 0.00001500 (cada token output custa 0.000015 créditos)
- Se uma execução usar 10.000 tokens input + 5.000 tokens output:
  - Créditos input: 10.000 × 0.00000300 = 0.03
  - Créditos output: 5.000 × 0.00001500 = 0.075
  - **Total: 0.105 créditos**

#### 3.3.3 Entidade: CreditTransaction
- **Campos**:
  - `id`: UUID (PK)
  - `company_id`: Empresa relacionada (FK)
  - `user_id`: Usuário que executou (opcional, FK)
  - `automation_id`: Automação executada (opcional, FK)
  - `llm_model_id`: Modelo LLM utilizado (opcional, FK)
  - `tokens_used`: Quantidade total de tokens utilizados (opcional, BIGINT)
  - `amount`: Quantidade de créditos (DECIMAL - positivo = compra, negativo = consumo)
  - `type`: Tipo da transação (purchase, consumption, refund, adjustment)
  - `description`: Descrição da transação
  - `created_at`: Data da transação

#### 3.3.4 Fluxo de Consumo com LLM
1. Usuário solicita execução de automação
2. Sistema estima custo baseado no modelo LLM configurado
3. Sistema verifica se empresa tem saldo suficiente
4. Se saldo suficiente, cria transação de consumo estimada
5. Executa automação via n8n
6. n8n retorna quantidade real de tokens utilizados (input e output separados)
7. Sistema calcula créditos reais consumidos
8. Sistema ajusta transação com valor real de tokens e créditos
9. Registra resultado da execução

**Cálculo de Créditos (novo modelo)**:
```typescript
// Tokens input e output vêm separados da API LLM
input_tokens = 10000
output_tokens = 5000

// Busca as taxas do modelo
credits_per_input_token = 0.00000300   // $3 / 1M tokens
credits_per_output_token = 0.00001500  // $15 / 1M tokens

// Calcula créditos
credits_input = input_tokens * credits_per_input_token
credits_output = output_tokens * credits_per_output_token
credits_total = credits_input + credits_output  // Valor preciso, sem arredondamento
```

**Exemplo Real**:
- Modelo: claude-sonnet-4.5
- Input: 25.000 tokens → 25.000 × 0.00000300 = 0.075 créditos
- Output: 75.000 tokens → 75.000 × 0.00001500 = 1.125 créditos
- **Total: 1.200 créditos**

### 3.4 Automações

#### 3.4.1 Entidade: Automation
- **Campos**:
  - `id`: UUID (PK)
  - `company_id`: Empresa proprietária da automação (FK)
  - `name`: Nome da automação
  - `description`: Descrição
  - `n8n_workflow_id`: ID do workflow na instância n8n da empresa
  - `llm_model_id`: Modelo LLM padrão desta automação (FK)
  - `estimated_tokens`: Estimativa de tokens que a automação consome (BIGINT)
  - `estimated_credits`: Estimativa de créditos (DECIMAL - calculado automaticamente)
  - `is_active`: Status ativo/inativo
  - `input_schema`: JSON Schema dos inputs necessários (JSONB)
  - `created_at`: Data de criação
  - `updated_at`: Data de atualização

**Constraint**: `UNIQUE(company_id, n8n_workflow_id)` - Cada workflow é único por empresa

#### 3.4.2 Entidade: AutomationExecution
- **Campos**:
  - `id`: UUID (PK)
  - `automation_id`: Automação executada (FK - nullable para preservar histórico)
  - `automation_name`: Nome da automação (snapshot no momento da execução)
  - `company_id`: Empresa que executou (FK)
  - `user_id`: Usuário que executou (FK - nullable para preservar histórico)
  - `user_name`: Nome do usuário (snapshot no momento da execução)
  - `user_email`: Email do usuário (snapshot no momento da execução)
  - `llm_model_id`: Modelo LLM utilizado (FK - nullable)
  - `llm_model_name`: Nome do modelo (snapshot no momento da execução)
  - `credit_transaction_id`: Transação de crédito relacionada (FK)
  - `tokens_input`: Tokens de entrada utilizados (BIGINT)
  - `tokens_output`: Tokens de saída gerados (BIGINT)
  - `tokens_total`: Total de tokens = input + output (BIGINT)
  - `credits_consumed`: Créditos efetivamente consumidos (DECIMAL)
  - `input_data`: JSON com dados de entrada (JSONB)
  - `output_data`: JSON com dados de saída (JSONB)
  - `status`: Status (pending, running, completed, failed)
  - `error_message`: Mensagem de erro (se houver)
  - `n8n_execution_id`: ID da execução no n8n
  - `started_at`: Início da execução
  - `completed_at`: Fim da execução
  - `created_at`: Data de criação

**Design Pattern**: Tabela de auditoria com snapshot de dados - campos desnormalizados (`automation_name`, `user_name`, `user_email`, `llm_model_name`) preservam informações mesmo após deleção das entidades referenciadas.

#### 3.4.3 Integração com n8n (Instância por Empresa)

**Arquitetura de Instâncias Dedicadas:**
- Cada empresa possui sua própria instância n8n isolada
- Workflows são criados e gerenciados na instância da empresa
- Isolamento total de dados e execuções entre empresas

**Comunicação com Instância n8n:**
1. Sistema busca `company.n8n_instance_url` e `company.n8n_api_key_encrypted`
2. Faz requisição para a instância específica da empresa
3. Autenticação via API key da instância
4. Webhook callback retorna para sistema com `n8n_webhook_secret` para validação

**Benefícios:**
- ✅ Escalabilidade horizontal (cada empresa escala independentemente)
- ✅ Isolamento total (falha em uma instância não afeta outras)
- ✅ Customização por empresa (workflows, configurações, versões diferentes)
- ✅ Segurança (credenciais isoladas, sem compartilhamento de recursos)

### 3.5 Usuários

#### 3.5.1 Entidade: User
- **Campos**:
  - `id`: UUID (PK)
  - `keycloak_user_id`: ID do usuário no Keycloak
  - `company_id`: Empresa vinculada (FK)
  - `email`: Email do usuário
  - `name`: Nome completo
  - `role`: Role principal
  - `is_active`: Status ativo/inativo
  - `last_login_at`: Último login
  - `created_at`: Data de criação
  - `updated_at`: Data de atualização

#### 3.5.2 Sincronização com Keycloak
- Criar usuário no banco ao primeiro login
- Extrair `company_id` do token (ID do Group no Keycloak)
- Buscar empresa correspondente usando `keycloak_company_id`
- Validar que usuário pertence ao Group correto
- Atualizar informações via webhook do Keycloak (opcional)

## 4. APIs e Endpoints

### 4.1 Autenticação
- `POST /api/auth/login` - Redireciona para Keycloak
- `POST /api/auth/callback` - Callback do Keycloak
- `POST /api/auth/logout` - Logout
- `GET /api/auth/me` - Informações do usuário logado

### 4.2 Empresas
- `GET /api/companies/me` - Dados da empresa do usuário
- `GET /api/companies/me/credits` - Saldo de créditos
- `POST /api/companies` - Criar empresa (super_admin)
- `PATCH /api/companies/:id` - Atualizar empresa (super_admin)

### 4.3 Créditos
- `GET /api/credits/transactions` - Histórico de transações
- `POST /api/credits/purchase` - Registrar compra de créditos (company_admin)
- `GET /api/credits/models` - Listar modelos LLM disponíveis
- `GET /api/credits/calculator` - Calcular créditos baseado em tokens e modelo

### 4.4 Automações
- `GET /api/automations` - Listar automações da empresa do usuário
- `POST /api/automations` - Criar nova automação (sincroniza com n8n)
- `GET /api/automations/:id` - Detalhes de uma automação
- `PATCH /api/automations/:id` - Atualizar automação
- `DELETE /api/automations/:id` - Excluir automação
- `GET /api/automations/:id/estimate` - Estimar custo em créditos
- `POST /api/automations/:id/execute` - Executar automação na instância n8n da empresa
- `GET /api/automations/executions` - Histórico de execuções da empresa
- `GET /api/automations/executions/:id` - Detalhes de uma execução

### 4.5 Administração de Modelos (super_admin)
- `GET /api/admin/llm-models` - Listar modelos LLM
- `POST /api/admin/llm-models` - Cadastrar novo modelo
- `PATCH /api/admin/llm-models/:id` - Atualizar configuração de modelo
- `DELETE /api/admin/llm-models/:id` - Desativar modelo

### 4.6 Webhooks
- `POST /api/webhooks/n8n/callback` - Callback do n8n (com dados de tokens utilizados)

## 5. Regras de Negócio

### 5.1 Controle de Créditos
- Empresa não pode executar automação com saldo insuficiente
- Créditos são debitados no momento da solicitação (baseado em estimativa)
- Após execução, créditos são ajustados para o valor real de tokens consumidos
- Em caso de falha na execução, créditos podem ser estornados (configurável)
- Conversão de tokens para créditos usa valores decimais precisos (sem arredondamento)
- Tokens de entrada e saída têm custos diferentes por modelo
- Sistema de preços por modelo permite flexibilidade comercial (1 crédito = $1 USD padrão)

### 5.2 Isolamento de Dados (Multitenant)
- Usuário só acessa dados de sua empresa
- Token JWT contém `company_id` (ID do Group no Keycloak)
- Backend busca empresa usando `keycloak_company_id`
- Todas as queries filtram por `company_id` do banco de dados
- Middleware de validação em todas as rotas protegidas
- Isolamento garantido através do Group do Keycloak
- **Isolamento n8n**: Cada empresa possui instância n8n dedicada
- Automações são isoladas por `company_id` (uma empresa não vê automações de outra)

### 5.3 Auditoria
- Todas as transações de crédito são registradas
- Histórico de execuções é mantido indefinidamente
- Logs de acesso são registrados

## 6. Segurança

### 6.1 Autenticação
- OAuth 2.0 / OpenID Connect via Keycloak
- Tokens JWT com expiração configurável
- Refresh tokens para renovação

### 6.2 Autorização
- Validação de `company_id` (Group ID) em todas as requisições
- Verificação de que usuário pertence ao Group correto
- Verificação de roles via Keycloak (company_admin, company_user, super_admin)
- Rate limiting por empresa
- Isolamento garantido pelo Group Membership no Keycloak

### 6.3 Comunicação com n8n
- API key ou webhook signature
- HTTPS obrigatório
- Validação de origem das requisições

## 7. Configurações e Variáveis de Ambiente

```env
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/lextech_chat

# Keycloak
KEYCLOAK_URL=https://keycloak.example.com
KEYCLOAK_REALM=lextech
KEYCLOAK_CLIENT_ID=lextech-app
KEYCLOAK_CLIENT_SECRET=secret

# n8n (Orchestration/Provisioning - não são as instâncias das empresas)
N8N_ORCHESTRATOR_URL=https://n8n-orchestrator.example.com
N8N_PROVISIONING_API_KEY=provisioning-key
# Cada empresa terá sua própria instância n8n provisionada dinamicamente
# URLs e credenciais armazenadas no banco (companies.n8n_instance_url, etc)

# Encryption (para criptografar n8n_api_key_encrypted)
ENCRYPTION_KEY=your-encryption-key-base64

# App
APP_URL=http://localhost:3000
```

## 8. ORM e Acesso ao Banco de Dados (Prisma)

### 8.1 Por que Prisma?

O Prisma será utilizado como ORM para acesso ao banco de dados PostgreSQL, oferecendo:
- **Type-safety**: Tipagem completa em TypeScript baseada no schema
- **Migrations**: Controle de versão do schema do banco
- **Query Builder**: API intuitiva e type-safe para queries
- **Performance**: Queries otimizadas e connection pooling
- **Developer Experience**: Autocomplete e validação em tempo de desenvolvimento

### 8.2 Instalação

```bash
npm install @prisma/client
npm install -D prisma
```

### 8.3 Inicialização

```bash
npx prisma init
```

Isso criará:
- `prisma/schema.prisma`: Schema do Prisma
- `.env`: Arquivo com DATABASE_URL (se não existir)

### 8.4 Schema Prisma (prisma/schema.prisma)

```prisma
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// ============================================
// Model: Company
// ============================================
model Company {
  id                      String   @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  name                    String   @db.VarChar(255)
  slug                    String   @unique @db.VarChar(100)
  keycloakCompanyId       String?  @unique @map("keycloak_company_id") @db.VarChar(255)
  n8nInstanceUrl          String?  @map("n8n_instance_url") @db.VarChar(500)
  n8nApiKeyEncrypted      String?  @map("n8n_api_key_encrypted") @db.Text
  n8nWebhookSecret        String?  @map("n8n_webhook_secret") @db.VarChar(255)
  creditsBalance          Decimal  @default(0) @map("credits_balance") @db.Decimal(20, 8)
  creditsTotalPurchased   Decimal  @default(0) @map("credits_total_purchased") @db.Decimal(20, 8)
  creditsTotalConsumed    Decimal  @default(0) @map("credits_total_consumed") @db.Decimal(20, 8)
  isActive                Boolean  @default(true) @map("is_active")
  createdAt               DateTime @default(now()) @map("created_at") @db.Timestamptz(6)
  updatedAt               DateTime @updatedAt @map("updated_at") @db.Timestamptz(6)

  // Relations
  users                   User[]
  automations             Automation[]
  creditTransactions      CreditTransaction[]
  automationExecutions    AutomationExecution[]

  @@index([slug])
  @@index([isActive])
  @@index([keycloakCompanyId])
  @@index([n8nInstanceUrl])
  @@map("companies")
}

// ============================================
// Model: User
// ============================================
model User {
  id                    String    @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  keycloakUserId        String    @unique @map("keycloak_user_id") @db.VarChar(255)
  companyId             String    @map("company_id") @db.Uuid
  email                 String    @db.VarChar(255)
  name                  String    @db.VarChar(255)
  role                  String    @default("company_user") @db.VarChar(50)
  isActive              Boolean   @default(true) @map("is_active")
  lastLoginAt           DateTime? @map("last_login_at") @db.Timestamptz(6)
  createdAt             DateTime  @default(now()) @map("created_at") @db.Timestamptz(6)
  updatedAt             DateTime  @updatedAt @map("updated_at") @db.Timestamptz(6)

  // Relations
  company               Company   @relation(fields: [companyId], references: [id], onDelete: Cascade)
  creditTransactions    CreditTransaction[]
  automationExecutions  AutomationExecution[]

  @@unique([email, companyId])
  @@index([companyId])
  @@index([keycloakUserId])
  @@index([email])
  @@index([isActive])
  @@map("users")
}

// ============================================
// Model: LlmModel
// ============================================
model LlmModel {
  id                            String   @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  name                          String   @unique @db.VarChar(255)
  provider                      String   @db.VarChar(100)
  creditsPerInputToken          Decimal  @map("credits_per_input_token") @db.Decimal(20, 8)
  creditsPerOutputToken         Decimal  @map("credits_per_output_token") @db.Decimal(20, 8)
  costPerMillionInputTokens     Decimal? @map("cost_per_million_input_tokens") @db.Decimal(10, 4)
  costPerMillionOutputTokens    Decimal? @map("cost_per_million_output_tokens") @db.Decimal(10, 4)
  isActive                      Boolean  @default(true) @map("is_active")
  createdAt                     DateTime @default(now()) @map("created_at") @db.Timestamptz(6)
  updatedAt                     DateTime @updatedAt @map("updated_at") @db.Timestamptz(6)

  // Relations
  automations             Automation[]
  creditTransactions      CreditTransaction[]
  automationExecutions    AutomationExecution[]

  @@index([name])
  @@index([provider])
  @@index([isActive])
  @@map("llm_models")
}

// ============================================
// Model: Automation
// ============================================
model Automation {
  id                  String    @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  companyId           String    @map("company_id") @db.Uuid
  name                String    @db.VarChar(255)
  description         String?   @db.Text
  n8nWorkflowId       String    @map("n8n_workflow_id") @db.VarChar(255)
  llmModelId          String?   @map("llm_model_id") @db.Uuid
  estimatedTokens     BigInt?   @map("estimated_tokens")
  estimatedCredits    Decimal?  @map("estimated_credits") @db.Decimal(20, 8)
  isActive            Boolean   @default(true) @map("is_active")
  inputSchema         Json?     @map("input_schema")
  createdAt           DateTime  @default(now()) @map("created_at") @db.Timestamptz(6)
  updatedAt           DateTime  @updatedAt @map("updated_at") @db.Timestamptz(6)

  // Relations
  company                   Company   @relation(fields: [companyId], references: [id], onDelete: Cascade)
  llmModel                  LlmModel? @relation(fields: [llmModelId], references: [id], onDelete: SetNull)
  creditTransactions        CreditTransaction[]
  automationExecutions      AutomationExecution[]

  @@unique([companyId, n8nWorkflowId])
  @@index([companyId])
  @@index([isActive])
  @@index([companyId, isActive])
  @@index([llmModelId])
  @@map("automations")
}

// ============================================
// Model: CreditTransaction
// ============================================
model CreditTransaction {
  id            String    @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  companyId     String    @map("company_id") @db.Uuid
  userId        String?   @map("user_id") @db.Uuid
  automationId  String?   @map("automation_id") @db.Uuid
  llmModelId    String?   @map("llm_model_id") @db.Uuid
  tokensUsed    BigInt?   @map("tokens_used")
  amount        Decimal   @db.Decimal(20, 8)
  type          String    @db.VarChar(50)
  description   String?   @db.Text
  createdAt     DateTime  @default(now()) @map("created_at") @db.Timestamptz(6)

  // Relations
  company       Company      @relation(fields: [companyId], references: [id], onDelete: Restrict)
  user          User?        @relation(fields: [userId], references: [id], onDelete: SetNull)
  automation    Automation?  @relation(fields: [automationId], references: [id], onDelete: SetNull)
  llmModel      LlmModel?    @relation(fields: [llmModelId], references: [id], onDelete: SetNull)
  automationExecutions AutomationExecution[]

  @@index([companyId])
  @@index([userId])
  @@index([automationId])
  @@index([llmModelId])
  @@index([type])
  @@index([createdAt(sort: Desc)])
  @@index([companyId, type, createdAt(sort: Desc)])
  @@map("credit_transactions")
}

// ============================================
// Model: AutomationExecution
// ============================================
model AutomationExecution {
  id                    String    @id @default(dbgenerated("uuid_generate_v4()")) @db.Uuid
  automationId          String?   @map("automation_id") @db.Uuid
  automationName        String    @map("automation_name") @db.VarChar(255)
  companyId             String    @map("company_id") @db.Uuid
  userId                String?   @map("user_id") @db.Uuid
  userName              String    @map("user_name") @db.VarChar(255)
  userEmail             String    @map("user_email") @db.VarChar(255)
  llmModelId            String?   @map("llm_model_id") @db.Uuid
  llmModelName          String?   @map("llm_model_name") @db.VarChar(255)
  creditTransactionId   String?   @map("credit_transaction_id") @db.Uuid
  tokensInput           BigInt    @default(0) @map("tokens_input")
  tokensOutput          BigInt    @default(0) @map("tokens_output")
  tokensTotal           BigInt    @default(0) @map("tokens_total")
  creditsConsumed       Decimal   @default(0) @map("credits_consumed") @db.Decimal(20, 8)
  inputData             Json      @map("input_data")
  outputData            Json?     @map("output_data")
  status                String    @default("pending") @db.VarChar(50)
  errorMessage          String?   @map("error_message") @db.Text
  n8nExecutionId        String?   @map("n8n_execution_id") @db.VarChar(255)
  startedAt             DateTime? @map("started_at") @db.Timestamptz(6)
  completedAt           DateTime? @map("completed_at") @db.Timestamptz(6)
  createdAt             DateTime  @default(now()) @map("created_at") @db.Timestamptz(6)

  // Relations
  automation            Automation?         @relation(fields: [automationId], references: [id], onDelete: SetNull)
  company               Company             @relation(fields: [companyId], references: [id], onDelete: Cascade)
  user                  User?               @relation(fields: [userId], references: [id], onDelete: SetNull)
  llmModel              LlmModel?           @relation(fields: [llmModelId], references: [id], onDelete: SetNull)
  creditTransaction     CreditTransaction?  @relation(fields: [creditTransactionId], references: [id], onDelete: SetNull)

  @@index([automationId])
  @@index([companyId])
  @@index([userId])
  @@index([userEmail])
  @@index([llmModelId])
  @@index([status])
  @@index([createdAt(sort: Desc)])
  @@index([n8nExecutionId])
  @@index([companyId, status, createdAt(sort: Desc)])
  @@map("automation_executions")
}
```

### 8.5 Configuração da Conexão

**Arquivo `.env`:**
```env
DATABASE_URL="postgresql://user:password@localhost:5432/lextech_chat?schema=public"
```

### 8.6 Workflows Prisma

#### 8.6.1 Gerar Cliente Prisma
Após criar ou modificar o schema:
```bash
npx prisma generate
```

Isso gera o Prisma Client tipado em `node_modules/@prisma/client`.

#### 8.6.2 Criar Migration
Quando o schema SQL já existe (caso do projeto):
```bash
# Introspect banco existente
npx prisma db pull

# Ou criar migration a partir do schema.prisma
npx prisma migrate dev --name init
```

#### 8.6.3 Aplicar Migrations
```bash
# Development
npx prisma migrate dev

# Production
npx prisma migrate deploy
```

#### 8.6.4 Prisma Studio (GUI)
```bash
npx prisma studio
```

### 8.7 Uso no Nuxt 3

#### 8.7.1 Criar Plugin Prisma

**Arquivo `server/plugins/prisma.ts`:**
```typescript
import { PrismaClient } from '@prisma/client'

let prisma: PrismaClient

declare module 'h3' {
  interface H3EventContext {
    prisma: PrismaClient
  }
}

export default defineNitroPlugin(() => {
  if (!prisma) {
    prisma = new PrismaClient({
      log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
    })
  }
})

export { prisma }
```

#### 8.7.2 Composable para Prisma

**Arquivo `server/utils/prisma.ts`:**
```typescript
import { PrismaClient } from '@prisma/client'

const prismaClientSingleton = () => {
  return new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  })
}

declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>
}

const prisma = globalThis.prisma ?? prismaClientSingleton()

export default prisma

if (process.env.NODE_ENV !== 'production') globalThis.prisma = prisma
```

#### 8.7.3 Uso em API Routes

**Exemplo: `server/api/companies/[id].get.ts`:**
```typescript
import prisma from '~/server/utils/prisma'

export default defineEventHandler(async (event) => {
  const id = getRouterParam(event, 'id')

  if (!id) {
    throw createError({
      statusCode: 400,
      message: 'Company ID is required'
    })
  }

  const company = await prisma.company.findUnique({
    where: { id },
    include: {
      users: {
        where: { isActive: true }
      },
      automations: {
        where: { isActive: true }
      }
    }
  })

  if (!company) {
    throw createError({
      statusCode: 404,
      message: 'Company not found'
    })
  }

  return company
})
```

**Exemplo: `server/api/automations/[id]/execute.post.ts`:**
```typescript
import prisma from '~/server/utils/prisma'
import { Decimal } from '@prisma/client/runtime/library'

export default defineEventHandler(async (event) => {
  const automationId = getRouterParam(event, 'id')
  const body = await readBody(event)
  const { companyId, userId, inputData } = body

  // Buscar automação com modelo LLM
  const automation = await prisma.automation.findUnique({
    where: { id: automationId },
    include: { llmModel: true }
  })

  if (!automation || automation.companyId !== companyId) {
    throw createError({
      statusCode: 404,
      message: 'Automation not found'
    })
  }

  // Verificar saldo de créditos
  const company = await prisma.company.findUnique({
    where: { id: companyId }
  })

  if (!company || company.creditsBalance.lessThan(automation.estimatedCredits || 0)) {
    throw createError({
      statusCode: 402,
      message: 'Insufficient credits'
    })
  }

  // Buscar dados do usuário
  const user = await prisma.user.findUnique({
    where: { id: userId }
  })

  if (!user) {
    throw createError({
      statusCode: 404,
      message: 'User not found'
    })
  }

  // Criar execução com snapshot de dados
  const execution = await prisma.automationExecution.create({
    data: {
      automationId: automation.id,
      automationName: automation.name,
      companyId,
      userId,
      userName: user.name,
      userEmail: user.email,
      llmModelId: automation.llmModelId,
      llmModelName: automation.llmModel?.name,
      inputData,
      status: 'pending'
    }
  })

  // Criar transação de crédito estimada
  const transaction = await prisma.creditTransaction.create({
    data: {
      companyId,
      userId,
      automationId: automation.id,
      llmModelId: automation.llmModelId,
      amount: new Decimal(automation.estimatedCredits || 0).negated(),
      type: 'consumption',
      description: `Estimated cost for automation: ${automation.name}`
    }
  })

  // Atualizar execução com transaction_id
  await prisma.automationExecution.update({
    where: { id: execution.id },
    data: { creditTransactionId: transaction.id }
  })

  // TODO: Disparar execução no n8n (implementar integração)

  return {
    executionId: execution.id,
    status: execution.status,
    estimatedCredits: automation.estimatedCredits
  }
})
```

### 8.8 Boas Práticas

1. **Singleton Pattern**: Use sempre a mesma instância do PrismaClient
2. **Connection Pooling**: Prisma gerencia automaticamente o pool de conexões
3. **Type Safety**: Aproveite os tipos gerados para evitar erros
4. **Transactions**: Use `prisma.$transaction()` para operações atômicas
5. **Soft Deletes**: Considere usar `isActive` em vez de deletar registros
6. **Middleware**: Use Prisma Middleware para logs, validações, etc.

**Exemplo de Transaction:**
```typescript
const result = await prisma.$transaction(async (tx) => {
  // Criar transação de consumo
  const creditTx = await tx.creditTransaction.create({
    data: {
      companyId,
      amount: new Decimal(-1.5),
      type: 'consumption',
      description: 'Automation execution'
    }
  })

  // Criar execução
  const execution = await tx.automationExecution.create({
    data: {
      automationId,
      companyId,
      userId,
      creditTransactionId: creditTx.id,
      status: 'running'
    }
  })

  return { creditTx, execution }
})
```

### 8.9 Comparação: SQL Raw vs Prisma

**SQL Raw (PostgreSQL):**
```sql
SELECT ae.*, a.name as automation_name, u.name as user_name
FROM automation_executions ae
LEFT JOIN automations a ON a.id = ae.automation_id
LEFT JOIN users u ON u.id = ae.user_id
WHERE ae.company_id = $1 AND ae.status = $2
ORDER BY ae.created_at DESC
LIMIT 20;
```

**Prisma (Type-safe):**
```typescript
const executions = await prisma.automationExecution.findMany({
  where: {
    companyId,
    status: 'completed'
  },
  include: {
    automation: true,
    user: true
  },
  orderBy: {
    createdAt: 'desc'
  },
  take: 20
})
```

**Vantagens Prisma:**
- ✅ Autocomplete completo
- ✅ Validação em tempo de desenvolvimento
- ✅ Tipos gerados automaticamente
- ✅ Proteção contra SQL injection
- ✅ Migrations versionadas
- ✅ Suporte a relations complexas

## 9. Próximos Passos

1. ✅ Criar estrutura do banco de dados (SQL + Prisma schema)
2. Configurar Keycloak (realm, client, roles)
3. Implementar autenticação no Nuxt
4. Instalar e configurar Prisma
5. Criar APIs de gestão de empresas e créditos
6. Integrar com n8n
7. Desenvolver interface de usuário
8. Testes e deploy
