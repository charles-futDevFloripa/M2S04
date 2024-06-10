-- [M2S04] - Ex. 07 - Consultas com Funções Agregadas e Subconsultas

-- 1. Função Agregada: Encontre a média de idade dos clientes que têm pedidos com valor total superior a 300,00
SELECT AVG(c.idade) AS media_idade
FROM clientes c
WHERE c.cliente_id IN (
    SELECT p.cliente_id
    FROM pedidos p
    GROUP BY p.cliente_id
    HAVING SUM(p.valor) > 300.00
);

-- 2. Subconsulta: Liste todos os produtos que foram pedidos mais de uma vez
SELECT pr.produto_id, pr.nome_produto, pr.preco
FROM produtos pr
WHERE pr.produto_id IN (
    SELECT ip.produto_id
    FROM itens_pedidos ip
    GROUP BY ip.produto_id
    HAVING COUNT(ip.produto_id) > 1
);
