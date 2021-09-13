const input = require("fs").readFileSync("/dev/stdin", "utf8");
const lines = input.split("\n").slice(1);

console.log(
  lines
    .filter((line) => line.length > 0)
    .map((line) => line.split(" "))
    .map(([first, second]) =>
      first.endsWith(second) ? "encaixa" : "nao encaixa"
    )
    .join("\n")
);
