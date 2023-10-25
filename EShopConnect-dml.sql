-- 2. Crie visualizações (views) para fazer o seguinte:

-- a) Consultar todos os produtos existentes na loja
SELECT * FROM product;


-- b) Consultar os nomes de todos os usuários
SELECT nome FROM users;


-- c) Consultar as lojas que vendem produtos
SELECT 
	s.name AS LOJA, p.name AS PRODUTO
FROM 
	store AS s
INNER JOIN
	product AS p ON s.pk_sid = p.fk_sid;



-- d) Consultar os endereços relacionando com os clientes;
SELECT
u.pk_userID AS ID, a.streetAddr AS RUA, a.city AS CIDADE, u.nome AS Cliente
from 
	address AS a
INNER JOIN 
	users AS u ON a.pk_addID = u.pk_userID
INNER JOIN
	buyer AS b ON u.pk_userID = b.pk_userID;


-- e) Consultar todos os produtos do tipo laptop;
SELECT
	name, fk_brandName, type
FROM
	product
WHERE
	type = "laptop";
    

-- f) Consultar o endereço, hora de inicio (start time) e hora final (end time) dos pontos de serviço damesma cidade que o usuário cujo ID é 5.
SELECT
    sp.city,
    sp.startTime,
    sp.endTime
FROM
    servicepoint as sp
JOIN
    address as a ON sp.city = a.city
WHERE
    a.fk_userID = 5;


-- g) Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart),considerando a loja com ID (sid) igual a 8.
SELECT 
	SUM(sc.quantity) as quantidade_total
FROM
	save_to_shopping_card as sc
JOIN
    product as p
ON
	p.pk_pid = sc.fk_pid
WHERE
	p.fk_sid = 8;


-- h) Consultar os comentários do produto 123456789.
SELECT 
	p.name AS PRODUTO, c.grade AS NOTA, c.content AS COMENTÁRIO
FROM
	comments AS c
INNER JOIN
	product AS p ON p.pk_pid = '123456789';
    

