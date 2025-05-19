CREATE TABLE customers (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  state CHAR(2),
  credit_limit NUMERIC
);

CREATE TABLE orders (
  id NUMERIC PRIMARY KEY,
  orders_date DATE,
  id_customers NUMERIC,
  FOREIGN KEY (id_customers) REFERENCES customers(id)
);
