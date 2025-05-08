
CREATE TABLE IF NOT EXISTS silver_db.dim_usuario AS
SELECT
    usuario_id,
    idade,
    genero,
    interesse,
    dias_engajamento,
    boas_vindas_eventos,
    engajamento_inicio,
    engajamento_fim,
    engajamento_dias_leitura,
    retencao_status,
    CASE
        WHEN boas_vindas_eventos LIKE '%tutorial_completo%' THEN 'sim'
        ELSE 'nao'
    END AS tutorial_completo
FROM bronze_db.cdp;
