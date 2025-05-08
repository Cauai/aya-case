import os
import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# Primeiro cria o schema com psycopg2 para evitar caching do SQLAlchemy
with psycopg2.connect(
    host="localhost",
    port=5432,
    user="aya_user",
    password="aya_pass",
    dbname="aya_db"
) as conn:
    with conn.cursor() as cur:
        cur.execute("CREATE SCHEMA IF NOT EXISTS bronze_db")
        conn.commit()
        print("Schema 'bronze_db' criado com sucesso (via psycopg2)")

# Agora sim, cria o engine SQLAlchemy
engine = create_engine('postgresql://aya_user:aya_pass@localhost:5432/aya_db')

# Dicionário de arquivos
arquivos = {
    'dados_ga4.csv': 'bronze_db.ga4',
    'dados_appsflyer.csv': 'bronze_db.appsflyer',
    'dados_cdp.csv': 'bronze_db.cdp'
}

# Loop para carregar os dados
for arquivo, tabela in arquivos.items():
    file_path = os.path.join("data", "raw", arquivo)
    df = pd.read_csv(file_path)
    df.columns = [col.lower().strip().replace(" ", "_") for col in df.columns]
    df.to_sql(
        name=tabela.split(".")[1],
        con=engine,
        schema=tabela.split(".")[0],
        if_exists='replace',
        index=False
    )
    print(f"Tabela {tabela} carregada com sucesso.")

