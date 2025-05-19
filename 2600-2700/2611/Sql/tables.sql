CREATE TABLE genres (
  id NUMERIC PRIMARY KEY,
  description VARCHAR(255)
);

CREATE TABLE movies (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(255),
  id_genres NUMERIC,
  FOREIGN KEY (id_genres) REFERENCES genres(id)
);
