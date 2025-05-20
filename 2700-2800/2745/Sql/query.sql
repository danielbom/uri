SELECT p.name, ROUND(p.salary * 0.10, 2) as tax
FROM people p
WHERE p.salary > 3000.00;
