INSERT INTO categories (id, name)
VALUES
(1, 'Superior'),
(2, 'Super Luxury'),
(3, 'Modern'),
(4, 'Nerd'),
(5, 'Infantile'),
(6, 'Robust'),
(9, 'Wood');

INSERT INTO products (id, name, amount, price, id_categories)
VALUES 
(1, 'Blue Chair', 30, 300.00, 9),
(2, 'Red Chair', 200, 2150.00, 2),
(3, 'Disney Wardrobe', 400, 829.50, 4),
(4, 'Blue Toaster', 20, 9.90, 3),
(5, 'Solar Panel', 30, 3000.25, 4);
