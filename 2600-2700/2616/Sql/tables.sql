CREATE TABLE customers (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255)
);

CREATE TABLE locations (
  id NUMERIC PRIMARY KEY,
  locations_date DATE,
  id_customers NUMERIC,
  FOREIGN KEY (id_customers) REFERENCES customers(id)
);
