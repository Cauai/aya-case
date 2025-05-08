CREATE TABLE IF NOT EXISTS silver_db.dim_dispositivo AS
SELECT DISTINCT
    plataforma,
    versao_app,
    marca,
    modelo
FROM bronze_db.appsflyer
WHERE marca IS NOT NULL AND modelo IS NOT NULL;