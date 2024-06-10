-- [M2S04] - Ex. 06 - Multi-Tabelas, Agregação e Agrupamento

-- 1. Encontre o total de itens pedidos em cada mês
SELECT DATE_TRUNC('month', p.data_pedido) AS mes, SUM(ip.quantidade) AS total_itens_pedidos
FROM pedidos p
JOIN itens_pedidos ip ON p.pedido_id = ip.pedido_id
GROUP BY mes
ORDER BY mes;

-- 2. Liste os clientes que não têm pedidos associados
SELECT c.cliente_id, c.nome, c.cidade, c.idade
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL;

-- 3. Encontre o pedido de maior valor
SELECT p.pedido_id, p.cliente_id, p.data_pedido, p.valor
FROM pedidos p
ORDER BY p.valor DESC
LIMIT 1;

-- 4. Encontre o total de itens pedidos para cada produto
SELECT pr.produto_id, pr.nome_produto, SUM(ip.quantidade) AS total_itens_pedidos
FROM produtos pr
JOIN itens_pedidos ip ON pr.produto_id = ip.produto_id
GROUP BY pr.produto_id, pr.nome_produto
ORDER BY total_itens_pedidos DESC;

-- 5. Calcule a soma dos valores dos pedidos para cada cliente que tenha feito mais de um pedido
SELECT p.cliente_id, c.nome, SUM(p.valor) AS soma_valores_pedidos
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
GROUP BY p.cliente_id, c.nome
HAVING COUNT(p.pedido_id) > 1
ORDER BY soma_valores_pedidos DESC;

-- 6. Encontre o preço médio dos produtos em cada categoria
SELECT c.categoria_id, c.nome_categoria, AVG(pr.preco) AS preco_medio
FROM produtos pr
JOIN categorias c ON pr.categoria_id = c.categoria_id
GROUP BY c.categoria_id, c.nome_categoria
ORDER BY preco_medio DESC;

-- 7. Encontre o cliente que fez o pedido de maior valor
SELECT c.cliente_id, c.nome, p.pedido_id, p.valor
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
ORDER BY p.valor DESC
LIMIT 1;
