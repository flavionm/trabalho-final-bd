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

DROP VIEW IF EXISTS pessoacliente;

CREATE VIEW pessoacliente AS
    SELECT pessoa.*, cliente.idcliente
    FROM pessoa INNER JOIN cliente ON pessoa.cpf = cliente.cpf;

GRANT SELECT, INSERT ON aluguelcarros.pessoacliente TO 'funcionario'@'localhost';

CREATE USER 'func1'@'localhost',
    'func2'@'localhost',
    'func3'@'localhost';

GRANT 'funcionario'@'localhost' TO 'func1'@'localhost',
    'func2'@'localhost',
    'func3'@'localhost';

CREATE ROLE 'gerente'@'localhost';

DROP VIEW IF EXISTS agenteempregado;

CREATE VIEW agenteempregado AS
    SELECT agente.idfilial, pf.*
    FROM (
        SELECT pessoa.nome, funcionario.*
        FROM pessoa INNER JOIN funcionario ON pessoa.cpf = funcionario.cpf
    ) AS pf INNER JOIN agente ON pf.idfuncionario = agente.idfuncionario
    WHERE agente.statusgerente IS FALSE;

GRANT SELECT ON aluguelcarros.agenteempregado TO 'gerente'@'localhost';

CREATE USER 'gerente1'@'localhost',
    'gerente2'@'localhost';

GRANT 'gerente'@'localhost' TO 'gerente1'@'localhost',
    'gerente2'@'localhost';
