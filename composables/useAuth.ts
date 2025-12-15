import type { User, AuthState } from '~/types'

export const useAuth = () => {
  const authState = useState<AuthState>('auth', () => ({
    user: null,
    isAuthenticated: false
  }))

  const login = async (email: string, password: string) => {
    // Mock login - em produção, integrará com Keycloak
    await new Promise(resolve => setTimeout(resolve, 1000))

    // Dados mockados
    const mockUser: User = {
      id: '1',
      name: 'João Silva',
      email: email,
      role: 'company_user',
      companyId: 'company-1',
      companyName: 'Silva & Associados',
      isActive: true
    }

    authState.value = {
      user: mockUser,
      isAuthenticated: true
    }

    return mockUser
  }

  const logout = () => {
    authState.value = {
      user: null,
      isAuthenticated: false
    }
  }

  return {
    authState: readonly(authState),
    login,
    logout
  }
}
