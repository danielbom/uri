const sqlite3 = require("sqlite3");
const fs = require("fs");
const path = require("path");

function fileExec(db, filepath) {
  const data = fs.readFileSync(filepath).toString();
  const commands = data.split(";");

  return Promise.all(
    commands.map(
      (cmd) =>
        new Promise((resolve, reject) => {
          db.exec(cmd, (err) => {
            if (err) {
              console.log("ERROR: " + filepath);
              console.log(cmd);
              reject(err);
            } else {
              resolve();
            }
          });
        })
    )
  );
}

function fileSelect(db, filepath) {
  return new Promise((resolve, reject) => {
    db.each(
      fs.readFileSync(filepath).toString(),
      (err, row) => {
        if (err) return;
        else console.log(row);
      },
      (err) => {
        if (err) reject(err);
        else resolve();
      }
    );
  });
}

async function run(dirname) {
  const db = new sqlite3.Database(":memory:");

  try {
    await fileExec(db, path.join(dirname, "..", "inputs", "tables.sql"));
    await fileExec(db, path.join(dirname, "..", "inputs", "data.sql"));
    await fileSelect(db, path.join(dirname, "query.sql"));
  } catch (err) {
    console.log(err.message);
  }

  db.close();
}

module.exports = run;
