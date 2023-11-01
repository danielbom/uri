DROP VIEW IF EXISTS followers_posts_view;
DROP TABLE IF EXISTS followers;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
  user_id int,
  user_name varchar,
  posts int,
  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS followers (
  follower_id int,
  user_id_fk int,
  following_user_id_fk int,
  PRIMARY KEY (follower_id),
  FOREIGN KEY (user_id_fk) REFERENCES users (user_id),
  FOREIGN KEY (following_user_id_fk) REFERENCES users (user_id)
);