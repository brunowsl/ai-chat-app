<template>
  <header class="app-header">
    <div class="header-left">
      <Button
        icon="pi pi-bars"
        text
        rounded
        class="menu-toggle"
        @click="$emit('toggle-sidebar')"
      />
      <div class="header-brand">
        <AppLogo size="medium" />
      </div>
    </div>

    <div class="header-right">
      <!-- Credits Display with Modern Design -->
      <div class="credits-display">
        <div class="credits-icon-wrapper">
          <i class="pi pi-wallet"></i>
        </div>
        <div class="credits-info">
          <span class="credits-label">Saldo Disponível</span>
          <span class="credits-value">{{ formatCredits(company?.creditsBalance || 0) }}</span>
        </div>
      </div>

      <!-- User Profile Button -->
      <div class="user-profile" @click="toggleUserMenu">
        <div class="user-avatar">
          <span>{{ getUserInitials() }}</span>
        </div>
        <div class="user-info">
          <span class="user-name">{{ authState.user?.name }}</span>
          <span class="user-role">{{ getRoleLabel() }}</span>
        </div>
        <i class="pi pi-chevron-down"></i>
      </div>

      <Menu ref="userMenu" :model="userMenuItems" popup class="user-menu-popup" />
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

defineEmits(['toggle-sidebar'])

const { authState, logout } = useAuth()
const { company, fetchCompany } = useCompany()
const router = useRouter()

const userMenu = ref()

onMounted(() => {
  fetchCompany()
})

const toggleUserMenu = (event: Event) => {
  userMenu.value.toggle(event)
}

const handleLogout = () => {
  logout()
  router.push('/login')
}

const getUserInitials = () => {
  const name = authState.value.user?.name || 'U'
  const parts = name.split(' ')
  if (parts.length >= 2) {
    return `${parts[0][0]}${parts[parts.length - 1][0]}`.toUpperCase()
  }
  return name.substring(0, 2).toUpperCase()
}

const getRoleLabel = () => {
  const role = authState.value.user?.role
  if (role === 'company_admin') return 'Administrador'
  if (role === 'super_admin') return 'Super Admin'
  return 'Usuário'
}

const userMenuItems = [
  {
    label: 'Perfil',
    icon: 'pi pi-user',
    command: () => {
      router.push('/settings')
    }
  },
  {
    label: 'Configurações',
    icon: 'pi pi-cog',
    command: () => {
      router.push('/settings')
    }
  },
  {
    separator: true
  },
  {
    label: 'Sair',
    icon: 'pi pi-sign-out',
    command: handleLogout
  }
]

const formatCredits = (value: number) => {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value)
}
</script>

<style scoped>
.app-header {
  background: linear-gradient(135deg, rgba(153, 27, 27, 0.03) 0%, rgba(255, 255, 255, 1) 100%);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(153, 27, 27, 0.1);
  padding: 0 2rem;
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  position: sticky;
  top: 0;
  z-index: 100;
  transition: all 0.3s ease;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.menu-toggle {
  color: var(--law-red-700);
  transition: all 0.3s ease;
}

.menu-toggle:hover {
  background: linear-gradient(135deg, var(--law-red-50) 0%, var(--law-red-100) 100%);
  transform: scale(1.1);
}

/* Header Brand */
.header-brand {
  padding-left: 0.5rem;
  border-left: 2px solid rgba(153, 27, 27, 0.1);
}

.header-right {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

/* Modern Credits Display */
.credits-display {
  display: flex;
  align-items: center;
  gap: 0.875rem;
  padding: 0.75rem 1.25rem;
  background: linear-gradient(135deg, rgba(212, 175, 55, 0.08) 0%, rgba(212, 175, 55, 0.04) 100%);
  border-radius: 12px;
  border: 1px solid rgba(212, 175, 55, 0.2);
  box-shadow: 0 2px 8px rgba(212, 175, 55, 0.1);
  transition: all 0.3s ease;
}

.credits-display:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(212, 175, 55, 0.15);
  border-color: rgba(212, 175, 55, 0.3);
}

.credits-icon-wrapper {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--law-gold) 0%, var(--law-gold-dark) 100%);
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(212, 175, 55, 0.3);
}

.credits-icon-wrapper i {
  color: white;
  font-size: 1.1rem;
}

.credits-info {
  display: flex;
  flex-direction: column;
  gap: 0.125rem;
}

.credits-label {
  color: var(--gray-600);
  font-size: 0.75rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.credits-value {
  font-weight: 700;
  color: var(--law-red-800);
  font-size: 1.125rem;
  letter-spacing: -0.5px;
}

/* Modern User Profile */
.user-profile {
  display: flex;
  align-items: center;
  gap: 0.875rem;
  padding: 0.5rem 1rem;
  background: white;
  border-radius: 12px;
  border: 1px solid var(--gray-200);
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.user-profile:hover {
  background: linear-gradient(135deg, rgba(153, 27, 27, 0.02) 0%, white 100%);
  border-color: var(--law-red-300);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(153, 27, 27, 0.1);
}

.user-avatar {
  width: 42px;
  height: 42px;
  border-radius: 10px;
  background: linear-gradient(135deg, var(--law-red-700) 0%, var(--law-red-800) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 0.95rem;
  letter-spacing: 0.5px;
  box-shadow: 0 2px 8px rgba(153, 27, 27, 0.3);
}

.user-info {
  display: flex;
  flex-direction: column;
  gap: 0.125rem;
}

.user-name {
  font-weight: 600;
  color: var(--gray-900);
  font-size: 0.95rem;
  line-height: 1.2;
}

.user-role {
  color: var(--gray-500);
  font-size: 0.75rem;
  font-weight: 500;
}

.user-profile > i {
  color: var(--gray-400);
  font-size: 0.875rem;
  transition: transform 0.3s ease;
}

.user-profile:hover > i {
  transform: rotate(180deg);
  color: var(--law-red-700);
}

/* Custom Menu Popup Styles */
:deep(.user-menu-popup) {
  border-radius: 12px;
  border: 1px solid var(--gray-200);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  overflow: hidden;
}

:deep(.user-menu-popup .p-menu-list) {
  padding: 0.5rem;
}

:deep(.user-menu-popup .p-menuitem-link) {
  border-radius: 8px;
  transition: all 0.2s ease;
}

:deep(.user-menu-popup .p-menuitem-link:hover) {
  background: linear-gradient(135deg, rgba(153, 27, 27, 0.08) 0%, rgba(153, 27, 27, 0.04) 100%);
}

/* Responsive */
@media (max-width: 768px) {
  .app-header {
    padding: 0 1rem;
    height: 64px;
  }

  .credits-label {
    display: none;
  }

  .credits-display {
    padding: 0.625rem 0.875rem;
    gap: 0.5rem;
  }

  .credits-icon-wrapper {
    width: 34px;
    height: 34px;
  }

  .credits-value {
    font-size: 1rem;
  }

  .user-info {
    display: none;
  }

  .user-profile {
    padding: 0.5rem;
    gap: 0.5rem;
  }

  .user-avatar {
    width: 38px;
    height: 38px;
  }
}

@media (max-width: 480px) {
  .app-header {
    padding: 0 0.75rem;
  }

  .header-brand {
    padding-left: 0.25rem;
  }

  .header-right {
    gap: 0.75rem;
  }

  .credits-display {
    padding: 0.5rem 0.75rem;
  }
}
</style>
