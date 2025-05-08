CREATE TABLE IF NOT EXISTS gold_db.kpi_funil_jornada_sequencial AS
WITH etapa_1 AS (
    SELECT DISTINCT usuario_id
    FROM silver_db.fact_engajamento
    WHERE acao = 'visualizacao_tela' AND evento = 'instalacao'
),
etapa_2 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_1 e1 ON fe.usuario_id = e1.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'criar_conta'
),
etapa_3 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_2 e2 ON fe.usuario_id = e2.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'cadastro'
),
etapa_4 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_3 e3 ON fe.usuario_id = e3.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'pin_cadastro'
),
etapa_5 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_4 e4 ON fe.usuario_id = e4.usuario_id
    WHERE acao = 'visualizacao_tela' AND evento = 'inicio'
),
etapa_6 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_5 e5 ON fe.usuario_id = e5.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'ler_minibook'
),
etapa_7 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_6 e6 ON fe.usuario_id = e6.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'ler_ebook'
),
etapa_8 AS (
    SELECT DISTINCT fe.usuario_id
    FROM silver_db.fact_engajamento fe
    JOIN etapa_7 e7 ON fe.usuario_id = e7.usuario_id
    WHERE acao = 'clique_botao' AND evento = 'ouvir_audiobook'
)

SELECT 'Instalacao' AS etapa, COUNT(*) AS usuarios_unicos FROM etapa_1
UNION ALL
SELECT 'Criar Conta', COUNT(*) FROM etapa_2
UNION ALL
SELECT 'Cadastro', COUNT(*) FROM etapa_3
UNION ALL
SELECT 'PIN Cadastro', COUNT(*) FROM etapa_4
UNION ALL
SELECT 'Inicio App', COUNT(*) FROM etapa_5
UNION ALL
SELECT 'Ler Minibook', COUNT(*) FROM etapa_6
UNION ALL
SELECT 'Ler Ebook', COUNT(*) FROM etapa_7
UNION ALL
SELECT 'Ouvir Audiobook', COUNT(*) FROM etapa_8;
