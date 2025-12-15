<template>
  <aside class="app-sidebar" :class="{ collapsed: props.isCollapsed }">
    <!-- Navigation -->
    <nav class="sidebar-nav">
      <!-- Main Menu -->
      <div class="nav-section">
        <span v-show="!props.isCollapsed" class="section-title">Menu Principal</span>
        <NuxtLink
          v-for="item in mainMenuItems"
          :key="item.path"
          :to="item.path"
          class="nav-item"
          :class="{ active: isActive(item.path) }"
        >
          <div class="nav-item-content">
            <i :class="item.icon"></i>
            <transition name="fade">
              <span v-show="!props.isCollapsed" class="nav-label">{{ item.label }}</span>
            </transition>
          </div>
          <transition name="fade">
            <span v-if="item.badge && !props.isCollapsed" class="nav-badge">{{ item.badge }}</span>
          </transition>
        </NuxtLink>
      </div>

      <!-- Admin Section -->
      <div v-if="isAdmin" class="nav-section">
        <span v-show="!props.isCollapsed" class="section-title">
          <i class="pi pi-shield"></i> Administração
        </span>
        <NuxtLink
          v-for="item in adminMenuItems"
          :key="item.path"
          :to="item.path"
          class="nav-item admin-item"
          :class="{ active: isActive(item.path) }"
        >
          <div class="nav-item-content">
            <i :class="item.icon"></i>
            <transition name="fade">
              <span v-show="!props.isCollapsed" class="nav-label">{{ item.label }}</span>
            </transition>
          </div>
        </NuxtLink>
      </div>
    </nav>
  </aside>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const props = defineProps<{
  isCollapsed: boolean
}>()

const emit = defineEmits<{
  'update:is-collapsed': [value: boolean]
}>()

const route = useRoute()
const { authState } = useAuth()

const isAdmin = computed(() => {
  return authState.value.user?.role === 'company_admin' || authState.value.user?.role === 'super_admin'
})

const mainMenuItems = [
  {
    label: 'Dashboard',
    icon: 'pi pi-th-large',
    path: '/dashboard',
    badge: null
  },
  {
    label: 'Automações',
    icon: 'pi pi-bolt',
    path: '/automations',
    badge: '12'
  },
  {
    label: 'Histórico',
    icon: 'pi pi-clock',
    path: '/history',
    badge: null
  },
  {
    label: 'Meus Créditos',
    icon: 'pi pi-wallet',
    path: '/credits',
    badge: null
  },
  {
    label: 'Configurações',
    icon: 'pi pi-cog',
    path: '/settings',
    badge: null
  }
]

const adminMenuItems = [
  {
    label: 'Usuários',
    icon: 'pi pi-users',
    path: '/admin/users'
  },
  {
    label: 'Uso de Créditos',
    icon: 'pi pi-chart-bar',
    path: '/admin/credits-usage'
  },
  {
    label: 'Billing',
    icon: 'pi pi-credit-card',
    path: '/admin/billing'
  },
  {
    label: 'Comprar Créditos',
    icon: 'pi pi-shopping-cart',
    path: '/admin/purchase-credits'
  }
]

const isActive = (path: string) => {
  return route.path === path
}
</script>

<style scoped>
.app-sidebar {
  width: 260px;
  background: linear-gradient(180deg, #ffffff 0%, #fafafa 100%);
  border-right: 1px solid var(--gray-200);
  display: flex;
  flex-direction: column;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.03);
}

.app-sidebar.collapsed {
  width: 72px;
}

/* Navigation */
.sidebar-nav {
  flex: 1;
  padding: 1.25rem 0;
  overflow-y: auto;
}

.nav-section {
  margin-bottom: 1.5rem;
  padding: 0 0.75rem;
}

.section-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--gray-500);
  padding: 0.5rem 0.75rem;
  margin-bottom: 0.5rem;
}

.nav-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem 0.875rem;
  margin-bottom: 0.25rem;
  color: var(--gray-700);
  text-decoration: none;
  border-radius: 10px;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  font-weight: 500;
  font-size: 0.9375rem;
  position: relative;
  overflow: hidden;
}

.nav-item::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  width: 3px;
  background: var(--law-red-700);
  transform: scaleY(0);
  transition: transform 0.2s ease;
}

.nav-item:hover {
  background: var(--law-red-50);
  color: var(--law-red-700);
  transform: translateX(2px);
}

.nav-item:hover::before {
  transform: scaleY(1);
}

.nav-item.active {
  background: linear-gradient(135deg, var(--law-red-700) 0%, var(--law-red-800) 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(153, 27, 27, 0.25);
}

.nav-item.active::before {
  display: none;
}

.nav-item-content {
  display: flex;
  align-items: center;
  gap: 0.875rem;
  flex: 1;
}

.nav-item i {
  font-size: 1.125rem;
  min-width: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.nav-label {
  white-space: nowrap;
  overflow: hidden;
}

.nav-badge {
  background: var(--law-red-100);
  color: var(--law-red-700);
  font-size: 0.75rem;
  font-weight: 600;
  padding: 0.125rem 0.5rem;
  border-radius: 12px;
  min-width: 24px;
  text-align: center;
}

.nav-item.active .nav-badge {
  background: rgba(255, 255, 255, 0.2);
  color: white;
}

/* Admin Items */
.admin-item {
  border-left: 2px solid var(--law-gold);
}

.admin-item:hover {
  background: linear-gradient(90deg, #fef3c7 0%, var(--law-red-50) 100%);
}

.admin-item.active {
  background: linear-gradient(135deg, var(--law-gold-dark) 0%, var(--law-gold) 100%);
  border-left-color: transparent;
}

/* Animations */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Scrollbar */
.sidebar-nav::-webkit-scrollbar {
  width: 4px;
}

.sidebar-nav::-webkit-scrollbar-track {
  background: transparent;
}

.sidebar-nav::-webkit-scrollbar-thumb {
  background: var(--gray-300);
  border-radius: 4px;
}

.sidebar-nav::-webkit-scrollbar-thumb:hover {
  background: var(--gray-400);
}

/* Responsive */
@media (max-width: 768px) {
  .app-sidebar {
    width: 72px;
  }

  .app-sidebar.collapsed {
    width: 0;
    border: none;
  }

  .nav-label,
  .section-title,
  .nav-badge {
    display: none !important;
  }
}
</style>
