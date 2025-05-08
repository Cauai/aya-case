CREATE TABLE IF NOT EXISTS silver_db.fact_aquisicao AS
SELECT
    usuario_id,
    data_instalacao,
    fonte_midia,
    canal,
    plataforma,
    versao_app,
    marca,
    modelo,
    custo
FROM bronze_db.appsflyer
WHERE usuario_id IS NOT NULL;
