INSERT INTO departamento (cod_dep, nome, endereco)
VALUES
(1, 'Contabilidade', 'R. X'),
(2, 'TI', 'R. Y'),
(3, 'Engenharia', 'R. Y');

INSERT INTO dependente (matr, nome, endereco)
VALUES
(9999, 'Francisco Jose', 'R. Z'),
(88, 'Maria da Silva', 'R. T'),
(55, 'Virgulino da Silva', 'R. 31');

INSERT INTO desconto (cod_desc, nome, tipo, valor)
VALUES
(91, 'IR', 'V', 400),
(92, 'Plano de saude', 'V', 300),
(93, null, null, null);

INSERT INTO divisao (cod_divisao, nome, endereco, cod_dep)
VALUES
(11, 'Ativo', 'R. X', 1),
(12, 'Passivo', 'R. X', 1),
(21, 'Desenvoilvimento de Projetos', 'R. Y', 2),
(22, 'Analise de Sistemas', 'R. Y', 2),
(23, 'Programacao', 'R. W', 2),
(31, 'Concreto', 'R. Y', 3),
(32, 'Calculo Estrutural', 'R. Y', 3);

INSERT INTO empregado (matr, nome, endereco, data_lotacao, lotacao, gerencia_cod_dep, lotacao_div, gerencia_div)
VALUES
(9999, 'Jose Sampaio', 'R. Z', '2006-06-06T00:00:00Z', 1, 1, 12, null),
(33, 'Jose Maria', 'R. 21', '2006-03-01T00:00:00Z', 1, null, 11, 11),
(1, 'Maria Jose', 'R. 52', '2003-03-01T00:00:00Z', 1, null, 11, null),
(7, 'Yasmim', 'R. 13', '0210-07-02T00:00:00Z', 1, null, 11, null),
(5, 'Rebeca', 'R. 1', '2011-04-01T00:00:00Z', 1, null, 12, 12),
(13, 'Sofia', 'R. 28', '2010-09-09T00:00:00Z', 1, null, 12, null),
(27, 'Andre', 'R. Z', '2005-05-01T00:00:00Z', 2, 2, 22, null),
(88, 'Yami', 'R. T', '2014-02-01T00:00:00Z', 2, null, 21, 21),
(431, 'Joao da Silva', 'R. Y', '2011-07-03T00:00:00Z', 2, null, 21, null),
(135, 'Ricardo Reis', 'R. 33', '2009-08-01T00:00:00Z', 2, null, 21, null),
(254, 'Barbara', 'R. Z', '2008-01-03T00:00:00Z', 2, null, 22, 22),
(371, 'Ines', 'R. Y', '2005-01-01T00:00:00Z', 2, null, 22, null),
(476, 'Flor', 'R. Z', '2015-10-28T00:00:00Z', 2, null, 23, 23),
(25, 'Lina', 'R. 67', '2014-09-01T00:00:00Z', 2, null, 23, null),
(3, 'Jose da Silva', 'R. 8', '2011-01-02T00:00:00Z', 3, 3, 31, null),
(71, 'Silverio dos Reis', 'R. C', '2009-01-05T00:00:00Z', 3, null, 31, 31),
(91, 'Reis da Silva', 'R. Z', '2011-11-05T00:00:00Z', 3, null, 31, null),
(55, 'Lucas', 'R. 31', '2013-07-01T00:00:00Z', 3, null, 32, 32),
(222, 'Marina', 'R. 31', '2015-01-07T00:00:00Z', 3, null, 32, null),
(725, 'Angelo', 'R. X', '2001-03-01T00:00:00Z', 2, null, 21, null);

INSERT INTO emp_desc (cod_desc, matr)
VALUES
(91, 3),
(91, 27),
(91, 9999),
(92, 27),
(92, 71),
(92, 88),
(92, 9999);

INSERT INTO vencimento (cod_venc, nome, tipo, valor)
VALUES
(1, 'Salario base Analista de Sistemas', 'V', 5000),
(2, 'Salario base Contador', 'V', 3000),
(3, 'Salario Base Engenheiro', 'V', 4500),
(4, 'Salario Base Projetista Software', 'V', 5000),
(5, 'Salario Base Programador de Sistemas', 'V', 3000),
(6, 'Gratificacao Chefia Departamento', 'V', 3750),
(7, 'Gratificacao Chefia Divisao', 'V', 2200),
(8, 'Salario Trabalhador Costrucao Civil', 'V', 800),
(9, 'Auxilio Salario Familia', 'V', 300),
(10, 'Gratificacao Tempo de servico', 'V', 350),
(11, 'Insalubridade', 'V', 800),
(12, 'Gratificacao por titulacao - Doutorado', 'V', 2000),
(13, 'Gratificacao por Titularidade - Mestrado', 'V', 800);

INSERT INTO emp_venc (cod_venc, matr)
VALUES
(1, 27),
(1, 88),
(1, 135),
(1, 254),
(1, 431),
(2, 1),
(2, 5),
(2, 7),
(2, 13),
(2, 33),
(2, 9999),
(3, 3),
(3, 55),
(3, 71),
(3, 222),
(4, 25),
(4, 476),
(5, 371),
(6, 3),
(6, 27),
(6, 9999),
(7, 5),
(7, 33),
(7, 55),
(7, 71),
(7, 88),
(7, 254),
(7, 476),
(8, 25),
(8, 91),
(9, 1),
(9, 27),
(9, 91),
(9, 135),
(9, 371),
(9, 9999),
(10, 371),
(10, 9999),
(11, 91),
(12, 3),
(12, 27),
(12, 254),
(12, 9999),
(13, 3),
(13, 5),
(13, 7),
(13, 25),
(13, 33),
(13, 88),
(13, 135);
