CREATE TABLE IF NOT EXISTS users (
  user_id INTEGER,
  user_name VARCHAR(60),
  posts INTEGER,
  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS followers (
  follower_id INTEGER,
  user_id_fk INTEGER,
  following_user_id_fk INTEGER,
  PRIMARY KEY (follower_id),
  FOREIGN KEY (user_id_fk) REFERENCES users (user_id),
  FOREIGN KEY (following_user_id_fk) REFERENCES users (user_id)
);