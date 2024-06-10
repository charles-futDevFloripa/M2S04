
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
