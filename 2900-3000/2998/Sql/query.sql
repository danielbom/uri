WITH profits AS (
  SELECT o.client_id
      , o.month
      , SUM(o.profit) OVER (PARTITION BY o.client_id ORDER BY o.month) AS value
  FROM operations o
  ORDER BY o.client_id, o.month
),
paybacks AS (
  SELECT p.client_id, p.month, p.value
  FROM profits p
  JOIN clients c ON c.id = p.client_id
  WHERE p.value >= c.investment
),
first_payback AS (
  SELECT p.client_id, MIN(p.month) AS first_month
  FROM paybacks p
  GROUP BY p.client_id
)
SELECT c.name
    , c.investment
    , p.month AS "month_of_payback"
    , p.value - c.investment AS "return"
FROM first_payback fp
JOIN clients c ON c.id = fp.client_id
JOIN paybacks p ON p.client_id = fp.client_id AND p.month = fp.first_month
ORDER BY "return" DESC;
