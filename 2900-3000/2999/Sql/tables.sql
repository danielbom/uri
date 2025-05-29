CREATE TABLE departamento (
  cod_dep INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(50)
);

CREATE TABLE dependente (
  matr INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(50)
);

CREATE TABLE desconto (
  cod_desc INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  tipo VARCHAR(10),
  valor NUMERIC
);

CREATE TABLE divisao (
  cod_divisao INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(50),
  cod_dep INTEGER,
  FOREIGN KEY (cod_dep) REFERENCES departamento(cod_dep)
);

CREATE TABLE empregado (
  matr INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(50),
  data_lotacao TIMESTAMP,
  lotacao INTEGER,
  gerencia_cod_dep INTEGER,
  lotacao_div INTEGER,
  gerencia_div INTEGER,
  FOREIGN KEY (gerencia_cod_dep) REFERENCES departamento(cod_dep),
  FOREIGN KEY (lotacao_div) REFERENCES divisao(cod_divisao),
  FOREIGN KEY (gerencia_div) REFERENCES divisao(cod_divisao)
);

CREATE TABLE emp_desc (
  cod_desc INTEGER,
  matr INTEGER,
  PRIMARY KEY (cod_desc, matr),
  FOREIGN KEY (cod_desc) REFERENCES desconto(cod_desc),
  FOREIGN KEY (matr) REFERENCES empregado(matr)
);

CREATE TABLE vencimento (
  cod_venc INTEGER PRIMARY KEY,
  nome VARCHAR(50),
  tipo VARCHAR(50),
  valor NUMERIC
);

CREATE TABLE emp_venc (
  cod_venc INTEGER,
  matr INTEGER,
  PRIMARY KEY (cod_venc, matr),
  FOREIGN KEY (cod_venc) REFERENCES vencimento(cod_venc),
  FOREIGN KEY (matr) REFERENCES empregado(matr)
);
