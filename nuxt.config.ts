// https://nuxt.com/docs/api/configuration/nuxt-config
import Aura from '@primevue/themes/aura'

export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },

  css: [
    'primeicons/primeicons.css'
  ],

  components: [
    {
      path: '~/components',
      pathPrefix: false,
    },
  ],

  modules: ['@primevue/nuxt-module'],

  primevue: {
    options: {
      theme: {
        preset: Aura,
        options: {
          darkModeSelector: false,
          cssLayer: false
        }
      }
    }
  },

  app: {
    head: {
      title: 'Lexia',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Plataforma de automação de documentos jurídicos' }
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg?v=2' },
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  }
})
