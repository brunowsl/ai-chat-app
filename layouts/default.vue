<template>
  <div class="layout-wrapper">
    <AppHeader @toggle-sidebar="toggleSidebar" />
    <div class="layout-content">
      <AppSidebar :is-collapsed="isSidebarCollapsed" @update:is-collapsed="isSidebarCollapsed = $event" />
      <main class="main-content" :class="{ 'sidebar-collapsed': isSidebarCollapsed }">
        <slot />
      </main>
    </div>
    <Toast />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const { authState } = useAuth()
const router = useRouter()
const isSidebarCollapsed = ref(false)

const toggleSidebar = () => {
  isSidebarCollapsed.value = !isSidebarCollapsed.value
}

// Proteção de rota
onMounted(() => {
  if (!authState.value.isAuthenticated) {
    router.push('/login')
  }
})
</script>

<style scoped>
.layout-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: linear-gradient(135deg, var(--gray-50) 0%, rgba(249, 250, 251, 0.5) 100%);
}

.layout-content {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.main-content {
  flex: 1;
  padding: 2rem;
  overflow-y: auto;
  transition: margin-left 0.3s ease;
}

.main-content.sidebar-collapsed {
  margin-left: 0;
}

@media (max-width: 768px) {
  .main-content {
    padding: 1rem;
  }
}
</style>
