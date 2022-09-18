CREATE TABLE providers (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  state CHAR(2)
);

CREATE TABLE products (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  amount NUMERIC,
  price NUMERIC,
  id_providers NUMERIC,
  FOREIGN KEY (id_providers) REFERENCES providers(id)
);
