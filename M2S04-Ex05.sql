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
