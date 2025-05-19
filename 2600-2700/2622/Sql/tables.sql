CREATE TABLE customers (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  state CHAR(2),
  credit_limit NUMERIC
);

CREATE TABLE legal_person (
  id_customers NUMERIC PRIMARY KEY,
  cnpj CHAR(18),
  contact VARCHAR(64),
  FOREIGN KEY (id_customers) REFERENCES customers(id)
);
