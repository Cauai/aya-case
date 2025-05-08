CREATE TABLE IF NOT EXISTS gold_db.kpi_cpa_por_canal AS
SELECT 
    canal,
    COUNT(DISTINCT usuario_id) AS usuarios_adquiridos,
    SUM(custo) AS custo_total,
    ROUND(SUM(custo)::numeric / NULLIF(COUNT(DISTINCT usuario_id), 0), 2) AS cpa_medio
FROM silver_db.fact_aquisicao
GROUP BY canal;