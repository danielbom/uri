SELECT p.name
FROM products p
JOIN providers pr ON pr.id = p.id_providers
WHERE LOWER(pr.name) LIKE 'p%'
  AND p.amount BETWEEN 10 AND 20;
