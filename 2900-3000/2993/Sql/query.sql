SELECT v.amount as most_frequent_value
FROM value_table v
GROUP BY v.amount
ORDER BY COUNT(1) DESC
LIMIT 1;
