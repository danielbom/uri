SELECT pt.name, pd.name, c.name
FROM products pt
JOIN providers pd ON pd.id = pt.id_providers
JOIN categories c ON c.id = pt.id_categories
WHERE pd.name = 'Sansul SA'
  AND c.name = 'Imported';
