CREATE TABLE IF NOT EXISTS gold_db.kpi_funil_cadastro AS
SELECT 
    acao,
    COUNT(DISTINCT usuario_id) AS usuarios
FROM silver_db.fact_engajamento
WHERE evento = 'clique_botao'
  AND acao IN ('criar_conta', 'cadastro', 'pin_cadastro')
GROUP BY acao;
