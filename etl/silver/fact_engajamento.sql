CREATE TABLE IF NOT EXISTS silver_db.fact_engajamento AS
SELECT
    usuario_id,
    data_hora,
    SPLIT_PART(evento, ':', 1) AS evento,
    SPLIT_PART(evento, ':', 2) AS acao,
    SPLIT_PART(evento, ':', 2) AS tipo_conteudo
FROM bronze_db.ga4
WHERE evento LIKE '%:%';