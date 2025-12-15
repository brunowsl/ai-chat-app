<template>
  <div class="landing-page">
    <!-- Navigation Bar -->
    <nav class="landing-nav">
      <div class="nav-content">
        <AppLogo size="small" />
        <NuxtLink to="/login" class="login-link">
          <Button label="Entrar" outlined icon="pi pi-sign-in" />
        </NuxtLink>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-content">
        <div class="hero-text">
          <AppLogo size="large" class="hero-logo" />
          <h1 class="hero-title">
            Automatize documentos jurídicos com <span class="highlight">Inteligência Artificial</span>
          </h1>
          <p class="hero-subtitle">
            Plataforma multitenant que acelera a produção de documentos jurídicos com IA,
            economizando tempo e reduzindo custos para escritórios de advocacia.
          </p>
          <div class="hero-cta">
            <NuxtLink to="/login">
              <Button label="Começar Agora" size="large" class="cta-primary" icon="pi pi-arrow-right" iconPos="right" />
            </NuxtLink>
            <Button label="Agendar Demo" size="large" class="cta-secondary" outlined icon="pi pi-video" />
          </div>
        </div>
        <div class="hero-visual">
          <div class="hero-card">
            <i class="pi pi-bolt"></i>
            <h3>Petição Inicial - Trabalhista</h3>
            <p>Gera petições iniciais completas em segundos</p>
            <div class="card-meta">
              <span><i class="pi pi-wallet"></i> 12.50 créditos</span>
              <Button label="Executar" size="small" />
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
      <div class="section-header">
        <h2>Recursos Poderosos para Escritórios Modernos</h2>
        <p>Tudo que você precisa para automatizar a produção de documentos jurídicos</p>
      </div>

      <div class="features-grid">
        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-bolt"></i>
          </div>
          <h3>Automações Customizadas</h3>
          <p>Crie automações personalizadas com workflows dedicados para sua empresa</p>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-shield"></i>
          </div>
          <h3>Multitenant Seguro</h3>
          <p>Isolamento completo de dados entre empresas com autenticação segura</p>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-wallet"></i>
          </div>
          <h3>Sistema de Créditos</h3>
          <p>Pague apenas pelo que usar com precificação baseada em tokens de IA</p>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-users"></i>
          </div>
          <h3>Gestão de Equipe</h3>
          <p>Controle de acesso com permissões de administrador e usuário padrão</p>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-chart-bar"></i>
          </div>
          <h3>Analytics Detalhado</h3>
          <p>Monitore uso de créditos por usuário e visualize métricas da empresa</p>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="pi pi-clock"></i>
          </div>
          <h3>Histórico Completo</h3>
          <p>Acesse histórico de execuções e documentos gerados a qualquer momento</p>
        </div>
      </div>
    </section>

    <!-- How It Works Section -->
    <section class="how-it-works-section">
      <div class="section-header">
        <h2>Como Funciona</h2>
        <p>Simples, rápido e eficiente</p>
      </div>

      <div class="steps">
        <div class="step">
          <div class="step-number">1</div>
          <div class="step-content">
            <h3>Escolha a Automação</h3>
            <p>Selecione dentre as automações pré-configuradas para seu escritório</p>
          </div>
        </div>

        <div class="step">
          <div class="step-number">2</div>
          <div class="step-content">
            <h3>Forneça os Dados</h3>
            <p>Preencha as informações necessárias através de formulários intuitivos</p>
          </div>
        </div>

        <div class="step">
          <div class="step-number">3</div>
          <div class="step-content">
            <h3>Gere o Documento</h3>
            <p>A IA processa e gera seu documento jurídico em segundos</p>
          </div>
        </div>

        <div class="step">
          <div class="step-number">4</div>
          <div class="step-content">
            <h3>Revise e Use</h3>
            <p>Copie o resultado para área de transferência e utilize imediatamente</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section class="pricing-section">
      <div class="section-header">
        <h2>Planos Flexíveis</h2>
        <p>Pague apenas pelo que usar com nosso sistema de créditos</p>
      </div>

      <div class="pricing-cards">
        <div class="pricing-card">
          <h3>Starter</h3>
          <div class="price">
            <span class="currency">R$</span>
            <span class="amount">499</span>
            <span class="period">/mês</span>
          </div>
          <ul class="features-list">
            <li><i class="pi pi-check"></i> 5.000 créditos/mês</li>
            <li><i class="pi pi-check"></i> Até 10 usuários</li>
            <li><i class="pi pi-check"></i> Automações básicas</li>
            <li><i class="pi pi-check"></i> Suporte por email</li>
          </ul>
          <Button label="Começar" outlined class="plan-button" />
        </div>

        <div class="pricing-card featured">
          <div class="popular-badge">Mais Popular</div>
          <h3>Professional</h3>
          <div class="price">
            <span class="currency">R$</span>
            <span class="amount">1.499</span>
            <span class="period">/mês</span>
          </div>
          <ul class="features-list">
            <li><i class="pi pi-check"></i> 20.000 créditos/mês</li>
            <li><i class="pi pi-check"></i> Usuários ilimitados</li>
            <li><i class="pi pi-check"></i> Automações customizadas</li>
            <li><i class="pi pi-check"></i> Suporte prioritário</li>
            <li><i class="pi pi-check"></i> Analytics avançado</li>
          </ul>
          <Button label="Começar" class="plan-button" />
        </div>

        <div class="pricing-card">
          <h3>Enterprise</h3>
          <div class="price">
            <span class="amount">Personalizado</span>
          </div>
          <ul class="features-list">
            <li><i class="pi pi-check"></i> Créditos personalizados</li>
            <li><i class="pi pi-check"></i> Usuários ilimitados</li>
            <li><i class="pi pi-check"></i> Infraestrutura dedicada</li>
            <li><i class="pi pi-check"></i> SLA garantido</li>
            <li><i class="pi pi-check"></i> Gerente de conta dedicado</li>
          </ul>
          <Button label="Fale Conosco" outlined class="plan-button" />
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-content">
        <h2>Pronto para transformar seu escritório?</h2>
        <p>Junte-se a centenas de escritórios que já automatizam documentos com Lexia</p>
        <div class="cta-buttons">
          <NuxtLink to="/login">
            <Button label="Criar Conta Grátis" size="large" class="cta-primary" icon="pi pi-user-plus" />
          </NuxtLink>
          <Button label="Agendar Demonstração" size="large" outlined class="cta-secondary" icon="pi pi-calendar" />
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
      <div class="footer-content">
        <div class="footer-brand">
          <AppLogo size="small" />
          <p>Automatize documentos jurídicos com Inteligência Artificial</p>
        </div>
        <div class="footer-links">
          <div class="link-group">
            <h4>Produto</h4>
            <a href="#">Recursos</a>
            <a href="#">Preços</a>
            <a href="#">Demo</a>
          </div>
          <div class="link-group">
            <h4>Empresa</h4>
            <a href="#">Sobre</a>
            <a href="#">Blog</a>
            <a href="#">Contato</a>
          </div>
          <div class="link-group">
            <h4>Suporte</h4>
            <a href="#">Documentação</a>
            <a href="#">FAQ</a>
            <a href="#">Status</a>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; {{ new Date().getFullYear() }} Lexia by LEXTECH. Todos os direitos reservados.</p>
        <div class="footer-legal">
          <a href="#">Termos de Uso</a>
          <a href="#">Política de Privacidade</a>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: false
})
</script>

<style scoped>
.landing-page {
  background: white;
  overflow-x: hidden;
}

/* Navigation */
.landing-nav {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--gray-200);
  padding: 1rem 2rem;
  z-index: 1000;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.login-link {
  text-decoration: none;
}

/* Hero Section */
.hero-section {
  min-height: 90vh;
  background: linear-gradient(135deg, var(--law-red-900) 0%, var(--law-red-700) 100%);
  padding: 8rem 2rem 4rem;
  position: relative;
  overflow: hidden;
}

.hero-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background:
    radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
  pointer-events: none;
}

.hero-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
  position: relative;
  z-index: 1;
}

.hero-logo {
  margin-bottom: 2rem;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  color: white;
  line-height: 1.2;
  margin-bottom: 1.5rem;
}

.hero-title .highlight {
  background: linear-gradient(135deg, #e5e7eb 0%, #fff 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.9);
  line-height: 1.6;
  margin-bottom: 2rem;
}

.hero-cta {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.cta-primary {
  background: white;
  border-color: white;
  color: var(--law-red-900);
  font-weight: 600;
  padding: 1rem 2rem;
}

.cta-primary:hover {
  background: #f9fafb;
  border-color: #f9fafb;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(255, 255, 255, 0.3);
}

.cta-secondary {
  background: transparent;
  border-color: white;
  color: white;
  font-weight: 600;
  padding: 1rem 2rem;
}

.cta-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: white;
  transform: translateY(-2px);
}

.hero-visual {
  display: flex;
  justify-content: center;
  align-items: center;
}

.hero-card {
  background: white;
  padding: 2rem;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  max-width: 400px;
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

.hero-card i {
  font-size: 2.5rem;
  color: var(--law-red-700);
  margin-bottom: 1rem;
}

.hero-card h3 {
  font-size: 1.25rem;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.hero-card p {
  color: var(--gray-600);
  font-size: 0.95rem;
  margin-bottom: 1.5rem;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 1rem;
  border-top: 1px solid var(--gray-200);
}

.card-meta span {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--gray-700);
  font-weight: 500;
}

.card-meta i {
  font-size: 1rem;
  color: var(--law-red-700);
  margin: 0;
}

/* Features Section */
.features-section {
  padding: 6rem 2rem;
  background: var(--gray-50);
}

.section-header {
  text-align: center;
  max-width: 700px;
  margin: 0 auto 4rem;
}

.section-header h2 {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--gray-900);
  margin-bottom: 1rem;
}

.section-header p {
  font-size: 1.125rem;
  color: var(--gray-600);
}

.features-grid {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.feature-card {
  background: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
}

.feature-icon {
  width: 64px;
  height: 64px;
  background: linear-gradient(135deg, var(--law-red-700) 0%, var(--law-red-800) 100%);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  box-shadow: 0 4px 12px rgba(153, 27, 27, 0.3);
}

.feature-icon i {
  font-size: 1.75rem;
  color: white;
}

.feature-card h3 {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 0.75rem;
}

.feature-card p {
  color: var(--gray-600);
  line-height: 1.6;
}

/* How It Works Section */
.how-it-works-section {
  padding: 6rem 2rem;
  background: white;
}

.steps {
  max-width: 900px;
  margin: 0 auto;
  display: grid;
  gap: 3rem;
}

.step {
  display: flex;
  gap: 2rem;
  align-items: flex-start;
}

.step-number {
  width: 64px;
  height: 64px;
  background: linear-gradient(135deg, var(--gray-600) 0%, var(--gray-700) 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  flex-shrink: 0;
  box-shadow: 0 4px 12px rgba(75, 85, 99, 0.3);
}

.step-content h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.step-content p {
  color: var(--gray-600);
  font-size: 1.125rem;
  line-height: 1.6;
}

/* Pricing Section */
.pricing-section {
  padding: 6rem 2rem;
  background: var(--gray-50);
}

.pricing-cards {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.pricing-card {
  background: white;
  padding: 2.5rem;
  border-radius: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  position: relative;
  transition: all 0.3s ease;
}

.pricing-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
}

.pricing-card.featured {
  border: 2px solid var(--law-red-700);
  transform: scale(1.05);
}

.popular-badge {
  position: absolute;
  top: -12px;
  right: 20px;
  background: linear-gradient(135deg, var(--law-red-700) 0%, var(--law-red-800) 100%);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: 600;
}

.pricing-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 1rem;
}

.price {
  margin-bottom: 2rem;
}

.currency {
  font-size: 1.25rem;
  color: var(--gray-600);
  vertical-align: super;
}

.amount {
  font-size: 3rem;
  font-weight: 700;
  color: var(--law-red-700);
}

.period {
  font-size: 1.125rem;
  color: var(--gray-600);
}

.features-list {
  list-style: none;
  padding: 0;
  margin: 0 0 2rem 0;
}

.features-list li {
  padding: 0.75rem 0;
  color: var(--gray-700);
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.features-list i {
  color: var(--law-red-700);
  font-size: 1.125rem;
}

.plan-button {
  width: 100%;
  padding: 0.875rem;
  font-weight: 600;
}

/* CTA Section */
.cta-section {
  padding: 6rem 2rem;
  background: linear-gradient(135deg, var(--law-red-900) 0%, var(--law-red-700) 100%);
  text-align: center;
}

.cta-content {
  max-width: 800px;
  margin: 0 auto;
}

.cta-content h2 {
  font-size: 2.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 1rem;
}

.cta-content p {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 2rem;
}

.cta-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

/* Footer */
.footer {
  background: var(--gray-900);
  color: white;
  padding: 4rem 2rem 2rem;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 2fr 3fr;
  gap: 4rem;
  margin-bottom: 3rem;
}

.footer-brand p {
  color: var(--gray-400);
  margin-top: 1rem;
  line-height: 1.6;
}

.footer-links {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
}

.link-group h4 {
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: white;
}

.link-group a {
  display: block;
  color: var(--gray-400);
  text-decoration: none;
  padding: 0.5rem 0;
  transition: color 0.2s ease;
}

.link-group a:hover {
  color: white;
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  padding-top: 2rem;
  border-top: 1px solid var(--gray-700);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.footer-bottom p {
  color: var(--gray-400);
  font-size: 0.875rem;
}

.footer-legal {
  display: flex;
  gap: 2rem;
}

.footer-legal a {
  color: var(--gray-400);
  text-decoration: none;
  font-size: 0.875rem;
  transition: color 0.2s ease;
}

.footer-legal a:hover {
  color: white;
}

/* Responsive */
@media (max-width: 1024px) {
  .hero-content {
    grid-template-columns: 1fr;
    text-align: center;
  }

  .hero-visual {
    display: none;
  }

  .hero-cta {
    justify-content: center;
  }

  .footer-content {
    grid-template-columns: 1fr;
  }

  .footer-links {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }

  .section-header h2 {
    font-size: 2rem;
  }

  .pricing-card.featured {
    transform: none;
  }

  .footer-links {
    grid-template-columns: 1fr;
  }

  .footer-bottom {
    flex-direction: column;
    text-align: center;
  }
}
</style>
