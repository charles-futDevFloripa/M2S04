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
