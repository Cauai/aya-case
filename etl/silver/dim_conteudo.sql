CREATE TABLE IF NOT EXISTS silver_db.dim_conteudo AS
SELECT DISTINCT
    tipo_conteudo
FROM silver_db.fact_engajamento
WHERE tipo_conteudo IS NOT NULL;

