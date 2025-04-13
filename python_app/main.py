import psycopg2
from tabulate import tabulate

conn = psycopg2.connect(
    dbname="clothing_store",
    user="user",
    password="password",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

cursor.execute("""
    SELECT table_name FROM information_schema.tables
    WHERE table_schema = 'public'
""")
tables = cursor.fetchall()
print("\nТаблиці:")
for (name,) in tables:
    print(f"\n🟢 {name.upper()}")
    cursor.execute(f"SELECT * FROM {name}")
    rows = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    print(tabulate(rows, headers=colnames, tablefmt="grid"))

cursor.close()
conn.close()
