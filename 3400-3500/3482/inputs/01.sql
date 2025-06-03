INSERT INTO users (user_id, user_name, posts)
VALUES
(1, 'Francisco', 23),
(2, 'Brenda', 51),
(3, 'Helena', 12),
(4, 'Miguel', 70),
(5, 'Laura', 55),
(6, 'Arthur', 2),
(7, 'Alice', 3);

INSERT INTO followers (follower_id, user_id_fk, following_user_id_fk)
VALUES
(1, 1, 5),
(2, 2, 4),
(3, 3, 7),
(4, 3, 6),
(5, 4, 2),
(6, 4, 5),
(7, 5, 1),
(8, 5, 3),
(9, 5, 4),
(10, 5, 2),
(11, 7, 3);