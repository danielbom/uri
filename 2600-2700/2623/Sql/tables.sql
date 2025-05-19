CREATE TABLE categories (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE products (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  amount NUMERIC,
  price NUMERIC,
  id_categories NUMERIC,
  FOREIGN KEY (id_categories) REFERENCES categories(id)
);
