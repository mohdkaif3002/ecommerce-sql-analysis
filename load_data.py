import sqlite3
import pandas as pd
import os

# Path to your database and data folder
DB_PATH = "olist_ecommerce.db"
DATA_FOLDER = "data"

conn = sqlite3.connect(DB_PATH)

# Load each CSV into a table
for file in os.listdir(DATA_FOLDER):
    if file.endswith(".csv"):
        table_name = file.replace(".csv", "").replace("-", "_")
        filepath = os.path.join(DATA_FOLDER, file)
        df = pd.read_csv(filepath)
        df.to_sql(table_name, conn, if_exists="replace", index=False)
        print(f"✅ Loaded: {table_name} ({len(df)} rows)")

conn.close()
print("\n🎉 All tables loaded successfully!")