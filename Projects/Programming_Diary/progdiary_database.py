import sqlite3

connection = sqlite3.connect("progdiary.db")

def create_table():
    connection.execute("CREATE TABLE entries (content TEXT, date TEXT);")

def add_entry (entry_content, entry_date):
    entries.append({"content": entry_content, "date": entry_date})


def get_entries ():
    return entries