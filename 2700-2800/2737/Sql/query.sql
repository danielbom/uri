WITH metrics as (
  SELECT MAX(customers_number) as max, MIN(customers_number) as min, AVG(customers_number) as avg
  FROM lawyers)
SELECT r.name, r.customers_number
FROM (
  SELECT 1 as ord, lmax.name, lmax.customers_number
  FROM lawyers lmax
  JOIN metrics m ON m.max = lmax.customers_number
    UNION
  SELECT 2 as ord, lmin.name, lmin.customers_number
  FROM lawyers lmin
  JOIN metrics m ON m.min = lmin.customers_number
    UNION
  SELECT 3 as ord, 'Average' as name, FLOOR(m.avg) as customers_number
  FROM metrics m
) r
ORDER BY r.ord;
