-- ============================================
-- Schema para Sistema Multitenant - LexTech Chat
-- Database: PostgreSQL
-- ============================================

-- Extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================
-- Tabela: companies
-- Descrição: Armazena informações das empresas (tenants)
-- ============================================
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    keycloak_company_id VARCHAR(255) UNIQUE,
    credits_balance DECIMAL(20, 8) NOT NULL DEFAULT 0 CHECK (credits_balance >= 0),
    credits_total_purchased DECIMAL(20, 8) NOT NULL DEFAULT 0,
    credits_total_consumed DECIMAL(20, 8) NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Índices para companies
CREATE INDEX idx_companies_slug ON companies(slug);
CREATE INDEX idx_companies_is_active ON companies(is_active);
CREATE INDEX idx_companies_keycloak_id ON companies(keycloak_company_id);

-- Comentários
COMMENT ON TABLE companies IS 'Empresas (tenants) cadastradas no sistema';
COMMENT ON COLUMN companies.credits_balance IS 'Saldo atual de créditos disponíveis';
COMMENT ON COLUMN companies.credits_total_purchased IS 'Total histórico de créditos comprados';
COMMENT ON COLUMN companies.credits_total_consumed IS 'Total histórico de créditos consumidos';

-- ============================================
-- Tabela: users
-- Descrição: Usuários do sistema vinculados a empresas
-- ============================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    keycloak_user_id VARCHAR(255) UNIQUE NOT NULL,
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'company_user',
    is_active BOOLEAN NOT NULL DEFAULT true,
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_email_per_company UNIQUE(email, company_id)
);

-- Índices para users
CREATE INDEX idx_users_company_id ON users(company_id);
CREATE INDEX idx_users_keycloak_id ON users(keycloak_user_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_is_active ON users(is_active);

-- Comentários
COMMENT ON TABLE users IS 'Usuários do sistema vinculados a empresas';
COMMENT ON COLUMN users.role IS 'Role principal: super_admin, company_admin, company_user';

-- ============================================
-- Tabela: llm_models
-- Descrição: Modelos LLM disponíveis e conversão tokens/créditos
-- ============================================
CREATE TABLE llm_models (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL UNIQUE,
    provider VARCHAR(100) NOT NULL,
    credits_per_input_token DECIMAL(20, 8) NOT NULL CHECK (credits_per_input_token > 0),
    credits_per_output_token DECIMAL(20, 8) NOT NULL CHECK (credits_per_output_token > 0),
    cost_per_million_input_tokens DECIMAL(10, 4),
    cost_per_million_output_tokens DECIMAL(10, 4),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Índices para llm_models
CREATE INDEX idx_llm_models_name ON llm_models(name);
CREATE INDEX idx_llm_models_provider ON llm_models(provider);
CREATE INDEX idx_llm_models_is_active ON llm_models(is_active);

-- Comentários
COMMENT ON TABLE llm_models IS 'Modelos LLM disponíveis e configuração de conversão tokens/créditos';
COMMENT ON COLUMN llm_models.credits_per_input_token IS 'Quantidade de créditos que cada token de entrada custa';
COMMENT ON COLUMN llm_models.credits_per_output_token IS 'Quantidade de créditos que cada token de saída custa';
COMMENT ON COLUMN llm_models.cost_per_million_input_tokens IS 'Custo em USD por milhão de tokens de entrada (referência)';
COMMENT ON COLUMN llm_models.cost_per_million_output_tokens IS 'Custo em USD por milhão de tokens de saída (referência)';

-- ============================================
-- Tabela: automations
-- Descrição: Automações disponíveis no sistema
-- ============================================
CREATE TABLE automations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    n8n_workflow_id VARCHAR(255) NOT NULL,
    llm_model_id UUID REFERENCES llm_models(id) ON DELETE SET NULL,
    estimated_tokens BIGINT,
    estimated_credits DECIMAL(20, 8),
    is_active BOOLEAN NOT NULL DEFAULT true,
    input_schema JSONB,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Índices para automations
CREATE INDEX idx_automations_is_active ON automations(is_active);
CREATE INDEX idx_automations_n8n_workflow_id ON automations(n8n_workflow_id);
CREATE INDEX idx_automations_llm_model_id ON automations(llm_model_id);

-- Comentários
COMMENT ON TABLE automations IS 'Automações disponíveis para execução';
COMMENT ON COLUMN automations.llm_model_id IS 'Modelo LLM padrão utilizado por esta automação';
COMMENT ON COLUMN automations.estimated_tokens IS 'Estimativa de tokens que a automação consome';
COMMENT ON COLUMN automations.estimated_credits IS 'Estimativa de créditos (calculado automaticamente)';
COMMENT ON COLUMN automations.input_schema IS 'JSON Schema para validação dos inputs necessários';

-- ============================================
-- Tabela: credit_transactions
-- Descrição: Histórico de transações de créditos
-- ============================================
CREATE TABLE credit_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    automation_id UUID REFERENCES automations(id) ON DELETE SET NULL,
    llm_model_id UUID REFERENCES llm_models(id) ON DELETE SET NULL,
    tokens_used BIGINT,
    amount DECIMAL(20, 8) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Índices para credit_transactions
CREATE INDEX idx_credit_transactions_company_id ON credit_transactions(company_id);
CREATE INDEX idx_credit_transactions_user_id ON credit_transactions(user_id);
CREATE INDEX idx_credit_transactions_automation_id ON credit_transactions(automation_id);
CREATE INDEX idx_credit_transactions_llm_model_id ON credit_transactions(llm_model_id);
CREATE INDEX idx_credit_transactions_type ON credit_transactions(type);
CREATE INDEX idx_credit_transactions_created_at ON credit_transactions(created_at DESC);

-- Comentários
COMMENT ON TABLE credit_transactions IS 'Histórico de todas as transações de créditos';
COMMENT ON COLUMN credit_transactions.llm_model_id IS 'Modelo LLM utilizado na transação';
COMMENT ON COLUMN credit_transactions.tokens_used IS 'Quantidade de tokens utilizados (se aplicável)';
COMMENT ON COLUMN credit_transactions.amount IS 'Quantidade de créditos (positivo = compra/estorno, negativo = consumo)';
COMMENT ON COLUMN credit_transactions.type IS 'Tipo: purchase, consumption, refund, adjustment';

-- ============================================
-- Tabela: automation_executions
-- Descrição: Histórico de execuções de automações
-- ============================================
CREATE TABLE automation_executions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    automation_id UUID NOT NULL REFERENCES automations(id) ON DELETE CASCADE,
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    llm_model_id UUID REFERENCES llm_models(id) ON DELETE SET NULL,
    credit_transaction_id UUID REFERENCES credit_transactions(id) ON DELETE SET NULL,
    tokens_input BIGINT DEFAULT 0,
    tokens_output BIGINT DEFAULT 0,
    tokens_total BIGINT DEFAULT 0,
    credits_consumed DECIMAL(20, 8) DEFAULT 0,
    input_data JSONB NOT NULL,
    output_data JSONB,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    error_message TEXT,
    n8n_execution_id VARCHAR(255),
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Índices para automation_executions
CREATE INDEX idx_automation_executions_automation_id ON automation_executions(automation_id);
CREATE INDEX idx_automation_executions_company_id ON automation_executions(company_id);
CREATE INDEX idx_automation_executions_user_id ON automation_executions(user_id);
CREATE INDEX idx_automation_executions_llm_model_id ON automation_executions(llm_model_id);
CREATE INDEX idx_automation_executions_status ON automation_executions(status);
CREATE INDEX idx_automation_executions_created_at ON automation_executions(created_at DESC);
CREATE INDEX idx_automation_executions_n8n_id ON automation_executions(n8n_execution_id);

-- Comentários
COMMENT ON TABLE automation_executions IS 'Histórico de execuções de automações';
COMMENT ON COLUMN automation_executions.llm_model_id IS 'Modelo LLM utilizado nesta execução';
COMMENT ON COLUMN automation_executions.tokens_input IS 'Tokens de entrada (prompt)';
COMMENT ON COLUMN automation_executions.tokens_output IS 'Tokens de saída (resposta gerada)';
COMMENT ON COLUMN automation_executions.tokens_total IS 'Total de tokens (input + output)';
COMMENT ON COLUMN automation_executions.credits_consumed IS 'Créditos efetivamente consumidos';
COMMENT ON COLUMN automation_executions.status IS 'Status: pending, running, completed, failed';
COMMENT ON COLUMN automation_executions.input_data IS 'Dados de entrada fornecidos pelo usuário';
COMMENT ON COLUMN automation_executions.output_data IS 'Dados de saída retornados pela automação';

-- ============================================
-- Funções e Triggers
-- ============================================

-- Função para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para updated_at
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_automations_updated_at BEFORE UPDATE ON automations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_llm_models_updated_at BEFORE UPDATE ON llm_models
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Função para atualizar saldo de créditos da empresa
CREATE OR REPLACE FUNCTION update_company_credits()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o saldo da empresa
    UPDATE companies
    SET
        credits_balance = credits_balance + NEW.amount,
        credits_total_purchased = CASE
            WHEN NEW.amount > 0 AND NEW.type IN ('purchase', 'adjustment')
            THEN credits_total_purchased + NEW.amount
            ELSE credits_total_purchased
        END,
        credits_total_consumed = CASE
            WHEN NEW.amount < 0 AND NEW.type = 'consumption'
            THEN credits_total_consumed + ABS(NEW.amount)
            ELSE credits_total_consumed
        END
    WHERE id = NEW.company_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar créditos automaticamente
CREATE TRIGGER trigger_update_company_credits
    AFTER INSERT ON credit_transactions
    FOR EACH ROW
    EXECUTE FUNCTION update_company_credits();

-- Função para validar saldo antes de consumir créditos
CREATE OR REPLACE FUNCTION validate_credit_consumption()
RETURNS TRIGGER AS $$
DECLARE
    current_balance DECIMAL(20, 8);
BEGIN
    -- Apenas valida se for consumo (amount negativo)
    IF NEW.amount < 0 AND NEW.type = 'consumption' THEN
        -- Busca o saldo atual
        SELECT credits_balance INTO current_balance
        FROM companies
        WHERE id = NEW.company_id;

        -- Verifica se tem saldo suficiente
        IF current_balance + NEW.amount < 0 THEN
            RAISE EXCEPTION 'Saldo de créditos insuficiente. Saldo atual: %, Tentativa de consumo: %',
                current_balance, ABS(NEW.amount);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para validar saldo antes de inserir transação
CREATE TRIGGER trigger_validate_credit_consumption
    BEFORE INSERT ON credit_transactions
    FOR EACH ROW
    EXECUTE FUNCTION validate_credit_consumption();

-- ============================================
-- Views úteis
-- ============================================

-- View para resumo de uso de créditos por empresa
CREATE OR REPLACE VIEW company_credits_summary AS
SELECT
    c.id,
    c.name,
    c.credits_balance,
    c.credits_total_purchased,
    c.credits_total_consumed,
    COUNT(DISTINCT ae.id) as total_executions,
    COUNT(DISTINCT ae.id) FILTER (WHERE ae.status = 'completed') as successful_executions,
    COUNT(DISTINCT ae.id) FILTER (WHERE ae.status = 'failed') as failed_executions,
    MAX(ae.created_at) as last_execution_at
FROM companies c
LEFT JOIN automation_executions ae ON ae.company_id = c.id
GROUP BY c.id, c.name, c.credits_balance, c.credits_total_purchased, c.credits_total_consumed;

-- View para histórico detalhado de créditos
CREATE OR REPLACE VIEW credit_transactions_detailed AS
SELECT
    ct.id,
    ct.company_id,
    c.name as company_name,
    ct.user_id,
    u.name as user_name,
    ct.automation_id,
    a.name as automation_name,
    ct.llm_model_id,
    m.name as model_name,
    ct.tokens_used,
    ct.amount,
    ct.type,
    ct.description,
    ct.created_at
FROM credit_transactions ct
JOIN companies c ON c.id = ct.company_id
LEFT JOIN users u ON u.id = ct.user_id
LEFT JOIN automations a ON a.id = ct.automation_id
LEFT JOIN llm_models m ON m.id = ct.llm_model_id
ORDER BY ct.created_at DESC;

-- View para estatísticas de uso por modelo
CREATE OR REPLACE VIEW llm_usage_stats AS
SELECT
    m.id as model_id,
    m.name as model_name,
    m.provider,
    COUNT(DISTINCT ae.id) as total_executions,
    SUM(ae.tokens_input) as total_tokens_input,
    SUM(ae.tokens_output) as total_tokens_output,
    SUM(ae.tokens_total) as total_tokens,
    SUM(ae.credits_consumed) as total_credits_consumed,
    AVG(ae.tokens_total) as avg_tokens_per_execution,
    AVG(ae.credits_consumed) as avg_credits_per_execution
FROM llm_models m
LEFT JOIN automation_executions ae ON ae.llm_model_id = m.id AND ae.status = 'completed'
GROUP BY m.id, m.name, m.provider;

-- View para detalhes de execuções com informações de tokens
CREATE OR REPLACE VIEW automation_executions_detailed AS
SELECT
    ae.id,
    ae.automation_id,
    a.name as automation_name,
    ae.company_id,
    c.name as company_name,
    ae.user_id,
    u.name as user_name,
    ae.llm_model_id,
    m.name as model_name,
    m.provider as model_provider,
    ae.tokens_input,
    ae.tokens_output,
    ae.tokens_total,
    ae.credits_consumed,
    ae.status,
    ae.error_message,
    ae.n8n_execution_id,
    ae.started_at,
    ae.completed_at,
    ae.created_at,
    EXTRACT(EPOCH FROM (ae.completed_at - ae.started_at)) as execution_time_seconds
FROM automation_executions ae
JOIN automations a ON a.id = ae.automation_id
JOIN companies c ON c.id = ae.company_id
JOIN users u ON u.id = ae.user_id
LEFT JOIN llm_models m ON m.id = ae.llm_model_id
ORDER BY ae.created_at DESC;

-- ============================================
-- Funções auxiliares para cálculo de créditos
-- ============================================

-- Função para calcular créditos baseado em tokens de entrada e saída
CREATE OR REPLACE FUNCTION calculate_credits_from_tokens(
    p_input_tokens BIGINT,
    p_output_tokens BIGINT,
    p_model_id UUID
)
RETURNS DECIMAL(20, 8) AS $$
DECLARE
    v_credits_per_input_token DECIMAL(20, 8);
    v_credits_per_output_token DECIMAL(20, 8);
    v_credits_input DECIMAL(20, 8);
    v_credits_output DECIMAL(20, 8);
    v_total_credits DECIMAL(20, 8);
BEGIN
    -- Busca a configuração do modelo
    SELECT credits_per_input_token, credits_per_output_token
    INTO v_credits_per_input_token, v_credits_per_output_token
    FROM llm_models
    WHERE id = p_model_id AND is_active = true;

    IF v_credits_per_input_token IS NULL OR v_credits_per_output_token IS NULL THEN
        RAISE EXCEPTION 'Modelo LLM não encontrado ou inativo: %', p_model_id;
    END IF;

    -- Calcula créditos separadamente para input e output
    v_credits_input := p_input_tokens * v_credits_per_input_token;
    v_credits_output := p_output_tokens * v_credits_per_output_token;

    -- Soma e retorna o valor preciso (sem arredondamento)
    v_total_credits := v_credits_input + v_credits_output;

    RETURN v_total_credits;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION calculate_credits_from_tokens IS 'Calcula quantidade de créditos baseado em tokens de entrada/saída e modelo LLM';

-- ============================================
-- Dados iniciais (seed)
-- ============================================

-- Inserir modelos LLM de exemplo
-- Preços baseados em valores reais das APIs (em USD por milhão de tokens)
-- Valores de créditos calculados: 1 crédito = $1 USD, então credits_per_token = cost_per_million_tokens / 1_000_000
INSERT INTO llm_models (name, provider, credits_per_input_token, credits_per_output_token, cost_per_million_input_tokens, cost_per_million_output_tokens) VALUES
('claude-sonnet-4.5', 'anthropic', 0.00000300, 0.00001500, 3.00, 15.00),
('claude-sonnet-4.5-fast', 'anthropic', 0.00000150, 0.00000600, 1.50, 6.00),
('claude-opus-4', 'anthropic', 0.00000600, 0.00002400, 6.00, 24.00),
('gpt-4o', 'openai', 0.00000250, 0.00001000, 2.50, 10.00),
('gpt-4o-mini', 'openai', 0.00000015, 0.00000060, 0.15, 0.60);

-- Inserir automação de exemplo
INSERT INTO automations (name, description, n8n_workflow_id, llm_model_id, estimated_tokens, estimated_credits, input_schema)
SELECT
    'Geração de Contrato de Prestação de Serviços',
    'Automação para gerar contrato de prestação de serviços personalizado',
    'workflow-001',
    id,
    100000, -- Estimativa: 25k input + 75k output = 100k total
    calculate_credits_from_tokens(25000, 75000, id), -- 25k input, 75k output
    '{
        "type": "object",
        "required": ["client_name", "service_description", "value"],
        "properties": {
            "client_name": {"type": "string"},
            "service_description": {"type": "string"},
            "value": {"type": "number"},
            "start_date": {"type": "string", "format": "date"}
        }
    }'::jsonb
FROM llm_models
WHERE name = 'claude-sonnet-4.5'
LIMIT 1;

-- ============================================
-- Índices adicionais para performance
-- ============================================

-- Índice composto para consultas frequentes
CREATE INDEX idx_automation_executions_company_status ON automation_executions(company_id, status, created_at DESC);
CREATE INDEX idx_credit_transactions_company_type ON credit_transactions(company_id, type, created_at DESC);

-- ============================================
-- Políticas de RLS (Row Level Security) - Opcional
-- Descrição: Pode ser habilitado para segurança adicional
-- ============================================

-- Habilitar RLS nas tabelas principais (comentado por padrão)
-- ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE users ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE credit_transactions ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE automation_executions ENABLE ROW LEVEL SECURITY;

-- Exemplo de política RLS para users
-- CREATE POLICY users_company_isolation ON users
--     USING (company_id = current_setting('app.current_company_id')::uuid);

-- ============================================
-- Grants (ajustar conforme seu usuário de aplicação)
-- ============================================

-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO your_app_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO your_app_user;
-- GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO your_app_user;
