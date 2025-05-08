CREATE TABLE IF NOT EXISTS gold_db.kpi_retencao_faixa_etaria AS
SELECT 
    CASE 
        WHEN du.idade < 18 THEN '<18'
        WHEN du.idade BETWEEN 18 AND 24 THEN '18-24'
        WHEN du.idade BETWEEN 25 AND 34 THEN '25-34'
        WHEN du.idade BETWEEN 35 AND 44 THEN '35-44'
        WHEN du.idade BETWEEN 45 AND 54 THEN '45-54'
        WHEN du.idade BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS faixa_etaria,
    fr.retencao_status,
    COUNT(*) AS total
FROM silver_db.fact_retencao fr
JOIN silver_db.dim_usuario du ON fr.usuario_id = du.usuario_id
GROUP BY faixa_etaria, fr.retencao_status;
