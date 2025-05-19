SELECT c.name, r.rentals_date
FROM customers c
JOIN rentals r ON r.id_customers = c.id
WHERE '2016-09-01' <= r.rentals_date AND r.rentals_date < '2016-10-01';
