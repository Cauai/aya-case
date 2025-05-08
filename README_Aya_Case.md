# 📊 Case: Analista de Dados Sênior – Aya Conteúdos

Este projeto tem como objetivo demonstrar habilidades de engenharia e análise de dados aplicadas ao case da **Aya**, uma plataforma de leitura digital. A proposta envolve ingestão, modelagem e análise de dados de comportamento de usuários, campanhas e engajamento com conteúdos no app.

---

## 🛠️ Tecnologias Utilizadas

- PostgreSQL (via Docker)
- Python (pandas, psycopg2)
- SQL
- Power BI (dashboards)
- VSCode + SQLTools

---

## 🗂️ Estrutura de Camadas

### 🔸 Bronze (raw)
Contém os dados brutos ingeridos via Python para PostgreSQL:
- `bronze_db.ga4` – eventos do app
- `bronze_db.appsflyer` – atribuição de campanhas
- `bronze_db.cdp` – dados demográficos e comportamento

### 🔸 Silver (modelagem dimensional)
Modelagem em estrela com fatos e dimensões limpas:
#### 🧩 Dimensões:
- `dim_usuario`
- `dim_campanha`
- `dim_dispositivo`
- `dim_conteudo`
- `dim_evento` *(jornada completa por ação e evento)*

#### 📊 Fatos:
- `fact_engajamento` – cliques, visualizações, leitura etc.
- `fact_aquisicao` – canal, plataforma, dispositivo
- `fact_retencao` – dias engajados, leitura, status

---

## 🟡 Camada Gold (KPIs)

Indicadores agregados prontos para visualização no Power BI:

### ✅ Conversão no Funil de Jornada
- **Origem:** `fact_engajamento`
- **Descrição:** Mede a queda de usuários entre etapas como instalação, cadastro, leitura e audição de conteúdos.
- **Tabela:** `kpi_funil_jornada_sequencial`

### ✅ CPA (Custo por Aquisição)
- **Origem:** `fact_aquisicao`
- **Descrição:** Custo médio por canal.
- **Tabela:** `kpi_cpa_por_canal`

### ✅ Retenção por Faixa Etária
- **Origem:** `fact_retencao` + `dim_usuario`
- **Descrição:** Quantidade de usuários ativos/inativos por faixa etária segmentada.
- **Tabela:** `kpi_retencao_faixa_etaria`

### ✅ DAU, MAU e Stickiness Diário
- **Origem:** `fact_engajamento`
- **Descrição:** Quantos usuários ativos por dia (DAU), por mês (MAU), e quanto isso representa em termos de stickiness.
- **Tabela:** `kpi_dau_mau_stickiness`

### ✅ Stickiness Consolidado Mensal
- **Descrição:** Média diária de uso / MAU em cada mês.
- **Tabela:** `kpi_mensal_stickiness`

---

## 🖇️ Integração com Power BI

1. Conectar ao PostgreSQL com:
   - Host: `localhost`
   - Database: `aya_db`
   - User: `aya_user`
   - Password: `aya_pass`

2. Carregar as tabelas da camada `gold_db`

3. Criar visualizações:
   - Funil de conversão (visual funnel)
   - Stickiness por mês (linha)
   - Tabela de CPA
   - Gráficos por faixa etária e status de retenção

---

## 📊 Modelo Estrela – Fluxo de Tabelas (Mermaid)

```mermaid
erDiagram
    dim_usuario ||--o{ fact_engajamento : usuario_id
    dim_usuario ||--o{ fact_aquisicao : usuario_id
    dim_usuario ||--o{ fact_retencao : usuario_id

    dim_campanha ||--o{ fact_aquisicao : campanha
    dim_dispositivo ||--o{ fact_aquisicao : (plataforma, marca, modelo)
    dim_conteudo ||--o{ fact_engajamento : tipo_conteudo
    dim_evento ||--o{ fact_engajamento : (acao, evento)

    fact_engajamento ||--o| kpi_funil_jornada_sequencial : fonte
    fact_aquisicao ||--o| kpi_cpa_por_canal : fonte
    fact_retencao ||--o| kpi_retencao_faixa_etaria : fonte
    fact_engajamento ||--o| kpi_dau_mau_stickiness : fonte
    fact_engajamento ||--o| kpi_mensal_stickiness : fonte
```

---

## ✅ Resultado Esperado

Um painel gerencial com:
- Visualizações claras da jornada de conversão
- Indicadores de custo e engajamento
- Métricas de retenção e comportamento por faixa etária
- KPIs diários e mensais de atividade de usuários

---

## 📌 Autor
Este projeto foi desenvolvido por Cauai Capozzoli como parte do processo seletivo da Aya para a posição de Analista de Dados Sênior.
