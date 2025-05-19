SELECT c.name
FROM customers c
RIGHT JOIN legal_person p ON p.id_customers = c.id;
