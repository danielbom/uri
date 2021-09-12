const fs = require("fs");

function toUpper(line) {
  return line.toUpperCase();
}
function toLower(line) {
  return line.toLowerCase();
}

function dance(line) {
  const result = [];
  let count = 0;
  const mapper = [toUpper, toLower];
  const n = line.length;
  for (let i = 0; i < n; i++) {
    const ch = line[i];
    if (ch.match(/[a-zA-Z]/)) {
      result.push(mapper[count % 2](ch));
      count++;
    } else {
      result.push(ch);
    }
  }
  return result.join("");
}

const data = fs.readFileSync("/dev/stdin", "utf8");
process.stdout.write(data.toLowerCase().split("\n").map(dance).join("\n"));
