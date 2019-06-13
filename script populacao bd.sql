/*
 * Flávio Sousa - 115037071
 * João Maia -
 * João Pedro -
 * Banco de Dados -
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

INSERT INTO carro (idgaragem, fabricante, modelo, ano, cor)
VALUES (1, 'Fiat', 'Uno', 2018, 'Vermelho'),
    (1, 'Ford', 'Focus', 2017, 'Preto'),
    (1, 'BMW', 'X5', 2019, 'Prata'),
    (2, 'Fiat', 'Palio', 2014, 'Preto'),
    (2, 'Nissan', 'Kicks', 2019, 'Branco'),
    (2, 'Chevrolet', 'Camaro', 2018, 'Amarelo');

INSERT INTO caminhao (idgaragem, fabricante, modelo, ano)
VALUES (1, 'Mercedes-Benz', 'Accelo', 2016),
    (1, 'Volvo', 'FH460', 2015),
    (2, 'Volvo', 'FH540', 2016),
    (2, 'Volkswagen', 'Constellation', 2019);

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
