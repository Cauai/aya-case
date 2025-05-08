CREATE TABLE IF NOT EXISTS gold_db.kpi_mensal_stickiness AS
WITH base AS (
    SELECT
        usuario_id,
        DATE(CAST(data_hora AS timestamp)) AS dia,
        DATE_TRUNC('month', CAST(data_hora AS timestamp))::date AS mes
    FROM silver_db.fact_engajamento
),

-- DAU por dia
dau_por_dia AS (
    SELECT 
        mes,
        dia,
        COUNT(DISTINCT usuario_id) AS dau
    FROM base
    GROUP BY mes, dia
),

-- MAU por mês
mau AS (
    SELECT 
        mes,
        COUNT(DISTINCT usuario_id) AS mau
    FROM base
    GROUP BY mes
)

-- Consolidado final: média de DAU por mês e stickiness
SELECT
    mau.mes,
    mau.mau,
    ROUND(AVG(dpd.dau)::numeric, 2) AS dau_medio,
    ROUND(100.0 * AVG(dpd.dau)::numeric / NULLIF(mau.mau, 0), 2) AS stickiness_percent
FROM mau
JOIN dau_por_dia dpd ON mau.mes = dpd.mes
GROUP BY mau.mes, mau.mau
ORDER BY mau.mes;
