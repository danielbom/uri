import sqlite3
from pathlib import Path
import difflib


def get_connection(db_path: Path):
    return sqlite3.connect(str(db_path))


def execute_file(conn, file_path: Path):
    sql_script = file_path.read_text(encoding="utf-8")
    conn.executescript(sql_script)


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
    except sqlite3.Error as e:
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
    db_path = Path(__file__).parent / "db.sqlite"
    db_path.unlink(missing_ok=True)
    conn = get_connection(db_path)
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
