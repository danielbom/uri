from pathlib import Path


outputs_path = Path("../outputs")

for output_path in outputs_path.glob("*.txt"):
    print(output_path)
    with output_path.open("r", encoding="utf-8") as file:
        content = file.read().replace("\r\n", "\n")
    with output_path.open("w", encoding="utf-8") as file:
        file.write(content)


print("Done!")
