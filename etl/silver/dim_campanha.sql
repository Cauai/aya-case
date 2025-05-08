CREATE SCHEMA IF NOT EXISTS silver_db;

CREATE TABLE IF NOT EXISTS silver_db.dim_campanha AS
SELECT DISTINCT
    fonte_midia,         -- Ex: Facebook Ads, Orgânico
    canal,                           -- Ex: email, sms, push
    plataforma,                      -- Android, iOS
    versao_app,
    marca,
    modelo
FROM bronze_db.appsflyer
WHERE fonte_midia IS NOT NULL;