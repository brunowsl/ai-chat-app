# Paleta de Cores - Lexia

## Cor Primária: Vermelho Bordô

### Por que Vermelho Bordô?

O **vermelho bordô/vinho** (`#991b1b` - `#450a0a`) foi escolhido como cor primária por ser a **cor tradicional da advocacia brasileira**. Esta escolha não é apenas estética, mas carrega profundo simbolismo jurídico:

### Simbolismo

1. **Toga dos Magistrados**
   - A toga vermelha é símbolo da magistratura
   - Representa a justiça e o poder judiciário
   - Tradição que remonta ao Império Romano

2. **Tradição Jurídica**
   - Cor historicamente associada ao direito
   - Presente em selos, documentos e brasões jurídicos
   - Reconhecimento imediato no meio jurídico

3. **Valores Transmitidos**
   - **Seriedade**: Tom sóbrio e profissional
   - **Autoridade**: Associação com poder e respeito
   - **Tradição**: Conexão com a história do direito
   - **Confiança**: Estabilidade e segurança

### Escala de Cores

```css
--law-red-50:  #fef2f2  /* Muito claro - backgrounds sutis */
--law-red-100: #fee2e2  /* Claro - hover states */
--law-red-200: #fecaca  /* Suave */
--law-red-300: #fca5a5  /* Médio-claro */
--law-red-400: #f87171  /* Médio */
--law-red-500: #ef4444  /* Padrão vibrante */
--law-red-600: #dc2626  /* Médio-escuro */
--law-red-700: #991b1b  /* Principal - Bordô */
--law-red-800: #7f1d1d  /* Escuro */
--law-red-900: #5c0f0f  /* Muito escuro */
--law-red-950: #450a0a  /* Quase preto */
```

### Uso na Interface

#### Elementos Principais
- **Botões primários**: `--law-red-700`
- **Links e ações**: `--law-red-700`
- **Ícones destacados**: `--law-red-700`
- **Bordas ativas**: `--law-red-600`

#### Estados de Hover
- **Botões hover**: `--law-red-800`
- **Links hover**: `--law-red-800`

#### Backgrounds
- **Gradientes**: `--law-red-900` → `--law-red-700`
- **Destaques suaves**: `--law-red-50` a `--law-red-100`

#### Títulos e Textos
- **Títulos principais**: `--law-red-900`
- **Textos de ênfase**: `--law-red-700`

## Cores Complementares

### Dourado (`#d4af37`)
- **Uso**: Destaques, créditos, ícones especiais
- **Simbolismo**: Excelência, prestígio, valor
- **Combinação**: Contrasta bem com bordô

### Cinzas Neutros
- **`--gray-50` a `--gray-900`**: Textos, backgrounds, bordas
- **Propósito**: Criar hierarquia visual sem competir com a cor primária

### Cores de Estado
- **Sucesso** (`#059669`): Verde - operações bem-sucedidas
- **Aviso** (`#d97706`): Laranja - alertas
- **Erro** (`#dc2626`): Vermelho vivo - erros
- **Info** (`#2563eb`): Azul - informações

## Acessibilidade

### Contraste
Todas as combinações de cor seguem as diretrizes WCAG 2.1:

- ✅ **Texto escuro sobre branco**: AA+ (4.5:1)
- ✅ **Branco sobre bordô**: AA (4.5:1)
- ✅ **Bordô sobre cinza claro**: AAA (7:1)

### Daltonismo
O vermelho bordô mantém visibilidade para:
- Protanopia (cegueira ao vermelho)
- Deuteranopia (cegueira ao verde)
- Tritanopia (cegueira ao azul)

A diferença de luminosidade (não apenas matiz) garante acessibilidade.

## Comparação com Outras Profissões

| Profissão | Cor Tradicional | Simbolismo |
|-----------|-----------------|------------|
| **Advocacia** | Vermelho Bordô | Justiça, tradição |
| Medicina | Branco | Pureza, higiene |
| Engenharia | Amarelo | Atenção, segurança |
| Contabilidade | Azul | Confiança, estabilidade |

## Implementação Técnica

### PrimeVue Theme Tokens
```css
--p-primary-50:  var(--law-red-50)
--p-primary-100: var(--law-red-100)
/* ... */
--p-primary-900: var(--law-red-900)
--p-primary-950: var(--law-red-950)

--p-primary-color: var(--law-red-700)
```

### CSS Variables
Todas as cores estão definidas como CSS custom properties no [assets/css/main.css](../assets/css/main.css), permitindo:

- ✅ Fácil manutenção
- ✅ Consistência global
- ✅ Mudanças rápidas
- ✅ Suporte a temas (futuro)

## Inspirações de Design

### Referências Visuais
- Selos e brasões de tribunais brasileiros
- Capas de códigos jurídicos
- Togas da magistratura
- Design de escritórios de advocacia tradicionais

### Modernização
Embora a cor seja tradicional, o design é **moderno e minimalista**:
- Espaçamento generoso
- Tipografia limpa
- Elementos flat design
- Animações sutis

## Feedback e Iteração

A paleta foi escolhida para:
1. ✅ Ressoar com o público-alvo (advogados)
2. ✅ Transmitir profissionalismo
3. ✅ Manter legibilidade
4. ✅ Ser memorável e única

## Próximas Evoluções

Possíveis adições futuras:
- 🎨 Modo escuro (dark mode) com bordô mais suave
- 🌈 Temas alternativos para diferentes práticas jurídicas
- 🎯 Cores específicas por tipo de documento

---

**Conclusão**: O vermelho bordô não é apenas uma escolha estética - é uma declaração de identidade jurídica que conecta tradição e modernidade.
