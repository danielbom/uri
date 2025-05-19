SELECT CONCAT('Approved: ', s.name) as name, s.grade
FROM students s
WHERE s.grade >= 7.0
ORDER BY s.grade DESC;
