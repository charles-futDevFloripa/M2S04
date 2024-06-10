-- Orientação tabelas:
-- Criar a tabela de clientes
CREATE TABLE clientes (
cliente_id SERIAL PRIMARY KEY,
nome VARCHAR(50),
cidade VARCHAR(50),
idade INT
);

-- Criar a tabela de pedidos
CREATE TABLE pedidos (
pedido_id SERIAL PRIMARY KEY,
cliente_id INT,
data_pedido DATE,
valor DECIMAL(10, 2),
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- Criar a tabela de produtos
CREATE TABLE produtos (
produto_id SERIAL PRIMARY KEY,
nome_produto VARCHAR(100),
preco DECIMAL(10, 2)
);

-- Criar a tabela de itens_pedidos
CREATE TABLE itens_pedidos (
item_id SERIAL PRIMARY KEY,
pedido_id INT,
produto_id INT,
quantidade INT,
FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

-- Inserir dados na tabela de clientes
INSERT INTO clientes (nome, cidade, idade) VALUES
('João Silva', 'São Paulo', 28),
('Maria Santos', 'Rio de Janeiro', 35),
('Carlos Souza', 'Belo Horizonte', 42),
('Ana Paula', 'Curitiba', 22),
('Pedro Costa', 'Porto Alegre', 30);

-- Inserir dados na tabela de pedidos
INSERT INTO pedidos (cliente_id, data_pedido, valor) VALUES
(1, '2023-01-15', 150.50),
(1, '2023-02-20', 200.00),
(2, '2023-03-05', 300.75),
(3, '2023-01-25', 450.60),
(4, '2023-02-10', 100.00);

-- Inserir dados na tabela de produtos
INSERT INTO produtos (nome_produto, preco) VALUES
('Produto A', 10.50),
('Produto B', 20.00),
('Produto C', 15.75),
('Produto D', 50.00),
('Produto E', 5.25);

-- Inserir dados na tabela de itens_pedidos
INSERT INTO itens_pedidos (pedido_id, produto_id, quantidade) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 5),
(3, 4, 1),
(4, 5, 3);



-- [M2S04] - Ex. 01 - Criação de Tabelas
-- Criar um arquivo SQL com os seguintes procedimentos:
-- Crie uma tabela chamada categorias com as seguintes colunas: categoria_id (chave primária), nome_categoria (VARCHAR(50)).
-- Adicione uma coluna categoria_id à tabela produtos e crie uma chave estrangeira para a tabela categorias.
-- Exclua a tabela categorias.


-- [M2S04] - Ex. 01 - Criação de Tabelas

-- 1. Criação da tabela categorias
CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

-- 2. Adição de uma coluna categoria_id à tabela produtos
ALTER TABLE produtos 
ADD COLUMN categoria_id INTEGER;

-- 3. Criação de chave estrangeira para a tabela categorias
ALTER TABLE produtos
ADD CONSTRAINT fk_categoria
FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id);

-- 4. Exclusão da tabela categorias
-- Para excluir a tabela categorias, é necessário remover a chave estrangeira da tabela produtos antes.
ALTER TABLE produtos
DROP CONSTRAINT fk_categoria;

ALTER TABLE produtos
DROP COLUMN categoria_id;

DROP TABLE IF EXISTS categorias;


-- [M2S04] - Ex. 02 - Inserção, Atualização e Exclusão de Dados
-- Criar um arquivo SQL com os seguintes procedimentos:
-- Insira um novo cliente na tabela clientes com os seguintes dados: nome: 'Lucas Lima', cidade: 'Salvador', idade: 29.
-- Atualize o campo cidade do cliente com cliente_id = 3 para 'Fortaleza'.
-- Delete todos os pedidos que têm valor inferior a 150.00.


-- [M2S04] - Ex. 02 - Manipulação de Dados

-- 1. Inserir um novo cliente na tabela clientes
INSERT INTO clientes (nome, cidade, idade) VALUES
    ('Lucas Lima', 'Salvador', 29);

-- 2. Atualizar o campo cidade do cliente com cliente_id = 3 para 'Fortaleza'
UPDATE clientes
SET cidade = 'Fortaleza'
WHERE cliente_id = 3;

-- 3. Deletar todos os pedidos que têm valor inferior a 150.00
DELETE FROM pedidos
WHERE valor < 150.00;



-- [M2S04] - Ex. 03 - Consultas Simples
-- Criar um arquivo SQL com os seguintes procedimentos:
-- Selecione todos os clientes que moram em 'São Paulo'.
-- Liste todos os pedidos, ordenados pela data_pedido em ordem decrescente.
-- Encontre todos os clientes com idade entre 25 e 35 anos.

-- [M2S04] - Ex. 03 - Consultas Simples

-- 1. Selecionar todos os clientes que moram em 'São Paulo'
SELECT *
FROM clientes
WHERE cidade = 'São Paulo';

-- 2. Listar todos os pedidos, ordenados pela data_pedido em ordem decrescente
SELECT *
FROM pedidos
ORDER BY data_pedido DESC;

-- 3. Encontrar todos os clientes com idade entre 25 e 35 anos
SELECT *
FROM clientes
WHERE idade BETWEEN 25 AND 35;

-- [M2S04] - Ex. 04 - Consultas com Filtros e Agrupamentos
-- Criar um arquivo SQL com os seguintes procedimentos:
-- Encontre todos os clientes cujo nome começa com a letra 'A'.
-- Calcule o valor total de pedidos para cada cliente.
-- Encontre a média de idade dos clientes em cada cidade.

-- [M2S04] - Ex. 04 - Consultas com Filtros e Agrupamentos

-- 1. Encontre todos os clientes cujo nome começa com a letra 'A'
SELECT *
FROM clientes
WHERE nome LIKE 'A%';

-- 2. Calcule o valor total de pedidos para cada cliente
SELECT c.cliente_id, c.nome, SUM(p.valor) AS valor_total_pedidos
FROM clientes c
JOIN pedidos p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id, c.nome
ORDER BY valor_total_pedidos DESC;

-- 3. Encontre a média de idade dos clientes em cada cidade
SELECT cidade, AVG(idade) AS media_idade
FROM clientes
GROUP BY cidade
ORDER BY media_idade DESC;

-- [M2S04] - Ex. 05 - Joins
-- Criar um arquivo SQL com os seguintes procedimentos:
-- Liste todos os pedidos junto com as informações dos clientes, usando um INNER JOIN.
-- Faça uma consulta que retorna todos os clientes e seus pedidos, incluindo clientes que não fizeram pedidos (use LEFT JOIN).
-- Faça uma consulta que retorna todos os produtos e seus itens pedidos, incluindo produtos que não foram pedidos (use RIGHT JOIN).
-- Utilize UNION para combinar duas consultas: uma que retorna clientes de 'São Paulo' e outra que retorna clientes de 'Rio de Janeiro'.

-- [M2S04] - Ex. 05 - Joins

-- 1. Liste todos os pedidos junto com as informações dos clientes, usando um INNER JOIN
SELECT p.pedido_id, p.data_pedido, p.valor, c.cliente_id, c.nome, c.cidade, c.idade
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id;

-- 2. Faça uma consulta que retorna todos os clientes e seus pedidos, incluindo clientes que não fizeram pedidos (use LEFT JOIN)
SELECT c.cliente_id, c.nome, c.cidade, c.idade, p.pedido_id, p.data_pedido, p.valor
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- 3. Faça uma consulta que retorna todos os produtos e seus itens pedidos, incluindo produtos que não foram pedidos (use RIGHT JOIN)
SELECT pr.produto_id, pr.nome_produto, pr.preco, ip.item_id, ip.pedido_id, ip.quantidade
FROM produtos pr
RIGHT JOIN itens_pedidos ip ON pr.produto_id = ip.produto_id;

-- 4. Utilize UNION para combinar duas consultas: uma que retorna clientes de 'São Paulo' e outra que retorna clientes de 'Rio de Janeiro'
SELECT * 
FROM clientes 
WHERE cidade = 'São Paulo'
UNION
SELECT * 
FROM clientes 
WHERE cidade = 'Rio de Janeiro';
