INSERT INTO users (id, name, address)
VALUES
(1, 'Edgar Codd', 'England'),
(2, 'Peter Chen', 'Taiwan'),
(3, 'Jim Gray', 'United States'),
(4, 'Elizabeth ONeil', 'United States');

INSERT INTO packages (id_package, id_user_sender, id_user_receiver, color, year)
VALUES
(1, 1, 2, 'blue', 2015),
(2, 1, 3, 'blue', 2019),
(3, 2, 4, 'red', 2019),
(4, 2, 1, 'green', 2018),
(5, 3, 4, 'red', 2015),
(6, 4, 3, 'blue', 2019);
