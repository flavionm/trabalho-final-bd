/*
 * Flávio Sousa - 115037071
 * João Maia - 116111909
 * João Pedro - 116040336
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
