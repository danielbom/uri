WITH vencimento_total AS (
  SELECT ev.matr, SUM(v.valor) as valor
  FROM emp_venc ev
  JOIN vencimento v ON v.cod_venc = ev.cod_venc
  GROUP BY ev.matr
),
desconto_total AS (
  SELECT ed.matr, SUM(d.valor) as valor
  FROM emp_desc ed
  JOIN desconto d ON d.cod_desc = ed.cod_desc
  GROUP BY ed.matr
),
salario AS (
  SELECT e.matr, COALESCE(SUM(vt.valor), 0) - COALESCE(SUM(dt.valor), 0) as valor
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
atuacao as (
    (SELECT gdv.*
    FROM gerentes_divisao gdv)
      UNION
    (SELECT ldv.*
    FROM lotacao_divisao ldv)
),
resultados as (
  SELECT dv.cod_divisao, ROUND(AVG(s.valor), 2) as media, ROUND(MAX(s.valor), 2) as maior
  FROM divisao dv
  JOIN atuacao a ON a.cod_divisao = dv.cod_divisao
  JOIN salario s ON s.matr = a.matr
  GROUP BY dv.cod_divisao
)
SELECT dp.nome as departamento, dv.nome as divisao, r.media, r.maior
FROM resultados r
JOIN divisao dv ON dv.cod_divisao = r.cod_divisao
JOIN departamento dp ON dp.cod_dep = dv.cod_dep
ORDER BY r.media DESC;

