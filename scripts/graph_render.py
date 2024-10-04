from typing import TextIO
import argparse
import re
import sys


def parse_adjacent_go(text: str) -> list[tuple[int, int, int]]:
    result = [[]]
    for value in re.findall(r"(\d+)", text):
        result[-1].append(int(value))
        if len(result[-1]) == 3:
            if len(result) > 2 and result[-1] == result[-2]:
                result[-1] = []
            else:
                result.append([])
    if result and not result[-1]:
        result.pop()
    return result


def adjacent_to_dot(io: TextIO, adj: list[tuple[int, int, int]]) -> None:
    io.write("digraph {\n")
    for a, b, c in adj:
        io.write(f"  {a} -> {b} [label={c}]\n")
    io.write("}\n")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=argparse.FileType("r"), default=sys.stdin)
    parser.add_argument("--output", type=argparse.FileType("w"), default=sys.stdout)
    parser.add_argument("--language", type=str, default="go")

    args = parser.parse_args()

    if args.language == "go":
        text = args.input.read()
        result = parse_adjacent_go(text)
        adjacent_to_dot(args.output, result)
    else:
        raise ValueError(f"Unsupported language: {args.language}")


if __name__ == "__main__":
    main()
