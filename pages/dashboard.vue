<template>
  <div class="dashboard">
    <div class="page-header">
      <div>
        <h1>Dashboard</h1>
        <p class="subtitle">Visão geral das suas automações</p>
      </div>
    </div>

    <div class="stats-grid">
      <Card class="stat-card">
        <template #content>
          <div class="stat-content">
            <div class="stat-icon" style="background: var(--law-red-50)">
              <i class="pi pi-bolt" style="color: var(--law-red-700)"></i>
            </div>
            <div class="stat-info">
              <span class="stat-label">Automações Ativas</span>
              <span class="stat-value">{{ stats.activeAutomations }}</span>
            </div>
          </div>
        </template>
      </Card>

      <Card class="stat-card">
        <template #content>
          <div class="stat-content">
            <div class="stat-icon" style="background: #ecfdf5">
              <i class="pi pi-check-circle" style="color: var(--success)"></i>
            </div>
            <div class="stat-info">
              <span class="stat-label">Execuções Hoje</span>
              <span class="stat-value">{{ stats.executionsToday }}</span>
            </div>
          </div>
        </template>
      </Card>

      <Card class="stat-card">
        <template #content>
          <div class="stat-content">
            <div class="stat-icon" style="background: #fef3c7">
              <i class="pi pi-wallet" style="color: var(--law-gold-dark)"></i>
            </div>
            <div class="stat-info">
              <span class="stat-label">Créditos Restantes</span>
              <span class="stat-value">{{ formatCredits(company?.creditsBalance || 0) }}</span>
            </div>
          </div>
        </template>
      </Card>

      <Card class="stat-card">
        <template #content>
          <div class="stat-content">
            <div class="stat-icon" style="background: #fef2f2">
              <i class="pi pi-chart-line" style="color: var(--error)"></i>
            </div>
            <div class="stat-info">
              <span class="stat-label">Consumo Mensal</span>
              <span class="stat-value">{{ formatCredits(stats.monthlyConsumption) }}</span>
            </div>
          </div>
        </template>
      </Card>
    </div>

    <div class="content-grid">
      <Card class="recent-executions">
        <template #title>
          <div class="card-header">
            <h3>Execuções Recentes</h3>
            <Button label="Ver todas" text size="small" @click="goToHistory" />
          </div>
        </template>
        <template #content>
          <div v-if="recentExecutions.length === 0" class="empty-state">
            <i class="pi pi-inbox"></i>
            <p>Nenhuma execução recente</p>
          </div>
          <div v-else class="executions-list">
            <div
              v-for="execution in recentExecutions"
              :key="execution.id"
              class="execution-item"
            >
              <div class="execution-info">
                <div class="execution-name">
                  <i class="pi pi-file-edit"></i>
                  <span>{{ execution.automationName }}</span>
                </div>
                <span class="execution-date">{{ formatDate(execution.createdAt) }}</span>
              </div>
              <div class="execution-details">
                <Tag
                  :value="getStatusLabel(execution.status)"
                  :severity="getStatusSeverity(execution.status)"
                />
                <span class="execution-credits">
                  {{ formatCredits(execution.creditsConsumed) }} créditos
                </span>
              </div>
            </div>
          </div>
        </template>
      </Card>

      <Card class="quick-actions">
        <template #title>
          <h3>Ações Rápidas</h3>
        </template>
        <template #content>
          <div class="actions-list">
            <Button
              label="Nova Automação"
              icon="pi pi-plus"
              class="action-button"
              @click="goToAutomations"
            />
            <Button
              label="Comprar Créditos"
              icon="pi pi-shopping-cart"
              class="action-button"
              outlined
              @click="goToCredits"
            />
            <Button
              label="Ver Histórico"
              icon="pi pi-history"
              class="action-button"
              outlined
              @click="goToHistory"
            />
            <Button
              label="Configurações"
              icon="pi pi-cog"
              class="action-button"
              outlined
              @click="goToSettings"
            />
          </div>
        </template>
      </Card>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import type { AutomationExecution } from '~/types'

const router = useRouter()
const { company, fetchCompany } = useCompany()

const stats = ref({
  activeAutomations: 12,
  executionsToday: 34,
  monthlyConsumption: 856.25
})

const recentExecutions = ref<AutomationExecution[]>([
  {
    id: '1',
    automationName: 'Petição Inicial - Trabalhista',
    status: 'completed',
    creditsConsumed: 12.5,
    createdAt: new Date().toISOString()
  },
  {
    id: '2',
    automationName: 'Contrato de Prestação de Serviços',
    status: 'completed',
    creditsConsumed: 8.3,
    createdAt: new Date(Date.now() - 3600000).toISOString()
  },
  {
    id: '3',
    automationName: 'Recurso Ordinário',
    status: 'running',
    creditsConsumed: 0,
    createdAt: new Date(Date.now() - 7200000).toISOString()
  },
  {
    id: '4',
    automationName: 'Contestação',
    status: 'completed',
    creditsConsumed: 15.2,
    createdAt: new Date(Date.now() - 10800000).toISOString()
  }
])

onMounted(() => {
  fetchCompany()
})

const formatCredits = (value: number) => {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value)
}

const formatDate = (dateStr: string) => {
  const date = new Date(dateStr)
  const now = new Date()
  const diff = now.getTime() - date.getTime()
  const minutes = Math.floor(diff / 60000)
  const hours = Math.floor(diff / 3600000)

  if (minutes < 60) {
    return `há ${minutes} min`
  } else if (hours < 24) {
    return `há ${hours}h`
  } else {
    return date.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit' })
  }
}

const getStatusLabel = (status: string) => {
  const labels: Record<string, string> = {
    pending: 'Pendente',
    running: 'Em execução',
    completed: 'Concluído',
    failed: 'Falhou'
  }
  return labels[status] || status
}

const getStatusSeverity = (status: string) => {
  const severities: Record<string, any> = {
    pending: 'secondary',
    running: 'info',
    completed: 'success',
    failed: 'danger'
  }
  return severities[status] || 'secondary'
}

const goToAutomations = () => router.push('/automations')
const goToHistory = () => router.push('/history')
const goToCredits = () => router.push('/credits')
const goToSettings = () => router.push('/settings')
</script>

<style scoped>
.dashboard {
  max-width: 1400px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
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

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.stat-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-icon i {
  font-size: 1.5rem;
}

.stat-info {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.stat-label {
  font-size: 0.875rem;
  color: var(--gray-600);
}

.stat-value {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-900);
}

.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 1.5rem;
}

.recent-executions,
.quick-actions {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-900);
}

.empty-state {
  text-align: center;
  padding: 3rem 1rem;
  color: var(--gray-400);
}

.empty-state i {
  font-size: 3rem;
  margin-bottom: 1rem;
  display: block;
}

.executions-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.execution-item {
  padding: 1rem;
  background: var(--gray-50);
  border-radius: 8px;
  border: 1px solid var(--gray-200);
}

.execution-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.75rem;
}

.execution-name {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-weight: 500;
  color: var(--gray-900);
}

.execution-name i {
  color: var(--law-red-700);
}

.execution-date {
  font-size: 0.875rem;
  color: var(--gray-500);
}

.execution-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.execution-credits {
  font-size: 0.875rem;
  color: var(--gray-600);
  font-weight: 500;
}

.actions-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.action-button {
  justify-content: flex-start;
  width: 100%;
}

.action-button:first-child {
  background-color: var(--law-red-700);
  border-color: var(--law-red-700);
}

.action-button:first-child:hover {
  background-color: var(--law-red-800);
  border-color: var(--law-red-800);
}

@media (max-width: 1024px) {
  .content-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 640px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }

  .page-header h1 {
    font-size: 1.5rem;
  }
}
</style>
