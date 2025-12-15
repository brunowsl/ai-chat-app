<template>
  <div class="login-container">
    <div class="login-card">
      <div class="login-header">
        <AppLogo size="large" />
        <p class="subtitle">Automação de Documentos Jurídicos com Inteligência Artificial</p>
      </div>

      <form @submit.prevent="handleLogin" class="login-form">
        <div class="form-field">
          <label for="email">E-mail</label>
          <InputText
            id="email"
            v-model="email"
            type="email"
            placeholder="seu@email.com"
            :class="{ 'p-invalid': emailError }"
            required
          />
          <small v-if="emailError" class="p-error">{{ emailError }}</small>
        </div>

        <div class="form-field">
          <label for="password">Senha</label>
          <Password
            id="password"
            v-model="password"
            placeholder="Digite sua senha"
            :feedback="false"
            :class="{ 'p-invalid': passwordError }"
            toggleMask
            required
          />
          <small v-if="passwordError" class="p-error">{{ passwordError }}</small>
        </div>

        <div class="remember-forgot">
          <div class="remember">
            <Checkbox v-model="rememberMe" inputId="remember" :binary="true" />
            <label for="remember">Lembrar-me</label>
          </div>
          <a href="#" class="forgot-link">Esqueceu a senha?</a>
        </div>

        <Button
          type="submit"
          label="Entrar"
          :loading="loading"
          class="login-button"
          icon="pi pi-sign-in"
        />
      </form>

      <div class="login-footer">
        <p>Não tem uma conta? <a href="#">Entre em contato</a></p>
      </div>
    </div>
    <Toast />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useToast } from 'primevue/usetoast'

definePageMeta({
  layout: false
})

const router = useRouter()
const toast = useToast()
const { login } = useAuth()

const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const loading = ref(false)
const emailError = ref('')
const passwordError = ref('')

const handleLogin = async () => {
  emailError.value = ''
  passwordError.value = ''

  if (!email.value) {
    emailError.value = 'E-mail é obrigatório'
    return
  }

  if (!password.value) {
    passwordError.value = 'Senha é obrigatória'
    return
  }

  loading.value = true

  try {
    await login(email.value, password.value)

    toast.add({
      severity: 'success',
      summary: 'Sucesso',
      detail: 'Login realizado com sucesso!',
      life: 3000
    })

    setTimeout(() => {
      router.push('/dashboard')
    }, 500)
  } catch (error) {
    toast.add({
      severity: 'error',
      summary: 'Erro',
      detail: 'Credenciais inválidas',
      life: 3000
    })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--law-red-900) 0%, var(--law-red-700) 100%);
  padding: 1rem;
}

.login-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  width: 100%;
  max-width: 420px;
  padding: 2.5rem;
}

.login-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-bottom: 2rem;
  gap: 1rem;
}

.subtitle {
  color: var(--gray-600);
  font-size: 0.95rem;
  margin-top: -0.25rem;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
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

.form-field :deep(.p-inputtext),
.form-field :deep(.p-password) {
  width: 100%;
}

.form-field :deep(.p-password-input) {
  width: 100%;
}

.remember-forgot {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: -0.25rem;
}

.remember {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.remember label {
  font-size: 0.9rem;
  color: var(--gray-600);
  cursor: pointer;
}

.forgot-link {
  color: var(--law-red-700);
  text-decoration: none;
  font-size: 0.9rem;
  font-weight: 500;
}

.forgot-link:hover {
  text-decoration: underline;
}

.login-button {
  margin-top: 0.5rem;
  padding: 0.75rem;
  font-size: 1rem;
  font-weight: 600;
  background-color: var(--law-red-700);
  border-color: var(--law-red-700);
}

.login-button:hover {
  background-color: var(--law-red-800);
  border-color: var(--law-red-800);
}

.login-footer {
  margin-top: 2rem;
  text-align: center;
  font-size: 0.9rem;
  color: var(--gray-600);
}

.login-footer a {
  color: var(--law-red-700);
  text-decoration: none;
  font-weight: 500;
}

.login-footer a:hover {
  text-decoration: underline;
}

@media (max-width: 480px) {
  .login-card {
    padding: 2rem 1.5rem;
  }

  .subtitle {
    font-size: 0.875rem;
  }
}
</style>
