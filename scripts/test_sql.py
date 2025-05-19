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
        print(query_path.absolute())
        print(query)
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


class StrBuilder:
    def __init__(self):
        self.parts = []

    def write(self, text: str):
        self.parts.append(text)

    def string(self) -> str:
        return ''.join(self.parts)


class FileBuilder:
    def __init__(self, path: Path):
        self.path = path
        self.file = path.open('w', encoding='utf-8')

    def write(self, text: str):
        self.file.write(text)

    def string(self) -> str:
        if not self.file.closed:
            self.file.close()
        return self.path.read_text()


def compare_text(result_b: FileBuilder, expected_path: Path):
    result = result_b.string()
    expected = expected_path.read_text(encoding="utf-8")
    diff = list(difflib.unified_diff(
        expected.splitlines(keepends=True),
        result.splitlines(keepends=True),
        fromfile=str(expected_path.absolute().resolve()),
        tofile=str(result_b.path.absolute().resolve()),
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
        fb = FileBuilder(Path(__file__).parent / "sql_result.txt")
        execute_select(conn, Path("./query.sql"), fb.write)
        if not compare_text(fb, out_path):
            break
        print(f"✅ Test {in_path.stem}")


if __name__ == "__main__":
    main()
