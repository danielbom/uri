INSERT INTO categories (id, name)
VALUES
(1, 'Super Luxury'),
(2, 'Imported'),
(3, 'Tech'),
(4, 'Vintage'),
(5, 'Supreme');

INSERT INTO providers (id, name, street, city, state)
VALUES
(1, 'Ajax SA', 'Rua Presidente Castelo Branco', 'Porto Alegre', 'RS'),
(2, 'Sansul SA', 'Av Brasil', 'Rio de Janeiro', 'RJ'),
(3, 'South Chairs', 'Rua do Moinho', 'Santa Maria', 'RS'),
(4, 'Elon Electro', 'Rua Apolo', 'São Paulo', 'SP'),
(5, 'Mike electro', 'Rua Pedro da Cunha', 'Curitiba', 'PR');

INSERT INTO products (id, name, amount, price, id_providers, id_categories)
VALUES
(1, 'Blue Chair', 30, 300.00, 5, 5),
(2, 'Red Chair', 50, 2150.00, 2, 1),
(3, 'Disney Wardrobe', 400, 829.50, 4, 1),
(4, 'Blue Toaster', 20, 9.90, 3, 1),
(5, 'TV', 30, 3000.25, 2, 2);