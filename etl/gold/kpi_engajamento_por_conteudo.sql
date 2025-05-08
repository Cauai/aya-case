CREATE TABLE IF NOT EXISTS gold_db.kpi_engajamento_por_conteudo AS
SELECT 
    tipo_conteudo,
    COUNT(*) AS total_eventos,
    COUNT(DISTINCT usuario_id) AS usuarios_engajados
FROM silver_db.fact_engajamento
WHERE tipo_conteudo IS NOT NULL
GROUP BY tipo_conteudo;