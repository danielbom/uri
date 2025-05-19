SELECT lr.name, ROUND(lr.omega * 1.618, 3) as "The N Factor"
FROM life_registry lr
JOIN dimensions d ON d.id = lr.dimensions_id
WHERE d.name IN ('C875', 'C774')
  AND lr.name LIKE 'Richard %'
ORDER BY lr.omega;
