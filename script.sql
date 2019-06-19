/*
 * Flávio Nuno Maia de Sousa Filho - 115037071
 * João Ricardo Campbell Maia - 116111909
 * João Pedro Lopes Murtinho - 116040336
 *
 * Banco de Dados
 * Trabalho prático 1 - Script de criação do banco de dados
 */

CREATE SCHEMA `aluguelcarros` ;
USE aluguelcarros;

CREATE TABLE pessoa (
	CPF CHAR(11) NOT NULL,
    NOME VARCHAR(200) NOT NULL,
    PRIMARY KEY (CPF)
);

CREATE TABLE cliente (
	CPF CHAR(11) NOT NULL UNIQUE,
    IDCLIENTE INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (IDCLIENTE),
    CONSTRAINT cpf_PessoaCliente FOREIGN KEY (CPF) REFERENCES pessoa(CPF) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE funcionario (
	CPF CHAR(11) NOT NULL UNIQUE,
    IDFUNCIONARIO INT NOT NULL AUTO_INCREMENT,
    ANOCONT DATE NOT NULL,
    SALARIO NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (IDFUNCIONARIO),
    CONSTRAINT cpf_PessoaFunc FOREIGN KEY (CPF) REFERENCES pessoa(CPF) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE garagem (
	IDGARAGEM INT NOT NULL AUTO_INCREMENT,
    LOCALIZACAO VARCHAR(200) NOT NULL,
	CAPACIDADECARROS INT NOT NULL,
    CAPACIDADECAMINHOES INT NOT NULL,
    PRIMARY KEY (IDGARAGEM)
);

CREATE TABLE caminhao (
	IDCAMINHAO INT NOT NULL AUTO_INCREMENT,
	IDGARAGEM INT NOT NULL,
    PLACA CHAR(7) NOT NULL,
    FABRICANTE VARCHAR(50) NOT NULL,
    MODELO VARCHAR(50) NOT NULL,
	ANO INT NOT NULL,
    PRIMARY KEY (IDCAMINHAO),
    FOREIGN KEY (IDGARAGEM) REFERENCES garagem(IDGARAGEM)
);

CREATE TABLE caminhoneiro (
    IDCAMINHONEIRO INT NOT NULL AUTO_INCREMENT,
    IDFUNCIONARIO INT NOT NULL,
    CNH CHAR(11) NOT NULL,
    TIPOCNH CHAR(1) NOT NULL,
    IDCAMINHAO INT,
    PRIMARY KEY (IDCAMINHONEIRO),
    FOREIGN KEY (IDCAMINHAO) REFERENCES caminhao(IDCAMINHAO),
	CONSTRAINT idfunc_FuncCaminhoneiro FOREIGN KEY (IDFUNCIONARIO) REFERENCES funcionario(IDFUNCIONARIO) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE filial	 (
    IDFILIAL INT NOT NULL AUTO_INCREMENT,
    LOCALIZACAO VARCHAR(200) NOT NULL,
    HORFUNC VARCHAR(200) NOT NULL,
    CAPACIDADECARROS INT NOT NULL,
    PRIMARY KEY (IDFILIAL)
);

CREATE TABLE agente (
    IDAGENTE INT NOT NULL AUTO_INCREMENT,
    IDFUNCIONARIO INT NOT NULL,
    STATUSGERENTE BOOLEAN NOT NULL,
	IDFILIAL INT NOT NULL,
    PRIMARY KEY (IDAGENTE),
    CONSTRAINT idFunc_FuncAgente FOREIGN KEY (IDFUNCIONARIO) REFERENCES funcionario(IDFUNCIONARIO) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (IDFILIAL) REFERENCES filial(IDFILIAL)
);

CREATE TABLE gerencia (
    IDAGENTE INT NOT NULL,
    IDGERENTE INT NOT NULL,
    CONSTRAINT idAgt_AgtGerencia FOREIGN KEY (IDAGENTE) REFERENCES agente(IDAGENTE) ON DELETE CASCADE,
    CONSTRAINT idGrt_AgtGerencia FOREIGN KEY (IDGERENTE) REFERENCES agente(IDAGENTE) ON DELETE CASCADE
);

CREATE TABLE parceiro (
    IDPARCEIRO INT NOT NULL AUTO_INCREMENT,
    NOME VARCHAR(200) NOT NULL,
    INICIOPARCERIA DATE NOT NULL,
    FIMPARCERIA DATE,
	IDFILIAL INT NOT NULL,
    PRIMARY KEY (IDPARCEIRO),
    FOREIGN KEY (IDFILIAL) REFERENCES  filial(IDFILIAL)
);

CREATE TABLE aeroporto (
    IDAEROPORTO INT NOT NULL AUTO_INCREMENT,
    IDPARCEIRO INT NOT NULL,
    DESCONTO DOUBLE NOT NULL,
    LOCALIZACAO VARCHAR(200) NOT NULL,
    PRIMARY KEY (IDAEROPORTO),
    FOREIGN KEY (IDPARCEIRO) REFERENCES  parceiro(IDPARCEIRO)
);

CREATE TABLE redehoteis (
    IDREDEHOTEIS INT NOT NULL AUTO_INCREMENT,
    IDPARCEIRO INT NOT NULL,
    PRIMARY KEY (IDREDEHOTEIS),
    FOREIGN KEY (IDPARCEIRO) REFERENCES  parceiro(IDPARCEIRO)
);

CREATE TABLE hotel (
	IDHOTEL INT NOT NULL AUTO_INCREMENT,
	IDREDEHOTEIS INT NOT NULL,
    DESCONTO DOUBLE NOT NULL,
    LOCALIZACAO VARCHAR(200) NOT NULL,
    PRIMARY KEY (IDHOTEL),
    FOREIGN KEY (IDREDEHOTEIS) REFERENCES  redehoteis(IDREDEHOTEIS)
);


CREATE TABLE carro (
	IDCARRO INT NOT NULL AUTO_INCREMENT,
	IDGARAGEM INT NOT NULL,
    PLACA CHAR(7) NOT NULL,
    PRECO NUMERIC(12,2) NOT NULL,
    FABRICANTE VARCHAR(50) NOT NULL,
    MODELO VARCHAR(50) NOT NULL,
	ANO INT NOT NULL,
    COR VARCHAR(50) NOT NULL,
    PRIMARY KEY (IDCARRO),
    FOREIGN KEY (IDGARAGEM) REFERENCES garagem(IDGARAGEM)
);

CREATE TABLE estacaomanutencao (
	IDESTACAO INT NOT NULL AUTO_INCREMENT,
    LOCALIZACAO VARCHAR(200),
    HORFUNC VARCHAR(200) NOT NULL,
    PRIMARY KEY (IDESTACAO)
);

CREATE TABLE servicos (
	SERVICO VARCHAR(200) NOT NULL,
    IDESTACAO INT NOT NULL,
    FOREIGN KEY (IDESTACAO) REFERENCES estacaomanutencao(IDESTACAO)
);

CREATE TABLE manutencao (
	IDMANUTENCAO INT NOT NULL AUTO_INCREMENT,
	IDESTACAO INT NOT NULL,
    IDCARRO INT NOT NULL,
    ENTRADA DATE NOT NULL,
    SAIDA DATE NOT NULL,
    PRIMARY KEY (IDMANUTENCAO),
    FOREIGN KEY (IDCARRO) REFERENCES carro(IDCARRO),
    FOREIGN KEY (IDESTACAO) REFERENCES estacaomanutencao(IDESTACAO)
);

CREATE TABLE aluguel (
	IDALUGUEL INT NOT NULL AUTO_INCREMENT,
    IDCARRO INT NOT NULL,
    IDCLIENTE INT NOT NULL,
    RETIRADA DATE NOT NULL,
    RETORNO DATE NOT NULL,
    PRIMARY KEY (IDALUGUEL),
    FOREIGN KEY (IDCARRO) REFERENCES carro(IDCARRO),
    FOREIGN KEY (IDCLIENTE) REFERENCES cliente(IDCLIENTE)
);

/*
 * Flávio Nuno Maia de Sousa Filho - 115037071
 * João Ricardo Campbell Maia - 116111909
 * João Pedro Lopes Murtinho - 116040336
 *
 * Banco de Dados
 * Trabalho prático 1 - Script de população do banco de dados
 */

USE aluguelcarros;

INSERT INTO pessoa (cpf, nome)
VALUES ('11111111111', 'Joao'),
    ('11211131211', 'Joao Pedro'),
    ('11215115171', 'Flavio'),
    ('05823600054', 'Samuel'),
    ('33906286061', 'Enzo Gabriel'),
    ('96497455051', 'João Miguel'),
    ('51244412421', 'Marcos'),
    ('44218839204', 'Luana'),
    ('22567743257', 'Carlos'),
    ('14677332111', 'Jorge'),
    ('08142135027', 'Lucas'),
    ('72535879018', 'Benjamin'),
    ('27838312019', 'Nicolas');

INSERT INTO cliente (cpf)
VALUES ('11111111111'),
    ('11211131211'),
    ('11215115171'),
    ('05823600054'),
    ('33906286061'),
    ('96497455051');

INSERT INTO funcionario (cpf, anocont, salario)
VALUES ('51244412421', '2014-05-28', 3210.00),
    ('44218839204', '2011-07-18', 5720.00),
    ('22567743257', '2016-11-05', 3805.00),
    ('14677332111', '2012-04-25', 4560.00),
    ('08142135027', '2015-03-31', 1796.00),
    ('72535879018', '2011-12-01', 2530.00),
    ('27838312019', '2018-05-12', 2040.00);

INSERT INTO caminhoneiro (idfuncionario, cnh, tipocnh)
VALUES (5, '11616001863', 'D'),
    (6, '74191216300', 'C'),
    (7, '06925470641', 'E');

INSERT INTO filial (localizacao, horfunc, capacidadecarros)
VALUES ('Rio de Janeiro', '8:00-16:00', 20),
    ('São Paulo', '9:00-17:00', 30);

INSERT INTO agente (idfuncionario, statusgerente, idfilial)
VALUES (1, TRUE, 1),
    (2, FALSE, 1),
    (3, TRUE, 2),
    (4, FALSE, 2);

INSERT INTO gerencia (idagente, idgerente)
VALUES (2, 1),
    (4, 3);

INSERT INTO parceiro (nome, inicioparceria, fimparceria, idfilial)
VALUES ('Santos Dummond', '2014-05-21', '2017-06-10', 1),
    ('Galeão', '2018-02-25', NULL, 1),
    ('Congonhas', '2013-11-16', '2018-08-02', 2),
    ('Guarulhos', '2017-11-18', NULL, 2),
    ('Íbis', '2012-06-11', NULL, 1),
    ('Bristol', '2016-03-22', NULL, 2);

INSERT INTO aeroporto (idparceiro, desconto, localizacao)
VALUES (1, 0.1, 'Rio de Janeiro'),
    (2, 0.15, 'Rio de Janeiro'),
    (3, 0.05, 'São Paulo'),
    (4, 0.1, 'São Paulo');

INSERT INTO redehoteis (idparceiro)
VALUES (5),
    (6);

INSERT INTO hotel (idredehoteis, desconto, localizacao)
VALUES (1, 0.05, 'Rio de Janeiro'),
    (1, 0.12, 'Rio de Janeiro'),
    (2, 0.03, 'São Paulo'),
    (2, 0.17, 'São Paulo');

INSERT INTO garagem (localizacao, capacidadecarros, capacidadecaminhoes)
VALUES ('Rio de Janeiro', 50, 10),
    ('São Paulo', 70, 20);

INSERT INTO carro (idgaragem, placa, preco, fabricante, modelo, ano, cor)
VALUES (1, 'IMZ3684', '198.00', 'Fiat', 'Uno', 2018, 'Vermelho'),
    (1, 'HXP5617', '142.79', 'Ford', 'Focus', 2017, 'Preto'),
    (1, 'MXH6276', '347.89', 'BMW', 'X5', 2019, 'Prata'),
    (2, 'HSN4794', '89.99', 'Fiat', 'Palio', 2014, 'Preto'),
    (2, 'MVE5132', '280.59', 'Nissan', 'Kicks', 2019, 'Branco'),
    (2, 'KAN3806', '240.95', 'Chevrolet', 'Camaro', 2018, 'Amarelo');

INSERT INTO caminhao (idgaragem, placa, fabricante, modelo, ano)
VALUES (1, 'JRP5547', 'Mercedes-Benz', 'Accelo', 2016),
    (1, 'LKW9792',  'Volvo', 'FH460', 2015),
    (2, 'MVM4216', 'Volvo', 'FH540', 2016),
    (2, 'NAA3743', 'Volkswagen', 'Constellation', 2019);

INSERT INTO estacaomanutencao (localizacao, horfunc)
VALUES ('Rio de Janeiro', '8:00-16:00'),
    ('São Paulo', '9:00-17:00'),
    ('São Paulo', '8:00-17:00');

INSERT INTO servicos (servico, idestacao)
VALUES ('conserto', 1),
    ('conserto', 2),
    ('conserto', 3),
    ('manutencao', 1),
    ('manutencao', 2),
    ('manutencao', 3);

INSERT INTO manutencao (idcarro, idestacao, entrada, saida)
VALUES (2, 1, '2019-05-21', '2019-05-26'),
    (4, 2, '2018-02-06', '2018-02-12'),
    (1, 1, '2019-07-02', '2018-07-04');

INSERT INTO aluguel (idcarro, idcliente, retirada, retorno)
VALUES (1, 1, '2019-06-26', '2019-07-06'),
    (3, 2, '2019-08-12', '2019-08-20'),
    (5, 3, '2019-03-02', '2019-03-08'),
    (6, 4, '2018-06-15', '2018-06-25'),
    (2, 5, '2017-08-21', '2017-09-05'),
    (4, 6, '2016-12-05', '2016-12-20');

/*
 * Flávio Nuno Maia de Sousa Filho - 115037071
 * João Ricardo Campbell Maia - 116111909
 * João Pedro Lopes Murtinho - 116040336
 *
 * Banco de Dados
 * Trabalho prático 1 - Script de consultas do banco de dados
 */

# 1-Listar o ID de todos os carros indisponíveis  (UNION)

SELECT IDCARRO 
FROM aluguel
WHERE retorno > CURDATE() OR retorno IS NULL
UNION
SELECT IDCARRO 
FROM manutencao
WHERE saida > CURDATE() OR saida IS NULL;

# 2-Listar os carros que atendem a um conjunto específico de fabricantes (IN)

SELECT idcarro, modelo 
FROM carro 
WHERE fabricante IN ('AUDI','VOLVO','FIAT','VOLKSWAGEN');

# 3-Listar todos os modelos com menos de 3 carros.  (GROUP BY,HAVING)

SELECT COUNT(*) QUANTIDADE, MODELO FROM CARRO GROUP BY MODELO HAVING COUNT(*) < 3;

# 4-Listar todos os clientes que alugaram todos os modelos de carro  (DIVISÃO,+3T)

SELECT nome, COUNT(DISTINCT MODELO) AS '#MODELODIFERENTE'
FROM ALUGUEL 
INNER JOIN CARRO ON CARRO.IDCARRO = ALUGUEL.IDCARRO
INNER JOIN cliente ON cliente.idcliente = aluguel.idcliente
INNER JOIN pessoa ON cliente.cpf = pessoa.cpf GROUP BY nome
HAVING COUNT(DISTINCT MODELO) = (SELECT  COUNT(DISTINCT MODELO) FROM CARRO);

# 5-Listar todos os clientes que alugaram um UNO  (EXISTS,+3T)

SELECT pessoa.nome 
FROM cliente 
INNER JOIN pessoa ON pessoa.cpf = cliente.cpf
WHERE EXISTS
    (SELECT idaluguel 
    FROM aluguel 
    INNER JOIN carro ON carro.IDCARRO = aluguel.IDCARRO 
    WHERE aluguel.idcliente = cliente.idcliente AND carro.MODELO = 'Uno');
    
# 6-Mostrar o quanto cada cliente gastou no total (+3T)

SELECT nome,  CONCAT('R$ ',FORMAT(DATEDIFF(retorno, retirada) * preco,2)) AS 'total gasto'
FROM pessoa 
INNER JOIN cliente ON cliente.cpf = pessoa.cpf
INNER JOIN aluguel ON aluguel.idcliente = cliente.idcliente
INNER JOIN carro ON carro.idcarro = aluguel.idcarro;

# 7-Listar todos os clientes que alugaram todos os carros (+3T)

SELECT NOME, COUNT(DISTINCT IDCARRO) AS '#CarrosDiferente' 
FROM ALUGUEL 
INNER JOIN cliente ON cliente.IDcliente = aluguel.IDCLIENTE
INNER JOIN pessoa ON pessoa.CPF = cliente.CPF
GROUP BY NOME
HAVING COUNT(DISTINCT idcarro) = (SELECT  COUNT(DISTINCT IDCARRO) FROM CARRO);

# 8-Consulta para trazer o nome do caminhoneiro e placa do caminhão (+3T)

SELECT nome,placa 
FROM caminhoneiro
INNER JOIN caminhao ON caminhoneiro.IDCAMINHAO = caminhao.IDCAMINHAO
INNER JOIN funcionario ON funcionario.IDFUNCIONARIO = caminhoneiro.IDFUNCIONARIO
INNER JOIN pessoa ON pessoa.CPF = funcionario.CPF;

# 9-Nome da pessoa com as placas dos carros já alugados por ela através do CPF (+3T)

SELECT nome,placa
FROM pessoa
INNER JOIN cliente ON pessoa.cpf = cliente.cpf
INNER JOIN aluguel ON cliente.IDCLIENTE = aluguel.IDCLIENTE
INNER JOIN carro ON carro.idcarro = aluguel.idcarro
WHERE cliente.cpf = "12345678910";

# 10 - Descobrir todos os hotéis com desconto no Rio de Janeiro (+3T)

SELECT parceiro.nome,desconto,hotel.localizacao,filial.idfilial
FROM filial
INNER JOIN parceiro ON filial.IDFILIAL = parceiro.IDFILIAL
INNER JOIN redehoteis ON parceiro.idparceiro = redehoteis.idparceiro
INNER JOIN hotel ON redehoteis.idredehoteis = hotel.idredehoteis
WHERE hotel.localizacao = "Rio de Janeiro";

# 11 - Buscar os funcionários que são gerenciados por alguém com Marcos no nome (+3T)

SELECT gerentePessoa.nome,gerenciadoPessoa.nome
FROM agente agentegerente 
INNER JOIN funcionario gerentes ON gerentes.idfuncionario = agentegerente.idfuncionario
INNER JOIN pessoa gerentePessoa ON gerentePessoa.cpf = gerentes.cpf
INNER JOIN gerencia ON gerencia.idgerente = agentegerente.idagente
INNER JOIN agente agentegerenciado ON agentegerenciado.idagente = gerencia.idagente
INNER JOIN funcionario gerenciado ON gerenciado.idfuncionario = agentegerenciado.idfuncionario
INNER JOIN pessoa gerenciadoPessoa ON gerenciadoPessoa.cpf = gerenciado.cpf
WHERE gerentePessoa.nome LIKE "%Marcos%";

# 12 - Buscar o nome de todos os caminhoneiros que não possuem caminhão  (+3T)

SELECT nome
FROM caminhoneiro
LEFT JOIN caminhao ON caminhoneiro.IDCAMINHAO = caminhao.IDCAMINHAO
INNER JOIN funcionario ON funcionario.IDFUNCIONARIO = caminhoneiro.IDFUNCIONARIO
INNER JOIN pessoa ON pessoa.CPF = funcionario.CPF
WHERE caminhao.idcaminhao IS NULL;

# 13 - Todos os carros que estão disponiveis (+3T)

SELECT DISTINCT carro.*
FROM carro 
WHERE idcarro NOT IN(SELECT idcarro FROM aluguel WHERE RETORNO > CURDATE())
AND idcarro NOT IN(SELECT idcarro FROM manutencao WHERE SAIDA > CURDATE());

/*
 * Flávio Nuno Maia de Sousa Filho - 115037071
 * João Ricardo Campbell Maia - 116111909
 * João Pedro Lopes Murtinho - 116040336
 *
 * Banco de Dados
 * Trabalho prático 1 - Script de criação dos papéis e views do banco de dados
 */

USE aluguelcarros;

DROP ROLE IF EXISTS 'funcionario'@'localhost',
    'gerente'@'localhost';

DROP USER IF EXISTS 'func1'@'localhost',
    'func2'@'localhost',
    'func3'@'localhost',
    'gerente1'@'localhost',
    'gerente2'@'localhost';

CREATE ROLE 'funcionario'@'localhost';

DROP VIEW IF EXISTS clientecompleto, aluguelcompleto;

CREATE VIEW clientecompleto AS
    SELECT pessoa.*, cliente.idcliente
    FROM pessoa INNER JOIN cliente ON pessoa.cpf = cliente.cpf;

CREATE VIEW aluguelcompleto AS
    SELECT carro.placa, carro.preco, carro.fabricante, carro.modelo, carro.ano, carro.cor, temp.*
    FROM (
        SELECT clientecompleto.cpf, clientecompleto.nome, aluguel.*
        FROM clientecompleto INNER JOIN aluguel ON clientecompleto.idcliente = aluguel.idcliente
    ) as temp INNER JOIN carro ON carro.idcarro = temp.idcarro;

GRANT SELECT, INSERT ON aluguelcarros.clientecompleto TO 'funcionario'@'localhost';
GRANT SELECT, INSERT ON aluguelcarros.aluguelcompleto TO 'funcionario'@'localhost';

CREATE USER 'func1'@'localhost',
    'func2'@'localhost',
    'func3'@'localhost';

GRANT 'funcionario'@'localhost' TO 'func1'@'localhost',
    'func2'@'localhost',
    'func3'@'localhost';

CREATE ROLE 'gerente'@'localhost';

DROP VIEW IF EXISTS agentecompleto, manutencaocompleto;

CREATE VIEW agentecompleto AS
    SELECT agente.idfilial, pf.*
    FROM (
        SELECT pessoa.nome, funcionario.*
        FROM pessoa INNER JOIN funcionario ON pessoa.cpf = funcionario.cpf
    ) AS pf INNER JOIN agente ON pf.idfuncionario = agente.idfuncionario
    WHERE agente.statusgerente IS FALSE;

CREATE VIEW manutencaocompleto AS
    SELECT carro.placa, carro.preco, carro.fabricante, carro.modelo, carro.ano, carro.cor, temp2.*
    FROM (
        SELECT estacaomanutencao.localizacao, estacaomanutencao.horfunc, manutencao.*
        FROM estacaomanutencao INNER JOIN manutencao ON estacaomanutencao.idestacao = manutencao.idestacao
    ) AS temp2 INNER JOIN carro ON carro.idcarro = temp2.idcarro;

GRANT SELECT ON aluguelcarros.agentecompleto TO 'gerente'@'localhost';
GRANT ALL ON aluguelcarros.manutencaocompleto TO 'gerente'@'localhost';
GRANT ALL ON aluguelcarros.clientecompleto TO 'funcionario'@'localhost';
GRANT ALL ON aluguelcarros.aluguelcompleto TO 'funcionario'@'localhost';

CREATE USER 'gerente1'@'localhost',
    'gerente2'@'localhost';

GRANT 'gerente'@'localhost' TO 'gerente1'@'localhost',
    'gerente2'@'localhost';
