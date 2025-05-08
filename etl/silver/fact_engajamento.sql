CREATE TABLE IF NOT EXISTS silver_db.fact_retencao AS
SELECT
    usuario_id,
    dias_engajamento,
    engajamento_dias_leitura,
    retencao_status
FROM bronze_db.cdp
WHERE usuario_id IS NOT NULL;
