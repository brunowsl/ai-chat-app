<template>
  <div class="credits-page">
    <div class="page-header">
      <div>
        <h1>Gerenciar Créditos</h1>
        <p class="subtitle">Acompanhe seu saldo e histórico de créditos</p>
      </div>
      <Button
        label="Comprar Créditos"
        icon="pi pi-shopping-cart"
        @click="purchaseCredits"
      />
    </div>

    <div class="credits-overview">
      <Card class="balance-card">
        <template #content>
          <div class="balance-content">
            <div class="balance-icon">
              <i class="pi pi-wallet"></i>
            </div>
            <div class="balance-info">
              <span class="balance-label">Saldo Atual</span>
              <span class="balance-value">{{ formatCredits(company?.creditsBalance || 0) }}</span>
              <span class="balance-subtitle">créditos disponíveis</span>
            </div>
          </div>
        </template>
      </Card>

      <Card class="stats-card">
        <template #content>
          <div class="stats-row">
            <div class="stat-item">
              <span class="stat-label">Total Comprado</span>
              <span class="stat-value">{{ formatCredits(company?.creditsTotalPurchased || 0) }}</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <span class="stat-label">Total Consumido</span>
              <span class="stat-value">{{ formatCredits(company?.creditsTotalConsumed || 0) }}</span>
            </div>
          </div>
        </template>
      </Card>
    </div>

    <Card class="transactions-card">
      <template #title>
        <h3>Histórico de Transações</h3>
      </template>
      <template #content>
        <DataTable
          :value="transactions"
          :paginator="true"
          :rows="10"
          stripedRows
          responsiveLayout="scroll"
        >
          <Column field="type" header="Tipo" sortable>
            <template #body="{ data }">
              <Tag
                :value="getTypeLabel(data.type)"
                :severity="getTypeSeverity(data.type)"
              />
            </template>
          </Column>

          <Column field="description" header="Descrição" sortable />

          <Column field="amount" header="Valor" sortable>
            <template #body="{ data }">
              <span :class="['amount-cell', data.amount > 0 ? 'positive' : 'negative']">
                {{ data.amount > 0 ? '+' : '' }}{{ formatCredits(data.amount) }}
              </span>
            </template>
          </Column>

          <Column field="createdAt" header="Data" sortable>
            <template #body="{ data }">
              {{ formatDateTime(data.createdAt) }}
            </template>
          </Column>
        </DataTable>
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const { company, fetchCompany } = useCompany()

interface Transaction {
  id: string
  type: 'purchase' | 'consumption' | 'refund' | 'adjustment'
  description: string
  amount: number
  createdAt: string
}

const transactions = ref<Transaction[]>([
  {
    id: '1',
    type: 'purchase',
    description: 'Compra de pacote 5000 créditos',
    amount: 5000,
    createdAt: new Date(Date.now() - 86400000 * 30).toISOString()
  },
  {
    id: '2',
    type: 'consumption',
    description: 'Execução: Petição Inicial - Trabalhista',
    amount: -12.5,
    createdAt: new Date().toISOString()
  },
  {
    id: '3',
    type: 'consumption',
    description: 'Execução: Contrato de Prestação de Serviços',
    amount: -8.3,
    createdAt: new Date(Date.now() - 3600000).toISOString()
  },
  {
    id: '4',
    type: 'consumption',
    description: 'Execução: Contestação',
    amount: -15.2,
    createdAt: new Date(Date.now() - 7200000).toISOString()
  },
  {
    id: '5',
    type: 'refund',
    description: 'Estorno: Execução falhou',
    amount: 10.5,
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

const formatDateTime = (dateStr: string) => {
  return new Date(dateStr).toLocaleString('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const getTypeLabel = (type: string) => {
  const labels: Record<string, string> = {
    purchase: 'Compra',
    consumption: 'Consumo',
    refund: 'Estorno',
    adjustment: 'Ajuste'
  }
  return labels[type] || type
}

const getTypeSeverity = (type: string) => {
  const severities: Record<string, any> = {
    purchase: 'success',
    consumption: 'info',
    refund: 'warning',
    adjustment: 'secondary'
  }
  return severities[type] || 'secondary'
}

const purchaseCredits = () => {
  console.log('Comprar créditos')
}
</script>

<style scoped>
.credits-page {
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

.credits-overview {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.balance-card,
.stats-card,
.transactions-card {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.balance-content {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.balance-icon {
  width: 80px;
  height: 80px;
  border-radius: 16px;
  background: linear-gradient(135deg, var(--law-red-600), var(--law-red-800));
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.balance-icon i {
  font-size: 2.5rem;
}

.balance-info {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.balance-label {
  font-size: 0.875rem;
  color: var(--gray-600);
}

.balance-value {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--law-red-700);
  line-height: 1;
}

.balance-subtitle {
  font-size: 0.875rem;
  color: var(--gray-500);
}

.stats-row {
  display: flex;
  align-items: center;
  justify-content: space-around;
  gap: 2rem;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
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

.stat-divider {
  width: 1px;
  height: 60px;
  background: var(--gray-200);
}

.transactions-card h3 {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--gray-900);
}

.amount-cell {
  font-weight: 600;
  font-size: 1rem;
}

.amount-cell.positive {
  color: var(--success);
}

.amount-cell.negative {
  color: var(--error);
}

@media (max-width: 768px) {
  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .credits-overview {
    grid-template-columns: 1fr;
  }

  .balance-content {
    flex-direction: column;
    text-align: center;
  }

  .stats-row {
    flex-direction: column;
    gap: 1.5rem;
  }

  .stat-divider {
    display: none;
  }
}
</style>
