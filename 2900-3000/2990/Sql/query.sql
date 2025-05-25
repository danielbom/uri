SELECT e.cpf, e.enome, d.dnome
FROM empregados e
JOIN departamentos d ON d.dnumero = e.dnumero
LEFT JOIN trabalha t ON t.cpf_emp = e.cpf
WHERE t.pnumero IS NULL
ORDER BY e.cpf;
