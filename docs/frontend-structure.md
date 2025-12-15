# Estrutura do Frontend - Lexia

## Visão Geral

Interface visual moderna e minimalista construída com **Nuxt 3**, **Vue 3**, **TypeScript** e **PrimeVue**, focada em escritórios de advocacia.

## Stack Tecnológica

- **Framework**: Nuxt 3
- **UI Library**: PrimeVue
- **Linguagem**: TypeScript
- **Ícones**: PrimeIcons

## Estrutura de Pastas

```
ai-chat-app/
├── app.vue                         # Componente raiz
├── assets/
│   └── css/
│       └── main.css                 # Estilos globais e tema jurídico
├── components/
│   ├── common/
│   │   ├── AppHeader.vue           # Cabeçalho com créditos e menu usuário
│   │   └── AppSidebar.vue          # Menu lateral de navegação
│   └── auth/                       # Componentes de autenticação (futuro)
├── composables/
│   ├── useAuth.ts                  # Gerenciamento de autenticação
│   └── useCompany.ts               # Gerenciamento de dados da empresa
├── layouts/
│   └── default.vue                 # Layout padrão com header e sidebar
├── pages/
│   ├── index.vue                   # Dashboard (home)
│   ├── login.vue                   # Página de login
│   ├── automations.vue             # Lista de automações
│   ├── history.vue                 # Histórico de execuções
│   ├── credits.vue                 # Gerenciamento de créditos
│   └── settings.vue                # Configurações
└── types/
    └── index.ts                    # Tipos TypeScript compartilhados
```

## Paleta de Cores

A paleta foi cuidadosamente escolhida para transmitir profissionalismo e confiança:

### Cores Principais
- **Vermelho Bordô** (primária): `#334e68` - `#102a43`
  - Transmite justiça, seriedade e tradição

- **Dourado** (destaque): `#d4af37`
  - Representa excelência e prestígio

### Cores de Sistema
- **Sucesso**: `#059669` (verde)
- **Aviso**: `#d97706` (laranja)
- **Erro**: `#dc2626` (vermelho)
- **Info**: `#2563eb` (azul)

### Cinzas Neutros
- `#f9fafb` a `#111827` (backgrounds e textos)

## Páginas Implementadas

### 1. Login (`/login`)
- Formulário de autenticação
- Design clean e profissional
- Validação de campos
- Integração com composable `useAuth`
- **Status**: Mockado (dados hardcoded)

### 2. Dashboard (`/`)
- Visão geral com cards estatísticos
- Execuções recentes
- Ações rápidas
- **Status**: Mockado

### 3. Automações (`/automations`)
- Grid de automações disponíveis
- Indicadores de status (ativo/inativo)
- Estimativa de créditos
- Ações (executar, editar, duplicar)
- **Status**: Mockado

### 4. Histórico (`/history`)
- DataTable com execuções realizadas
- Filtros e paginação
- Status visual com tags
- **Status**: Mockado

### 5. Créditos (`/credits`)
- Saldo atual destacado
- Estatísticas (total comprado/consumido)
- Histórico de transações
- Ação de compra
- **Status**: Mockado

### 6. Configurações (`/settings`)
- Informações da empresa
- Dados do usuário
- Opções de segurança
- **Status**: Mockado

## Componentes Reutilizáveis

### AppHeader
- Logo e nome da aplicação
- Display de créditos disponíveis
- Menu do usuário (perfil, configurações, sair)

### AppSidebar
- Navegação principal
- Items: Dashboard, Automações, Histórico, Créditos, Configurações
- Responsivo (colapsa em mobile)
- Indicador de página ativa

## Composables

### useAuth
```typescript
const { authState, login, logout } = useAuth()
```
- Gerencia estado de autenticação
- Mock de login (retorna usuário fictício)
- Proteção de rotas

### useCompany
```typescript
const { company, fetchCompany } = useCompany()
```
- Busca dados da empresa
- Saldo de créditos
- Informações gerais

## Tipos TypeScript

```typescript
interface User {
  id: string
  name: string
  email: string
  role: 'company_admin' | 'company_user' | 'super_admin'
  companyId: string
  companyName: string
  isActive: boolean
}

interface Company {
  id: string
  name: string
  slug: string
  creditsBalance: number
  creditsTotalPurchased: number
  creditsTotalConsumed: number
  isActive: boolean
}

interface Automation {
  id: string
  name: string
  description: string
  estimatedCredits: number
  isActive: boolean
  companyId: string
}

interface AutomationExecution {
  id: string
  automationName: string
  status: 'pending' | 'running' | 'completed' | 'failed'
  creditsConsumed: number
  createdAt: string
  completedAt?: string
}
```

## Responsividade

Todas as páginas são **totalmente responsivas**:

- **Desktop** (>1024px): Layout completo com sidebar expandida
- **Tablet** (768px-1024px): Sidebar colapsada automaticamente
- **Mobile** (<768px): Sidebar com ícones apenas, grids em coluna única

## Design System

### Componentes PrimeVue Utilizados

- **Button**: Ações primárias e secundárias
- **InputText**: Campos de texto
- **Password**: Campos de senha com toggle
- **Card**: Containers de conteúdo
- **DataTable**: Tabelas com paginação e ordenação
- **Tag**: Indicadores de status
- **Menu**: Menus dropdown
- **Toast**: Notificações temporárias
- **Checkbox**: Seleção booleana

### Convenções de Estilo

- Bordas arredondadas: `8px` a `12px`
- Sombras sutis para profundidade
- Transições suaves (0.2s)
- Espaçamento consistente usando múltiplos de 0.5rem
- Tipografia hierárquica clara

## Estado dos Dados

**Todos os dados são mockados** para demonstração da interface. Nenhuma chamada real ao backend é feita.

### Dados Mock Incluídos:
- 1 usuário fictício (João Silva)
- 1 empresa fictícia (Silva & Associados)
- 4 automações de exemplo
- 5 execuções recentes
- Histórico de transações de créditos

## Próximos Passos

### Integrações Futuras
1. Conectar com API real do backend
2. Integração com Keycloak (autenticação)
3. WebSocket para status de execuções em tempo real
4. Upload de arquivos para automações
5. Visualização de documentos gerados
6. Sistema de notificações
7. Gráficos e analytics
8. Testes E2E

### Melhorias de UX
1. Skeleton loaders durante carregamento
2. Estados vazios mais elaborados
3. Onboarding para novos usuários
4. Tutorial interativo
5. Modo escuro (opcional)

## Como Rodar

```bash
# Instalar dependências
npm install

# Servidor de desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview da build
npm run preview
```

## Acessos Mock

Para testar o login, use qualquer email/senha:
- Email: qualquer@email.com
- Senha: qualquer senha

O sistema aceitará e criará uma sessão mockada.

## Observações Importantes

1. **Sem Backend**: Nenhuma funcionalidade conectada ao backend
2. **Estado Volátil**: Dados resetam ao recarregar a página
3. **Validação Mínima**: Validações apenas no frontend
4. **Sem Persistência**: Nenhum dado é salvo permanentemente

## Customização do Tema

O tema pode ser customizado editando `assets/css/main.css`:

```css
:root {
  --law-blue-700: #334e68;  /* Cor primária */
  --law-gold: #d4af37;       /* Cor de destaque */
  /* ... outras variáveis */
}
```

## Suporte a Navegadores

- Chrome/Edge (últimas 2 versões)
- Firefox (últimas 2 versões)
- Safari (últimas 2 versões)

## Licença

Proprietário - Lexia
