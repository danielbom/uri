CREATE TABLE departamentos (
  dnumero INTEGER PRIMARY KEY,
  dnome VARCHAR(60),
  cpf_gerente VARCHAR(15)
);

CREATE TABLE empregados (
  cpf VARCHAR(15) PRIMARY KEY,
  enome VARCHAR(60),
  salario FLOAT,
  cpf_supervisor VARCHAR(15),
  dnumero INTEGER,
  FOREIGN KEY (dnumero) REFERENCES departamentos(dnumero),
  FOREIGN KEY (cpf_supervisor) REFERENCES empregados(cpf)
);

CREATE TABLE projetos (
  pnumero INTEGER PRIMARY KEY,
  pnome VARCHAR(45),
  dnumero INTEGER,
  FOREIGN KEY (dnumero) REFERENCES departamentos(dnumero)
);

CREATE TABLE trabalha (
  cpf_emp VARCHAR(15),
  pnumero INTEGER,
  PRIMARY KEY (cpf_emp, pnumero),
  FOREIGN KEY (cpf_emp) REFERENCES empregados(cpf),
  FOREIGN KEY (pnumero) REFERENCES projetos(pnumero)
);
