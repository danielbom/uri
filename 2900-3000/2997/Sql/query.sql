WITH vencimento_total AS (
  SELECT ev.matr, SUM(v.valor) AS valor
  FROM emp_venc ev
  JOIN vencimento v ON v.cod_venc = ev.cod_venc
  GROUP BY ev.matr
),
desconto_total AS (
  SELECT ed.matr, SUM(d.valor) AS valor
  FROM emp_desc ed
  JOIN desconto d ON d.cod_desc = ed.cod_desc
  GROUP BY ed.matr
),
salario AS (
  SELECT e.matr, COALESCE(SUM(vt.valor), 0) - COALESCE(SUM(dt.valor), 0) AS valor
  FROM empregado e
  LEFT JOIN vencimento_total vt ON vt.matr = e.matr
  LEFT JOIN desconto_total dt ON dt.matr = e.matr
  GROUP BY e.matr
),
gerentes_divisao AS (
  SELECT e.matr, dv.cod_divisao
  FROM empregado e
  JOIN divisao dv ON dv.cod_divisao = e.gerencia_div
),
lotacao_divisao AS (
  SELECT e.matr, dv.cod_divisao
  FROM empregado e
  JOIN divisao dv ON dv.cod_divisao = e.lotacao_div
),
atuacao AS (
    (SELECT gdv.*
    FROM gerentes_divisao gdv)
      UNION
    (SELECT ldv.*
    FROM lotacao_divisao ldv)
)
SELECT dp.nome AS "Departamento"
    , e.nome AS "Empregado"
    , COALESCE(ROUND(vt.valor, 2), 0) AS "Salario Bruto"
    , COALESCE(ROUND(dt.valor, 2), 0) AS "Total Desconto"
    , (CASE
      WHEN s.valor <= 0.01 THEN 0
      ELSE COALESCE(ROUND(s.valor, 2), 0)
    END) AS "Salario Liquido"
FROM atuacao a
LEFT JOIN vencimento_total vt ON vt.matr = a.matr
LEFT JOIN desconto_total dt ON dt.matr = a.matr
LEFT JOIN salario s ON s.matr = a.matr
JOIN empregado e ON e.matr = a.matr
JOIN divisao dv ON dv.cod_divisao = a.cod_divisao
JOIN departamento dp ON dp.cod_dep = dv.cod_dep
ORDER BY "Salario Liquido" DESC;
