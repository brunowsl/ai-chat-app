# 🚀 Guia Rápido - Lexia

## ✅ O que foi implementado

### 🎨 Interface Visual Completa
- ✅ Tela de **Login** moderna e profissional
- ✅ **Dashboard** com estatísticas e visão geral
- ✅ Página de **Automações** com grid de cards
- ✅ **Histórico** de execuções com DataTable
- ✅ Gestão de **Créditos** com transações
- ✅ **Configurações** de conta e empresa

### 🎨 Design System
- ✅ Paleta de cores profissional para área jurídica
- ✅ Componentes PrimeVue totalmente integrados
- ✅ Layout responsivo (Desktop, Tablet, Mobile)
- ✅ Tema customizado minimalista

### 🏗️ Arquitetura
- ✅ Estrutura de pastas seguindo boas práticas do Nuxt 3
- ✅ Componentes reutilizáveis (Header, Sidebar)
- ✅ Composables para gerenciamento de estado
- ✅ TypeScript com tipos bem definidos
- ✅ Layouts configurados

## 🖥️ Como Usar

### 1. Iniciar o Servidor

O servidor já está rodando em: **http://localhost:3000**

Se precisar reiniciar:
```bash
npm run dev
```

### 2. Acessar a Aplicação

1. Abra o navegador em: `http://localhost:3000`
2. Você será redirecionado para `/login`
3. Use **qualquer email/senha** para entrar (dados mockados)
4. Após login, você será direcionado ao Dashboard

### 3. Navegar pelas Páginas

**Menu Lateral:**
- 🏠 **Dashboard** - Visão geral e estatísticas
- ⚡ **Automações** - Lista de automações disponíveis
- 📜 **Histórico** - Execuções realizadas
- 💰 **Créditos** - Saldo e transações
- ⚙️ **Configurações** - Preferências e perfil

**Header Superior:**
- 💼 Saldo de créditos sempre visível
- 👤 Menu do usuário (perfil, sair)

## 📱 Responsividade

Teste em diferentes tamanhos de tela:

- **Desktop** (>1024px): Layout completo
- **Tablet** (768px-1024px): Sidebar colapsada
- **Mobile** (<768px): Sidebar apenas com ícones

## 🎨 Paleta de Cores

### Cores Principais
- **Vermelho Bordô**: `#334e68` - `#102a43`
- **Dourado**: `#d4af37`

### Estados
- **Sucesso**: Verde `#059669`
- **Aviso**: Laranja `#d97706`
- **Erro**: Vermelho `#dc2626`
- **Info**: Azul `#2563eb`

## 📊 Dados Mockados

Todos os dados são fictícios para demonstração:

### Usuário Padrão
- Nome: João Silva
- Email: (qualquer email que você digitar)
- Empresa: Silva & Associados

### Automações (4)
1. Petição Inicial - Trabalhista
2. Contrato de Prestação de Serviços
3. Recurso Ordinário
4. Contestação

### Créditos
- Saldo atual: 2.450,50
- Total comprado: 5.000,00
- Total consumido: 2.549,50

## 🗂️ Estrutura de Arquivos Criados

```
ai-chat-app/
├── app.vue                         # App raiz
├── assets/
│   └── css/
│       └── main.css                # Estilos globais + tema
├── components/
│   └── common/
│       ├── AppHeader.vue           # Cabeçalho
│       └── AppSidebar.vue          # Menu lateral
├── composables/
│   ├── useAuth.ts                  # Estado de autenticação
│   └── useCompany.ts               # Estado da empresa
├── layouts/
│   └── default.vue                 # Layout padrão
├── pages/
│   ├── index.vue                   # Dashboard
│   ├── login.vue                   # Login
│   ├── automations.vue             # Automações
│   ├── history.vue                 # Histórico
│   ├── credits.vue                 # Créditos
│   └── settings.vue                # Configurações
├── types/
│   └── index.ts                    # Tipos TypeScript
├── nuxt.config.ts                  # Configuração do Nuxt + PrimeVue
└── package.json                    # Dependências
```

## 🔧 Tecnologias Utilizadas

- **Nuxt 3** - Framework Vue.js
- **Vue 3** - Framework JavaScript reativo
- **TypeScript** - Tipagem estática
- **PrimeVue** - Biblioteca de componentes UI
- **PrimeIcons** - Ícones

## ⚠️ Importante

### O que NÃO está implementado:
- ❌ Integração com backend (API)
- ❌ Autenticação real (Keycloak)
- ❌ Persistência de dados
- ❌ Validações de negócio
- ❌ Upload de arquivos
- ❌ Execução real de automações
- ❌ Sistema de pagamento

### Estado Atual:
✅ **Interface visual 100% funcional**
✅ **Todos os componentes navegáveis**
✅ **Design system completo**
✅ **Dados mockados para demonstração**

## 🎯 Próximos Passos Sugeridos

### Backend
1. Configurar Prisma ORM
2. Criar API routes no Nuxt
3. Integrar com PostgreSQL
4. Configurar Keycloak
5. Implementar n8n

### Frontend
1. Conectar com APIs reais
2. Implementar formulários de criação
3. Adicionar validações
4. Sistema de notificações em tempo real
5. Upload de documentos
6. Visualizador de PDFs

## 🐛 Resolução de Problemas

### O servidor não inicia
```bash
# Limpar cache do Nuxt
rm -rf .nuxt
npm run dev
```

### Erros de TypeScript
```bash
# Reinstalar dependências
rm -rf node_modules package-lock.json
npm install
```

### Página em branco
- Verifique o console do navegador (F12)
- Certifique-se que o servidor está rodando
- Limpe o cache do navegador

## 📝 Comandos Úteis

```bash
# Desenvolvimento
npm run dev

# Build de produção
npm run build

# Preview da build
npm run preview

# Verificar tipos TypeScript
npx nuxi typecheck
```

## 📞 Suporte

Para dúvidas sobre:
- **Nuxt 3**: https://nuxt.com/docs
- **PrimeVue**: https://primevue.org/
- **Vue 3**: https://vuejs.org/

## 🎉 Pronto!

A interface está **100% funcional** para demonstrações e testes de UX/UI.

Acesse agora: **http://localhost:3000**
