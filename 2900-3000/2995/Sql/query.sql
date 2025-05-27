SELECT r.temperature, COUNT(1) as number_of_records
FROM records r
GROUP BY r.temperature, r.mark
ORDER BY r.mark;
