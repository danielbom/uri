import argparse
from pathlib import Path


EXERCISES_DIR = Path(__file__).parent.parent.resolve()
LANGUAGES = {
    "Haskell": ".hs",
    "C++": ".cpp",
    "Go": ".go",
    "Js": ".js",
    "Py": ".py",
    "Rust": ".rs",
}

def make_dir(path: Path, parents: bool = False, exist_ok: bool = False):
    path.mkdir(parents=parents, exist_ok=exist_ok)
    print(f"INFO: Directory created {str(path).replace('\\', '/')}")


def make_file(path: Path, content: str = ""):
    if path.exists():
        print(f"INFO: File already exists {str(path).replace('\\', '/')}")
    else:
        path.write_text(content)
        print(f"INFO: File created {str(path).replace('\\', '/')}")


def main():
    parser = argparse.ArgumentParser(description="Create a new exercise")
    parser.add_argument("number", type=int, help="The number of the exercise")
    parser.add_argument("language", nargs="+",
                        help="The language of the exercise",
                        choices=LANGUAGES.keys())
    parser.add_argument("--samples", type=int, default=1,
                        help="The number of sample inputs and outputs")

    args = parser.parse_args()
    
    folder_start = (args.number // 100) * 100
    folder_end = folder_start + 100
    folder = f"{folder_start}-{folder_end}"

    exercise_dir = EXERCISES_DIR / folder / str(args.number)

    make_dir(exercise_dir, parents=True, exist_ok=True)

    for lang in args.language:
        make_dir((exercise_dir / lang), exist_ok=True)
        make_file(exercise_dir / lang / ("main" + LANGUAGES[lang]))

    make_dir((exercise_dir / "inputs"), exist_ok=True)
    make_dir((exercise_dir / "outputs"), exist_ok=True)

    for i in range(1, args.samples + 1):
        make_file(exercise_dir / "inputs" / f"{i:02}.txt")
        make_file(exercise_dir / "outputs" / f"{i:02}.txt")


if __name__ == "__main__":
    main()
