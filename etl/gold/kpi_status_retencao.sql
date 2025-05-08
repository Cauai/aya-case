CREATE TABLE IF NOT EXISTS gold_db.kpi_status_retencao AS
SELECT 
    retencao_status,
    COUNT(DISTINCT usuario_id) AS total_usuarios
FROM silver_db.fact_retencao
GROUP BY retencao_status;