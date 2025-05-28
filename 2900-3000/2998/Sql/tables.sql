CREATE TABLE clients (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50),
  investment NUMERIC
);

CREATE TABLE operations (
  id INTEGER PRIMARY KEY,
  client_id INTEGER,
  month INTEGER,
  profit NUMERIC,
  FOREIGN KEY (client_id) REFERENCES clients(id)
);
