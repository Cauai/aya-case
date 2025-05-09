CREATE TABLE gold_db.kpi_coorte_retencao AS
WITH instalacoes AS (
    SELECT 
        usuario_id,
        DATE(data_instalacao) AS data_instalacao
    FROM silver_db.fact_aquisicao
),
eventos AS (
    SELECT 
        usuario_id,
        DATE(data_hora) AS data_evento
    FROM silver_db.fact_engajamento
    GROUP BY usuario_id, DATE(data_hora)
),
usuarios_com_dia_atividade AS (
    SELECT 
        i.usuario_id,
        i.data_instalacao,
        e.data_evento,
        (DATE(e.data_evento) - DATE(i.data_instalacao))::int AS dias_apos
    FROM instalacoes i
    JOIN eventos e ON i.usuario_id = e.usuario_id
    WHERE e.data_evento >= i.data_instalacao
)
SELECT 
    dias_apos,
    COUNT(DISTINCT usuario_id) AS usuarios_retidos
FROM usuarios_com_dia_atividade
GROUP BY dias_apos
ORDER BY dias_apos;
