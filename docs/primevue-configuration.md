# Configuração do PrimeVue 4 com Nuxt 4

## Versões Instaladas

- **Nuxt**: 4.2.1
- **PrimeVue**: 4.5.3
- **@primevue/nuxt-module**: 4.5.3
- **@primevue/themes**: (latest)

## Configuração no nuxt.config.ts

```typescript
import Aura from '@primevue/themes/aura'

export default defineNuxtConfig({
  modules: ['@primevue/nuxt-module'],

  primevue: {
    options: {
      theme: {
        preset: Aura,  // Importação direta do preset Aura
        options: {
          darkModeSelector: false,
          cssLayer: false  // Desabilita CSS layers
        }
      }
    }
  }
})
```

**Importante:**
- O preset deve ser **importado** como objeto, não como string
- `cssLayer` deve ser `false` para evitar conflitos com Tailwind
- O módulo `@primevue/themes` carrega automaticamente os estilos

## Sistema de Temas do PrimeVue 4

O PrimeVue 4 usa um novo sistema de temas baseado em **Design Tokens** (variáveis CSS).

### Preset Aura

O preset "Aura" é o tema padrão e moderno do PrimeVue 4, que usa variáveis CSS como:

- `--p-primary-color` - Cor primária principal
- `--p-primary-50` a `--p-primary-950` - Escala de cores primárias
- `--p-surface-*` - Cores de superfície
- `--p-text-color` - Cor do texto
- E muitas outras...

## Customização de Cores

Para customizar as cores do tema Aura para o projeto jurídico, adicionamos no [assets/css/main.css](../assets/css/main.css):

```css
:root {
  /* Paleta personalizada */
  --law-blue-700: #334e68;

  /* Sobrescrevendo variáveis do PrimeVue */
  --p-primary-50: var(--law-blue-50);
  --p-primary-100: var(--law-blue-100);
  --p-primary-200: var(--law-blue-200);
  --p-primary-300: var(--law-blue-300);
  --p-primary-400: var(--law-blue-400);
  --p-primary-500: var(--law-blue-500);
  --p-primary-600: var(--law-blue-600);
  --p-primary-700: var(--law-blue-700);
  --p-primary-800: var(--law-blue-800);
  --p-primary-900: var(--law-blue-900);
  --p-primary-950: #0a1929;

  --p-primary-color: var(--law-blue-700);
}
```

## Como Funciona

1. **O módulo @primevue/nuxt-module** automaticamente:
   - Importa os componentes PrimeVue
   - Carrega o tema Aura com seus estilos CSS
   - Configura os auto-imports

2. **O tema Aura** fornece:
   - Estilos base para todos os componentes
   - Sistema de cores via CSS variables
   - Design moderno e limpo

3. **Nosso CSS customizado** (`main.css`):
   - Sobrescreve as variáveis CSS do PrimeVue
   - Aplica a paleta de cores jurídica
   - Mantém compatibilidade com o sistema de temas

## Componentes Disponíveis

Todos os componentes PrimeVue estão disponíveis sem necessidade de importação:

```vue
<template>
  <Button label="Clique aqui" />
  <InputText v-model="value" />
  <DataTable :value="items" />
  <!-- etc -->
</template>
```

## Vantagens do PrimeVue 4

✅ **Temas Modernos**: Sistema de design atualizado
✅ **CSS Variables**: Customização fácil via variáveis CSS
✅ **Performance**: Melhor performance e bundle size
✅ **Auto-import**: Componentes importados automaticamente
✅ **TypeScript**: Tipagem completa out-of-the-box

## Diferenças do PrimeVue 3

### PrimeVue 3 (antigo):
```js
// Importação manual de estilos
css: [
  'primevue/resources/themes/saga-blue/theme.css',
  'primevue/resources/primevue.css',
  'primeicons/primeicons.css'
]
```

### PrimeVue 4 (novo):
```js
// Configuração via preset
primevue: {
  options: {
    theme: {
      preset: 'Aura'  // Tema gerenciado automaticamente
    }
  }
}
```

## Estrutura de Importação

```
app.vue
  └─> @import './assets/css/main.css'  (CSS customizado)

nuxt.config.ts
  └─> primevue: { theme: { preset: 'Aura' } }  (Tema PrimeVue)
  └─> css: ['primeicons/primeicons.css']       (Ícones)
```

## Referências

- [PrimeVue Documentation](https://primevue.org/)
- [PrimeVue Nuxt Module](https://primevue.org/nuxt/)
- [Aura Theme](https://primevue.org/theming/styled/)
- [Design Tokens](https://primevue.org/theming/styled/#tokens)

## Troubleshooting

### Estilos não aplicados?
1. Verifique se `@primevue/themes` está instalado
2. Confirme que o preset está configurado no `nuxt.config.ts`
3. Reinicie o servidor dev

### Cores não mudando?
1. As variáveis CSS devem começar com `--p-`
2. Use `:root` para definir variáveis globais
3. Verifique a ordem de importação dos estilos

### Componentes não encontrados?
1. Certifique-se que `@primevue/nuxt-module` está em `modules`
2. Verifique o console para erros de importação
3. Componentes são auto-importados, não precisa importar manualmente
