INSERT INTO clients (id, name, investment)
VALUES
(1, 'Daniel', 500),
(2, 'Oliveira', 2000),
(3, 'Lucas', 1000);

INSERT INTO operations (id, client_id, month, profit)
VALUES
(1, 1, 1, 230),
(2, 2, 1, 1000),
(3, 2, 2, 1000),
(4, 3, 1, 100),
(5, 3, 2, 300),
(6, 3, 3, 900),
(7, 3, 4, 400);
