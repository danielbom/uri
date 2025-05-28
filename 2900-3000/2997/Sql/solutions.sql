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
resultados AS (
  SELECT d.cod_dep, COUNT(1) AS total, ROUND(AVG(s.valor), 2) AS media, ROUND(MAX(s.valor), 2) AS maior, ROUND(MIN(s.valor), 2) AS menor
  FROM departamento d
  JOIN divisao dv ON dv.cod_dep = d.cod_dep
  JOIN atuacao a ON a.cod_divisao = dv.cod_divisao
  JOIN salario s ON s.matr = a.matr
  GROUP BY d.cod_dep
)
SELECT dp.nome AS "Nome Departamento",
    r.total AS "Numero de Empregados",
    r.media AS "Media Salarial",
    r.maior AS "Maior Salario",
    (CASE 
      WHEN r.menor <= 0.01 THEN 0
      ELSE r.menor
    END) AS "Menor Salario"
FROM resultados r
JOIN departamento dp ON dp.cod_dep = r.cod_dep
ORDER BY r.media DESC;


SELECT dep.nome AS "Nome Departamento"
    , COUNT(emp.matr) AS "Numero de Empregados"
    , ROUND((AVG(tsalario.salario - tdescontos.descontos)), 2) AS "Media Salarial"
    , ROUND((MAX(tsalario.salario - tdescontos.descontos)), 2) AS "Maior Salario"
    , (CASE
        WHEN MIN(tsalario.salario - tdescontos.descontos) = 0 THEN '0'
        ELSE ROUND((MIN(tsalario.salario - tdescontos.descontos)), 2)
      END) AS "Menor Salario"
FROM departamento dep
INNER JOIN empregado emp ON dep.cod_dep = emp.lotacao
INNER JOIN (
  SELECT emp.matr, COALESCE(SUM(v.valor), 0) AS salario
  FROM empregado emp
  LEFT JOIN emp_venc ON emp.matr = emp_venc.matr
  LEFT JOIN vencimento v ON emp_venc.cod_venc = v.cod_venc
  GROUP BY emp.matr
) AS tsalario ON emp.matr = tsalario.matr
INNER JOIN (
  SELECT emp.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
  FROM empregado emp
  LEFT JOIN emp_desc ON emp.matr = emp_desc.matr
  LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
  GROUP BY emp.matr
) AS tdescontos ON emp.matr = tdescontos.matr
GROUP BY dep.cod_dep,dep.nome ORDER BY "Media Salarial" DESC
