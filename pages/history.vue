<template>
  <div class="history-page">
    <div class="page-header">
      <div>
        <h1>Histórico de Execuções</h1>
        <p class="subtitle">Acompanhe todas as execuções de automações</p>
      </div>
    </div>

    <Card class="history-card">
      <template #content>
        <DataTable
          :value="executions"
          :paginator="true"
          :rows="10"
          stripedRows
          responsiveLayout="scroll"
        >
          <Column field="automationName" header="Automação" sortable>
            <template #body="{ data }">
              <div class="automation-cell">
                <i class="pi pi-file-edit"></i>
                <span>{{ data.automationName }}</span>
              </div>
            </template>
          </Column>

          <Column field="status" header="Status" sortable>
            <template #body="{ data }">
              <Tag
                :value="getStatusLabel(data.status)"
                :severity="getStatusSeverity(data.status)"
              />
            </template>
          </Column>

          <Column field="creditsConsumed" header="Créditos" sortable>
            <template #body="{ data }">
              <span class="credits-cell">
                {{ formatCredits(data.creditsConsumed) }}
              </span>
            </template>
          </Column>

          <Column field="createdAt" header="Data" sortable>
            <template #body="{ data }">
              {{ formatDateTime(data.createdAt) }}
            </template>
          </Column>

          <Column header="Ações">
            <template #body="{ data }">
              <Button
                icon="pi pi-eye"
                text
                rounded
                size="small"
                @click="viewExecution(data.id)"
              />
            </template>
          </Column>
        </DataTable>
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { AutomationExecution } from '~/types'

const executions = ref<AutomationExecution[]>([
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
  },
  {
    id: '5',
    automationName: 'Petição Inicial - Trabalhista',
    status: 'failed',
    creditsConsumed: 0,
    createdAt: new Date(Date.now() - 86400000).toISOString()
  }
])

const formatCredits = (value: number) => {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value)
}

const formatDateTime = (dateStr: string) => {
  return new Date(dateStr).toLocaleString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
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

const viewExecution = (id: string) => {
  console.log('Ver execução:', id)
}
</script>

<style scoped>
.history-page {
  max-width: 1400px;
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

.history-card {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.automation-cell {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.automation-cell i {
  color: var(--law-red-700);
}

.credits-cell {
  font-weight: 500;
  color: var(--gray-900);
}
</style>
