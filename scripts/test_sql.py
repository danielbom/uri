# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "psycopg2",
# ]
# ///
import psycopg2
from pathlib import Path
import difflib


def get_connection():
    # Start docker with:
    # docker run --name uri_postgres -e POSTGRES_DB=uri_db -e POSTGRES_USER=uri -e POSTGRES_PASSWORD=uri_exercises -p 5432:5432 -d postgres:9
    return psycopg2.connect(f"dbname=uri_db user=uri password=uri_exercises host=localhost")


def execute_file(conn, file_path: Path):
    sql_script = file_path.read_text(encoding="utf-8")
    cursor = conn.cursor()
    cursor.execute(sql_script)
    conn.commit()
    cursor.close()


def execute_select(conn, query_path: Path, write: callable):
    try:
        query = query_path.read_text(encoding="utf-8")
        cursor = conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        write(','.join(f'"{desc[0]}"' for desc in cursor.description))
        write('\n')
        for row in rows:
            write(','.join(f'"{item}"' for item in row))
            write('\n')
    except psycopg2.Error as e:
        write(f"SQLite error: {e}")


def print_write(text: str):
    print(text, end="")


class StrBuilder:
    def __init__(self):
        self.parts = []

    def write(self, text: str):
        self.parts.append(text)

    def string(self) -> str:
        return ''.join(self.parts)


def compare_text(result: str, expected: str):
    diff = list(difflib.unified_diff(
        expected.splitlines(keepends=True),
        result.splitlines(keepends=True),
        fromfile='expected',
        tofile='result'
    ))
    if diff:
        print(''.join(diff))
        return False
    return True


def main():
    conn = get_connection()

    # Recreate schema uri_db (drop, craete, use)
    cursor = conn.cursor()
    cursor.execute("DROP SCHEMA IF EXISTS uri_db CASCADE;")
    cursor.execute("CREATE SCHEMA uri_db;")
    cursor.execute("SET search_path TO uri_db;")
    conn.commit()
    cursor.close()

    execute_file(conn, Path("./tables.sql"))
    for in_path in Path("../inputs/").glob("*.sql"):
        name = in_path.with_suffix('.txt').name
        out_path = in_path.parent.parent / "outputs" / name
        execute_file(conn, in_path)
        sb = StrBuilder()
        execute_select(conn, Path("./query.sql"), sb.write)
        expected = out_path.read_text(encoding="utf-8")
        if not compare_text(sb.string(), expected):
            break
        print(f"✅ Test {in_path.stem}")


if __name__ == "__main__":
    main()
