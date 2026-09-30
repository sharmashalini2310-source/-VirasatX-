import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="shalini",
        password="shalini2310",
        database="virasatx"
    )