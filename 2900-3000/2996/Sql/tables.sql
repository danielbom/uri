CREATE TABLE users (
  id NUMERIC PRIMARY KEY,
  name VARCHAR(50),
  type CHAR,
  address VARCHAR(50)
);

CREATE TABLE packages (
  id_package NUMERIC PRIMARY KEY,
  id_user_sender INTEGER,
  id_user_receiver INTEGER,
  color VARCHAR(50),
  year INTEGER,
  FOREIGN KEY (id_user_sender) REFERENCES users(id),
  FOREIGN KEY (id_user_receiver) REFERENCES users(id)
);
