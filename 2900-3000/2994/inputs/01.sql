INSERT INTO doctors (id, name)
VALUES
(1, 'Arlino'),
(2, 'Tiago'),
(3, 'Amanda'),
(4, 'Wellington');

INSERT INTO work_shifts (id, name, bonus)
VALUES
(1, 'nocturnal', 15),
(2, 'afternoon', 2),
(3, 'day', 1);

INSERT INTO attendances (id, id_doctor, hours, id_work_shift)
VALUES
(1, 1, 5, 1),
(2, 3, 2, 1),
(3, 3, 3, 2),
(4, 2, 2, 3),
(5, 1, 5, 3),
(6, 4, 1, 3),
(7, 4, 2, 1),
(8, 3, 2, 2),
(9, 2, 4, 2);
