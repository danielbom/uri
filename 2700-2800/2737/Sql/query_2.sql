SELECT r.name, r.customers_number
FROM (SELECT 1 as order, l.name, l.customers_number
    FROM lawyers l
    WHERE l.customers_number IN (SELECT MAX(lmax.customers_number) FROM lawyers lmax)
      UNION
    SELECT 2 as order, l.name, l.customers_number
    FROM lawyers l
    WHERE l.customers_number IN (SELECT MIN(lmin.customers_number) FROM lawyers lmin)
      UNION
    SELECT 3 as order, 'Average' as name, FLOOR(AVG(l.customers_number))
    FROM lawyers l) r
ORDER BY r.order;
