WITH payments AS (
  SELECT d.id, SUM((150.0 * a.hours) * (100.0 + ws.bonus) / 100.0) as salary
  FROM doctors d
  JOIN attendances a ON a.id_doctor = d.id
  JOIN work_shifts ws ON ws.id = a.id_work_shift
  GROUP BY d.id
)
SELECT d.name, ROUND(p.salary, 1) as salary
FROM doctors d
JOIN payments p ON p.id = d.id
ORDER BY salary DESC;
