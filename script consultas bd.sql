/*
 * Flávio Sousa - 115037071
 * João Maia - 116111909
 * João Pedro - 116040336
 * Banco de Dados -
 * Trabalho prático 1 - Script de população do banco de dados
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

# 3-Listar todos os modelos com menos de 3 carros disponíveis.  (GROUP BY,HAVING)

SELECT COUNT(*) QUANTIDADE, MODELO FROM CARRO GROUP BY MODELO HAVING COUNT(*) < 3;

# 4-Listar todos os clientes que alugaram todos os modelos de carro  (DIVISÃO,+3T)  ERRO

SELECT nome, COUNT(DISTINCT MODELO) AS '#MODELODIFERENTE'
FROM ALUGUEL 
INNER JOIN CARRO ON CARRO.IDCARRO = ALUGUEL.IDCARRO
INNER JOIN cliente ON cliente.idcliente = aluguel.idcliente
INNER JOIN pessoa ON cliente.cpf = pessoa.cpf
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
SELECT nome,  'R$'+FORMAT(DATEDIFF(retorno, retirada) * preco,2) AS 'total gasto'
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

# 11 - Buscar os funcionários que são gerenciados por alguém com Lucas no nome (+3T)

SELECT gerentePessoa.nome,gerenciadoPessoa.nome
FROM agente agentegerente 
INNER JOIN funcionario gerentes ON gerentes.idfuncionario = agentegerente.idfuncionario
inner join pessoa gerentePessoa on gerentePessoa.cpf = gerentes.cpf
INNER JOIN gerencia ON gerencia.idgerente = agentegerente.idagente
INNER JOIN agente agentegerenciado ON agentegerenciado.idagente = gerencia.idagente
INNER JOIN funcionario gerenciado ON gerenciado.idfuncionario = agentegerenciado.idfuncionario
inner join pessoa gerenciadoPessoa on gerenciadoPessoa.cpf = gerenciado.cpf
WHERE gerentePessoa.nome LIKE "%Lucas%";

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
LEFT JOIN aluguel ON aluguel.idcarro = carro.idcarro
LEFT JOIN manutencao ON manutencao.idcarro = aluguel.idcarro
WHERE SAIDA <= CURDATE() OR RETORNO <= CURDATE() OR (saida IS NULL AND retorno IS NULL)
