<template>
  <div class="settings-page">
    <div class="page-header">
      <div>
        <h1>Configurações</h1>
        <p class="subtitle">Gerencie as configurações da sua conta e empresa</p>
      </div>
    </div>

    <div class="settings-content">
      <Card class="settings-card">
        <template #title>
          <h3>Informações da Empresa</h3>
        </template>
        <template #content>
          <div class="form-grid">
            <div class="form-field">
              <label for="companyName">Nome da Empresa</label>
              <InputText
                id="companyName"
                v-model="companyData.name"
                disabled
              />
            </div>

            <div class="form-field">
              <label for="companySlug">Identificador</label>
              <InputText
                id="companySlug"
                v-model="companyData.slug"
                disabled
              />
            </div>
          </div>
        </template>
      </Card>

      <Card class="settings-card">
        <template #title>
          <h3>Informações do Usuário</h3>
        </template>
        <template #content>
          <div class="form-grid">
            <div class="form-field">
              <label for="userName">Nome Completo</label>
              <InputText
                id="userName"
                v-model="userData.name"
              />
            </div>

            <div class="form-field">
              <label for="userEmail">E-mail</label>
              <InputText
                id="userEmail"
                v-model="userData.email"
                type="email"
                disabled
              />
            </div>

            <div class="form-field">
              <label for="userRole">Função</label>
              <InputText
                id="userRole"
                :value="getRoleLabel(userData.role)"
                disabled
              />
            </div>
          </div>

          <div class="form-actions">
            <Button
              label="Salvar Alterações"
              icon="pi pi-save"
              @click="saveUserData"
            />
          </div>
        </template>
      </Card>

      <Card class="settings-card">
        <template #title>
          <h3>Segurança</h3>
        </template>
        <template #content>
          <div class="security-actions">
            <Button
              label="Alterar Senha"
              icon="pi pi-lock"
              outlined
              @click="changePassword"
            />
            <Button
              label="Ativar Autenticação em Dois Fatores"
              icon="pi pi-shield"
              outlined
              @click="enable2FA"
            />
          </div>
        </template>
      </Card>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const { authState } = useAuth()
const { company, fetchCompany } = useCompany()

const companyData = ref({
  name: '',
  slug: ''
})

const userData = ref({
  name: '',
  email: '',
  role: 'company_user'
})

onMounted(() => {
  fetchCompany()

  if (company.value) {
    companyData.value = {
      name: company.value.name,
      slug: company.value.slug
    }
  }

  if (authState.value.user) {
    userData.value = {
      name: authState.value.user.name,
      email: authState.value.user.email,
      role: authState.value.user.role
    }
  }
})

const getRoleLabel = (role: string) => {
  const labels: Record<string, string> = {
    company_admin: 'Administrador',
    company_user: 'Usuário',
    super_admin: 'Super Administrador'
  }
  return labels[role] || role
}

const saveUserData = () => {
  console.log('Salvar dados do usuário')
}

const changePassword = () => {
  console.log('Alterar senha')
}

const enable2FA = () => {
  console.log('Ativar 2FA')
}
</script>

<style scoped>
.settings-page {
  max-width: 900px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 2rem;
}

.page-header h1 {
  font-size: 1.875rem;
  font-weight: 600;
  color: var(--law-red-900);
  margin-bottom: 0.25rem;
}

.subtitle {
  color: var(--gray-600);
  font-size: 0.95rem;
}

.settings-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.settings-card {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.settings-card h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-900);
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.form-field {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-field label {
  font-weight: 500;
  color: var(--gray-700);
  font-size: 0.95rem;
}

.form-actions {
  margin-top: 1.5rem;
  display: flex;
  justify-content: flex-end;
}

.security-actions {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  max-width: 400px;
}

.security-actions .p-button {
  justify-content: flex-start;
}

@media (max-width: 640px) {
  .form-grid {
    grid-template-columns: 1fr;
  }
}
</style>
