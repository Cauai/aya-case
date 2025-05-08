CREATE TABLE IF NOT EXISTS gold_db.kpi_dau_mau_stickiness AS
WITH base AS (
    SELECT
        usuario_id,
        CAST(data_hora AS timestamp) AS ts,
        DATE(CAST(data_hora AS timestamp)) AS dia,
        DATE_TRUNC('month', CAST(data_hora AS timestamp))::date AS mes
    FROM silver_db.fact_engajamento
),

-- DAU: usuários únicos por dia
dau AS (
    SELECT 
        dia,
        COUNT(DISTINCT usuario_id) AS dau
    FROM base
    GROUP BY dia
),

-- MAU: usuários únicos por mês
mau AS (
    SELECT 
        mes,
        COUNT(DISTINCT usuario_id) AS mau
    FROM base
    GROUP BY mes
)

-- Combina DAU e MAU por mês
SELECT 
    d.dia,
    d.dau,
    m.mes,
    m.mau,
    ROUND(100.0 * d.dau / NULLIF(m.mau, 0), 2) AS stickiness_percent
FROM dau d
JOIN mau m ON DATE_TRUNC('month', d.dia) = m.mes;
