<template>
  <div class="landing-page">
    <!-- Navigation Bar -->
    <nav class="landing-nav">
      <div class="nav-content">
        <AppLogo size="large" />
        <NuxtLink to="/login" class="login-link">
          <Button label="Entrar" outlined icon="pi pi-sign-in" />
        </NuxtLink>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background-effects">
        <div class="gradient-orb orb-1"></div>
        <div class="gradient-orb orb-2"></div>
        <div class="gradient-orb orb-3"></div>
        <div class="grid-pattern"></div>
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">
            Automatize documentos jurídicos com <span class="highlight">Inteligência Artificial</span>
          </h1>
          <p class="hero-subtitle">
            Plataforma multitenant que acelera a produção de documentos jurídicos com IA,
            economizando tempo e reduzindo custos para escritórios de advocacia.
          </p>
          <div class="hero-stats">
            <div class="stat-item">
              <div class="stat-number">10x</div>
              <div class="stat-label">Mais Rápido</div>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <div class="stat-number">95%</div>
              <div class="stat-label">Economia de Tempo</div>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <div class="stat-number">24/7</div>
              <div class="stat-label">Disponível</div>
            </div>
          </div>
          <div class="hero-cta">
            <a href="#contato">
              <Button label="Fale Conosco" size="large" class="cta-primary" icon="pi pi-comments" iconPos="right" />
            </a>
            <a href="#contato">
              <Button label="Contratar Agora" size="large" class="cta-secondary" outlined icon="pi pi-check" />
            </a>
          </div>
        </div>
        <div class="hero-visual">
          <div class="floating-cards">
            <div class="hero-card card-1">
              <div class="card-header">
                <i class="pi pi-bolt"></i>
                <span class="card-status">Processando...</span>
              </div>
              <h3>Petição Inicial - Trabalhista</h3>
              <p>Gera petições iniciais completas em segundos</p>
              <div class="card-progress">
                <div class="progress-bar"></div>
              </div>
              <div class="card-meta">
                <span><i class="pi pi-wallet"></i> 12.50 créditos</span>
                <Button label="Executar" size="small" />
              </div>
            </div>
            <div class="hero-card card-2">
              <div class="mini-card-content">
                <i class="pi pi-check-circle"></i>
                <span>Petição inicial gerada com sucesso</span>
              </div>
            </div>
            <div class="hero-card card-3">
              <div class="mini-card-content">
                <i class="pi pi-clock"></i>
                <span>Tempo médio: 8s</span>
              </div>
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
        <h2>Planos para Escritórios</h2>
        <p>Escolha o plano ideal para as necessidades do seu escritório</p>
      </div>

      <div class="pricing-cards">
        <div class="pricing-card featured">
          <div class="popular-badge">Plano Padrão</div>
          <h3>Escritórios</h3>
          <div class="price">
            <span class="currency">R$</span>
            <span class="amount">3.000</span>
            <span class="period">/mês</span>
          </div>
          <ul class="features-list">
            <li><i class="pi pi-check"></i> 300 créditos/mês</li>
            <li><i class="pi pi-check"></i> Usuários ilimitados</li>
            <li><i class="pi pi-check"></i> Todas as automações</li>
            <li><i class="pi pi-check"></i> Suporte prioritário</li>
            <li><i class="pi pi-check"></i> Analytics avançado</li>
          </ul>
          <a href="#contato">
            <Button label="Contratar" class="plan-button" />
          </a>
        </div>

        <div class="pricing-card">
          <h3>Personalizado</h3>
          <div class="price">
            <span class="amount">Sob Consulta</span>
          </div>
          <ul class="features-list">
            <li><i class="pi pi-check"></i> Créditos personalizados</li>
            <li><i class="pi pi-check"></i> Usuários ilimitados</li>
            <li><i class="pi pi-check"></i> Infraestrutura dedicada</li>
            <li><i class="pi pi-check"></i> SLA garantido</li>
            <li><i class="pi pi-check"></i> Gerente de conta dedicado</li>
          </ul>
          <a href="#contato">
            <Button label="Fale Conosco" outlined class="plan-button" />
          </a>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contato" class="contact-section">
      <div class="contact-content">
        <div class="contact-header">
          <h2>Fale Conosco</h2>
          <p>Entre em contato com nossa equipe para contratar ou esclarecer dúvidas</p>
        </div>

        <div class="contact-methods">
          <a href="https://wa.me/5511999999999" target="_blank" class="contact-card">
            <div class="contact-icon">
              <i class="pi pi-whatsapp"></i>
            </div>
            <h3>WhatsApp</h3>
            <p>(11) 99999-9999</p>
          </a>

          <a href="mailto:contato@lextech.com.br" class="contact-card">
            <div class="contact-icon">
              <i class="pi pi-envelope"></i>
            </div>
            <h3>E-mail</h3>
            <p>contato@lextech.com.br</p>
          </a>

          <a href="tel:+551133333333" class="contact-card">
            <div class="contact-icon">
              <i class="pi pi-phone"></i>
            </div>
            <h3>Telefone</h3>
            <p>(11) 3333-3333</p>
          </a>
        </div>

        <div class="social-links">
          <h3>Siga-nos nas redes sociais</h3>
          <div class="social-icons">
            <a href="https://linkedin.com/company/lextech" target="_blank" aria-label="LinkedIn">
              <i class="pi pi-linkedin"></i>
            </a>
            <a href="https://instagram.com/lextech" target="_blank" aria-label="Instagram">
              <i class="pi pi-instagram"></i>
            </a>
            <a href="https://facebook.com/lextech" target="_blank" aria-label="Facebook">
              <i class="pi pi-facebook"></i>
            </a>
            <a href="https://twitter.com/lextech" target="_blank" aria-label="Twitter">
              <i class="pi pi-twitter"></i>
            </a>
          </div>
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
  min-height: 100vh;
  height: 100vh;
  background: linear-gradient(135deg, var(--law-red-900) 0%, var(--law-red-700) 100%);
  padding: 6rem 2rem 2rem;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.hero-background-effects {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  overflow: hidden;
}

.gradient-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.3;
  animation: float-orb 20s ease-in-out infinite;
}

.orb-1 {
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.4) 0%, transparent 70%);
  top: -250px;
  left: -200px;
  animation-delay: 0s;
}

.orb-2 {
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(255, 200, 200, 0.3) 0%, transparent 70%);
  top: 50%;
  right: -150px;
  animation-delay: 7s;
}

.orb-3 {
  width: 350px;
  height: 350px;
  background: radial-gradient(circle, rgba(148, 163, 184, 0.3) 0%, transparent 70%);
  bottom: -100px;
  left: 30%;
  animation-delay: 14s;
}

@keyframes float-orb {
  0%, 100% {
    transform: translate(0, 0) scale(1);
  }
  33% {
    transform: translate(50px, -50px) scale(1.1);
  }
  66% {
    transform: translate(-30px, 30px) scale(0.9);
  }
}

.grid-pattern {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
  background-size: 50px 50px;
  opacity: 0.5;
}

.hero-content {
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
  position: relative;
  z-index: 1;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 0.4rem 0.875rem;
  border-radius: 50px;
  color: white;
  font-size: 0.8rem;
  font-weight: 600;
  margin-bottom: 1rem;
  animation: fade-in-up 0.8s ease-out;
}

.hero-badge i {
  font-size: 1rem;
  animation: sparkle 2s ease-in-out infinite;
}

@keyframes sparkle {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.7; transform: scale(1.2); }
}

@keyframes fade-in-up {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-title {
  font-size: 2.75rem;
  font-weight: 800;
  color: white;
  line-height: 1.2;
  margin-bottom: 1rem;
  animation: fade-in-up 0.8s ease-out 0.2s both;
}

.hero-title .highlight {
  background: linear-gradient(135deg, #e5e7eb 0%, #fff 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  position: relative;
  display: inline-block;
}

.hero-title .highlight::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 100%;
  height: 3px;
  background: linear-gradient(90deg, transparent 0%, rgba(148, 163, 184, 0.8) 20%, white 50%, rgba(148, 163, 184, 0.8) 80%, transparent 100%);
  animation: shimmer 3s ease-in-out infinite;
}

@keyframes shimmer {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 1; }
}

.hero-subtitle {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.9);
  line-height: 1.5;
  margin-bottom: 1.5rem;
  animation: fade-in-up 0.8s ease-out 0.4s both;
}

.hero-stats {
  display: flex;
  align-items: center;
  gap: 1.25rem;
  margin-bottom: 2rem;
  padding: 1.25rem;
  background: linear-gradient(135deg, rgba(51, 65, 85, 0.15) 0%, rgba(148, 163, 184, 0.1) 100%);
  backdrop-filter: blur(10px);
  border: 2px solid rgba(148, 163, 184, 0.4);
  border-radius: 16px;
  animation: fade-in-up 0.8s ease-out 0.6s both;
  box-shadow: 0 8px 16px rgba(30, 41, 59, 0.2);
}

.stat-item {
  flex: 1;
  text-align: center;
}

.stat-number {
  font-size: 1.75rem;
  font-weight: 800;
  color: white;
  margin-bottom: 0.25rem;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.stat-label {
  font-size: 0.8rem;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 500;
}

.stat-divider {
  width: 1px;
  height: 35px;
  background: rgba(255, 255, 255, 0.2);
}

.hero-cta {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  animation: fade-in-up 0.8s ease-out 0.8s both;
}

.hero-cta a {
  text-decoration: none;
  transition: transform 0.3s ease;
}

.hero-cta a:hover {
  transform: translateY(-2px);
}

.cta-primary {
  background: white;
  border-color: white;
  color: var(--law-red-900);
  font-weight: 600;
  padding: 0.875rem 1.75rem;
}

.cta-primary:hover {
  background: #e5e7eb;
  border-color: #e5e7eb;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.cta-secondary {
  background: transparent;
  border: 2px solid rgba(148, 163, 184, 0.4);
  color: white;
  font-weight: 600;
  padding: 0.875rem 1.75rem;
}

.cta-secondary:hover {
  background: rgba(148, 163, 184, 0.15);
  border-color: rgba(148, 163, 184, 0.6);
  transform: translateY(-2px);
}

.hero-visual {
  display: flex;
  justify-content: center;
  align-items: center;
  animation: fade-in 1s ease-out 0.5s both;
}

@keyframes fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

.floating-cards {
  position: relative;
  width: 100%;
  max-width: 400px;
  height: 420px;
}

.hero-card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  position: absolute;
  transition: all 0.3s ease;
  border: 1px solid rgba(148, 163, 184, 0.1);
}

.hero-card:hover {
  transform: translateY(-5px) !important;
  box-shadow: 0 25px 70px rgba(0, 0, 0, 0.4);
}

.card-1 {
  width: 100%;
  padding: 1.5rem;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 3;
  animation: float-main 6s ease-in-out infinite;
}

@keyframes float-main {
  0%, 100% { transform: translate(-50%, -50%) translateY(0px); }
  50% { transform: translate(-50%, -50%) translateY(-15px); }
}

.card-2 {
  width: 240px;
  padding: 1rem;
  top: 5%;
  right: -10px;
  z-index: 2;
  animation: float-card-2 8s ease-in-out infinite;
}

@keyframes float-card-2 {
  0%, 100% { transform: translateY(0px) rotate(2deg); }
  50% { transform: translateY(-20px) rotate(-2deg); }
}

.card-3 {
  width: 220px;
  padding: 1rem;
  bottom: 5%;
  left: -30px;
  z-index: 1;
  animation: float-card-3 7s ease-in-out infinite;
}

@keyframes float-card-3 {
  0%, 100% { transform: translateY(0px) rotate(-2deg); }
  50% { transform: translateY(15px) rotate(2deg); }
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.card-header i {
  font-size: 1.75rem;
  color: var(--law-red-700);
}

.card-status {
  font-size: 0.7rem;
  color: var(--law-red-700);
  font-weight: 600;
  padding: 0.25rem 0.65rem;
  background: rgba(153, 27, 27, 0.1);
  border-radius: 20px;
  animation: pulse-status 2s ease-in-out infinite;
}

@keyframes pulse-status {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.6; }
}

.hero-card h3 {
  font-size: 1.1rem;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.hero-card p {
  color: var(--gray-600);
  font-size: 0.875rem;
  margin-bottom: 1rem;
}

.card-progress {
  margin-bottom: 1rem;
  height: 6px;
  background: var(--gray-200);
  border-radius: 10px;
  overflow: hidden;
}

.progress-bar {
  height: 100%;
  width: 70%;
  background: linear-gradient(90deg, var(--law-red-600), var(--law-red-700));
  border-radius: 10px;
  animation: progress-animate 3s ease-in-out infinite;
}

@keyframes progress-animate {
  0% { width: 0%; }
  50% { width: 70%; }
  100% { width: 100%; }
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
  font-size: 0.875rem;
}

.card-meta i {
  font-size: 1rem;
  color: var(--law-red-700);
  margin: 0;
}

.mini-card-content {
  display: flex;
  align-items: center;
  gap: 0.65rem;
  font-size: 0.8rem;
  color: var(--gray-700);
  font-weight: 500;
}

.mini-card-content i {
  font-size: 1.25rem;
  color: var(--law-red-700);
}

.card-2 .mini-card-content i {
  color: #10b981;
}

.card-3 .mini-card-content i {
  color: #334155;
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

.pricing-card a {
  display: block;
  text-decoration: none;
}

.plan-button {
  width: 100%;
  padding: 0.875rem;
  font-weight: 600;
}

/* Contact Section */
.contact-section {
  padding: 6rem 2rem;
  background: white;
}

.contact-content {
  max-width: 1200px;
  margin: 0 auto;
}

.contact-header {
  text-align: center;
  margin-bottom: 4rem;
}

.contact-header h2 {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--gray-900);
  margin-bottom: 1rem;
}

.contact-header p {
  font-size: 1.125rem;
  color: var(--gray-600);
}

.contact-methods {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin-bottom: 4rem;
}

.contact-card {
  background: white;
  padding: 2.5rem 2rem;
  border-radius: 12px;
  border: 2px solid var(--gray-200);
  text-align: center;
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.contact-card:hover {
  border-color: var(--law-red-700);
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(153, 27, 27, 0.15);
}

.contact-icon {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, var(--law-red-700) 0%, var(--law-red-800) 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  box-shadow: 0 4px 12px rgba(153, 27, 27, 0.3);
}

.contact-icon i {
  font-size: 2rem;
  color: white;
}

.contact-card h3 {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.contact-card p {
  font-size: 1.125rem;
  color: var(--law-red-700);
  font-weight: 500;
}

.social-links {
  text-align: center;
  padding-top: 3rem;
  border-top: 1px solid var(--gray-200);
}

.social-links h3 {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 1.5rem;
}

.social-icons {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  flex-wrap: wrap;
}

.social-icons a {
  width: 56px;
  height: 56px;
  background: var(--gray-100);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gray-700);
  text-decoration: none;
  transition: all 0.3s ease;
}

.social-icons a:hover {
  background: var(--law-red-700);
  color: white;
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(153, 27, 27, 0.3);
}

.social-icons i {
  font-size: 1.5rem;
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

  .hero-badge {
    margin-left: auto;
    margin-right: auto;
  }

  .hero-stats {
    margin-left: auto;
    margin-right: auto;
    max-width: 500px;
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
  .hero-section {
    padding: 6rem 1.5rem 3rem;
  }

  .hero-title {
    font-size: 2.5rem;
  }

  .hero-subtitle {
    font-size: 1.125rem;
  }

  .hero-stats {
    flex-direction: column;
    gap: 1rem;
    padding: 1.25rem;
  }

  .stat-divider {
    width: 100%;
    height: 1px;
  }

  .hero-cta {
    flex-direction: column;
    width: 100%;
  }

  .hero-cta a {
    width: 100%;
  }

  .hero-cta a button {
    width: 100%;
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
