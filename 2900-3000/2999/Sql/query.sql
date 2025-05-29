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
),
salario_medio_divisao AS (
  SELECT a.cod_divisao, AVG(s.valor) as valor
  FROM atuacao a
  JOIN salario s ON s.matr = a.matr
  GROUP BY a.cod_divisao
)
SELECT e.nome, ROUND(s.valor, 2) as salario
FROM atuacao a
JOIN empregado e ON e.matr = a.matr
JOIN salario s ON s.matr = a.matr
JOIN salario_medio_divisao sm ON sm.cod_divisao = a.cod_divisao
WHERE s.valor > sm.valor AND s.valor >= 8000.0
ORDER BY sm.cod_divisao, salario DESC;
