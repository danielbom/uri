(SELECT c.city_name, c.population
FROM cities c
ORDER BY c.population DESC
OFFSET 1 LIMIT 1)
  UNION ALL
(SELECT c.city_name, c.population
FROM cities c
ORDER BY c.population ASC
OFFSET 1 LIMIT 1);
