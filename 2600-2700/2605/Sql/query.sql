SELECT p.name as product, pr.name as "provider"
FROM products p
JOIN providers pr ON pr.id = p.id_providers
JOIN categories c ON c.id = p.id_categories
WHERE c.name = 'executive';
