import type { Company } from '~/types'

export const useCompany = () => {
  const company = useState<Company | null>('company', () => null)

  const fetchCompany = async () => {
    // Mock data - em produção, buscará da API
    await new Promise(resolve => setTimeout(resolve, 500))

    company.value = {
      id: 'company-1',
      name: 'Silva & Associados',
      slug: 'silva-associados',
      creditsBalance: 2450.50,
      creditsTotalPurchased: 5000,
      creditsTotalConsumed: 2549.50,
      isActive: true
    }

    return company.value
  }

  return {
    company: readonly(company),
    fetchCompany
  }
}
