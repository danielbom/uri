SELECT CONCAT(SUBSTRING(np.cpf, 1, 3), '.', SUBSTRING(np.cpf, 4, 3), '.', SUBSTRING(np.cpf, 7, 3), '-', SUBSTRING(np.cpf, 10, 3)) as CPF
FROM natural_person np;
