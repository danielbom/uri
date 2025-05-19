CREATE TABLE customers (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  state CHAR(2),
  credit_limit NUMERIC
);

CREATE TABLE natural_person (
  id_customers NUMERIC PRIMARY KEY,
  cpf CHAR(14),
  FOREIGN KEY (id_customers) REFERENCES customers(id)
)
