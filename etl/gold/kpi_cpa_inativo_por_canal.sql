CREATE TABLE gold_db.kpi_cpa_inativo_por_canal AS
SELECT
    fa.canal,
    COUNT(DISTINCT fa.usuario_id) FILTER (
        WHERE TRIM(LOWER(fr.retencao_status)) = 'inativo'
    ) AS usuarios_inativos,
    SUM(fa.custo) AS custo_total,
    ROUND(
        SUM(fa.custo)::numeric /
        NULLIF(COUNT(DISTINCT fa.usuario_id) FILTER (
            WHERE TRIM(LOWER(fr.retencao_status)) = 'inativo'
        ), 0), 2
    ) AS cpa_inativo
FROM silver_db.fact_aquisicao fa
LEFT JOIN silver_db.fact_retencao fr ON fa.usuario_id = fr.usuario_id
GROUP BY fa.canal;
