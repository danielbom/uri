CREATE TABLE prices (
  id NUMERIC PRIMARY KEY,
  categorie VARCHAR(255),
  VALUE NUMERIC
);

CREATE TABLE movies (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  id_prices NUMERIC,
  FOREIGN KEY (id_prices) REFERENCES prices(id)
);
