CREATE TABLE dimensions (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE life_registry (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  omega NUMERIC,
  dimensions_id NUMERIC,
  FOREIGN KEY (dimensions_id) REFERENCES dimensions(id)
);
