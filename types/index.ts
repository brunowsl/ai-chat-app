export interface User {
  id: string
  name: string
  email: string
  role: 'company_admin' | 'company_user' | 'super_admin'
  companyId: string
  companyName: string
  isActive: boolean
}

export interface Company {
  id: string
  name: string
  slug: string
  creditsBalance: number
  creditsTotalPurchased: number
  creditsTotalConsumed: number
  isActive: boolean
}

export interface Automation {
  id: string
  name: string
  description: string
  estimatedCredits: number
  isActive: boolean
  companyId: string
}

export interface AutomationExecution {
  id: string
  automationName: string
  status: 'pending' | 'running' | 'completed' | 'failed'
  creditsConsumed: number
  createdAt: string
  completedAt?: string
}

export interface AuthState {
  user: User | null
  isAuthenticated: boolean
}
