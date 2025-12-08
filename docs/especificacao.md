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
4. Sistema adiciona attributes ao Group (company_slug)
5. Novos usuários são adicionados ao Group correspondente

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
  - `name`: Nome da automação
  - `description`: Descrição
  - `n8n_workflow_id`: ID do workflow no n8n
  - `llm_model_id`: Modelo LLM padrão desta automação (FK)
  - `estimated_tokens`: Estimativa de tokens que a automação consome (BIGINT)
  - `estimated_credits`: Estimativa de créditos (DECIMAL - calculado automaticamente)
  - `is_active`: Status ativo/inativo
  - `input_schema`: JSON Schema dos inputs necessários (JSONB)
  - `created_at`: Data de criação
  - `updated_at`: Data de atualização

#### 3.4.2 Entidade: AutomationExecution
- **Campos**:
  - `id`: UUID (PK)
  - `automation_id`: Automação executada (FK)
  - `company_id`: Empresa que executou (FK)
  - `user_id`: Usuário que executou (FK)
  - `llm_model_id`: Modelo LLM utilizado (FK)
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

#### 3.4.3 Integração com n8n
- Webhook para disparar workflows
- Callback para receber status de execução
- Autenticação via API key ou webhook signature

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
- `GET /api/automations` - Listar automações disponíveis
- `GET /api/automations/:id` - Detalhes de uma automação
- `GET /api/automations/:id/estimate` - Estimar custo em créditos
- `POST /api/automations/:id/execute` - Executar automação
- `GET /api/automations/executions` - Histórico de execuções
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

# n8n
N8N_API_URL=https://n8n.example.com/api/v1
N8N_API_KEY=your-api-key
N8N_WEBHOOK_SECRET=webhook-secret

# App
APP_URL=http://localhost:3000
```

## 8. Próximos Passos

1. Criar estrutura do banco de dados
2. Configurar Keycloak (realm, client, roles)
3. Implementar autenticação no Nuxt
4. Criar APIs de gestão de empresas e créditos
5. Integrar com n8n
6. Desenvolver interface de usuário
7. Testes e deploy
