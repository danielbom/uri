SELECT p.id, p.name
FROM products p
WHERE NOT p.price BETWEEN 10 AND 100;