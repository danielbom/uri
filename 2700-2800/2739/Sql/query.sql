SELECT l.name, CAST(EXTRACT(DAY FROM l.payday) AS INTEGER) as day
FROM loan l;
