CREATE TABLE silver_db.fact_engajamento AS
SELECT
    usuario_id,
    data_hora,
    SPLIT_PART(evento, ':', 1) AS acao,     -- o que vem antes do ":"
    SPLIT_PART(evento, ':', 2) AS evento,   -- o que vem depois do ":"
    CASE
        WHEN SPLIT_PART(evento, ':', 2) ILIKE '%ebook%' THEN 'ebook'
        WHEN SPLIT_PART(evento, ':', 2) ILIKE '%audiobook%' THEN 'audiobook'
        WHEN SPLIT_PART(evento, ':', 2) ILIKE '%minibook%' THEN 'minibook'
        ELSE NULL
    END AS tipo_conteudo
FROM bronze_db.ga4
WHERE evento LIKE '%:%';