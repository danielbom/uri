SELECT c.name, o.id
FROM customers c
JOIN orders o ON o.id_customers = c.id
WHERE '2016-01-01' <= o.orders_date AND o.orders_date < '2016-07-01';
