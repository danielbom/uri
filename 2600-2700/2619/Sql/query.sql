SELECT pt.name, pd.name, pt.price
FROM products pt
JOIN providers pd ON pd.id = pt.id_providers
JOIN categories c ON c.id = pt.id_categories
WHERE pt.price > 1000.0
  AND c.name = 'Super Luxury';
