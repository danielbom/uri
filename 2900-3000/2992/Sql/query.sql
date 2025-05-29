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
),
ranked_salario_medio_divisao AS (
  SELECT dv.cod_dep 
      , dv.nome
      , sm.cod_divisao
      , sm.valor
      , ROW_NUMBER() OVER (
        PARTITION BY dv.cod_dep
        ORDER BY sm.valor DESC
      ) as rank
  FROM salario_medio_divisao sm
  JOIN divisao dv ON dv.cod_divisao = sm.cod_divisao
)
SELECT dp.nome as departamento
    , rsm.nome as divisao
    , ROUND(rsm.valor, 2) as media
FROM ranked_salario_medio_divisao rsm
JOIN departamento dp ON dp.cod_dep = rsm.cod_dep
WHERE rsm.rank = 1
ORDER BY media DESC;
