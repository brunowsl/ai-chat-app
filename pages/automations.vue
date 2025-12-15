<template>
  <div class="automations-page">
    <div class="page-header">
      <div>
        <h1>Automações</h1>
        <p class="subtitle">Execute suas automações de documentos jurídicos</p>
      </div>
    </div>

    <div class="automations-grid">
      <Card
        v-for="automation in automations"
        :key="automation.id"
        class="automation-card"
      >
        <template #header>
          <div class="automation-header">
            <i class="pi pi-bolt"></i>
            <Tag
              v-if="automation.isActive"
              value="Ativo"
              severity="success"
            />
            <Tag
              v-else
              value="Inativo"
              severity="secondary"
            />
          </div>
        </template>
        <template #title>
          <h3>{{ automation.name }}</h3>
        </template>
        <template #content>
          <p class="automation-description">{{ automation.description }}</p>
        </template>
        <template #footer>
          <div class="automation-footer">
            <div class="credits-info">
              <i class="pi pi-wallet"></i>
              <span>{{ formatCredits(automation.estimatedCredits) }} créditos</span>
            </div>
            <Button
              label="Executar"
              icon="pi pi-play"
              class="execute-button"
              @click="executeAutomation(automation.id)"
            />
          </div>
        </template>
      </Card>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { Automation } from '~/types'

const automations = ref<Automation[]>([
  {
    id: '1',
    name: 'Petição Inicial - Trabalhista',
    description: 'Gera petições iniciais para processos trabalhistas com base em dados fornecidos',
    estimatedCredits: 12.5,
    isActive: true,
    companyId: 'company-1'
  },
  {
    id: '2',
    name: 'Contrato de Prestação de Serviços',
    description: 'Cria contratos personalizados de prestação de serviços jurídicos',
    estimatedCredits: 8.3,
    isActive: true,
    companyId: 'company-1'
  },
  {
    id: '3',
    name: 'Recurso Ordinário',
    description: 'Elabora recursos ordinários com fundamentação jurídica completa',
    estimatedCredits: 15.2,
    isActive: true,
    companyId: 'company-1'
  },
  {
    id: '4',
    name: 'Contestação',
    description: 'Gera contestações com análise detalhada dos fatos e direito',
    estimatedCredits: 10.8,
    isActive: false,
    companyId: 'company-1'
  }
])

const formatCredits = (value: number) => {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value)
}

const executeAutomation = (id: string) => {
  // Implementar execução de automação
  console.log('Executar automação:', id)
}
</script>

<style scoped>
.automations-page {
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

.automations-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}

.automation-card {
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  transition: all 0.2s ease;
  display: flex;
  flex-direction: column;
}

.automation-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.automation-card :deep(.p-card-body) {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.automation-card :deep(.p-card-content) {
  flex: 1;
}

.automation-card :deep(.p-card-footer) {
  margin-top: auto;
  padding-top: 0;
}

.automation-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background: var(--gray-50);
  border-bottom: 1px solid var(--gray-200);
}

.automation-header i {
  font-size: 1.5rem;
  color: var(--law-red-700);
}

.automation-card h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.automation-description {
  color: var(--gray-600);
  font-size: 0.9rem;
  line-height: 1.5;
}

.automation-footer {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding-top: 1rem;
  border-top: 1px solid var(--gray-200);
}

.credits-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--gray-700);
  font-size: 0.9rem;
  font-weight: 500;
}

.credits-info i {
  color: var(--law-gold);
  font-size: 1rem;
}

.execute-button {
  width: 100%;
  background-color: var(--law-red-700);
  border-color: var(--law-red-700);
  font-weight: 600;
}

.execute-button:hover {
  background-color: var(--law-red-800);
  border-color: var(--law-red-800);
}

@media (max-width: 640px) {
  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .automations-grid {
    grid-template-columns: 1fr;
  }
}
</style>
