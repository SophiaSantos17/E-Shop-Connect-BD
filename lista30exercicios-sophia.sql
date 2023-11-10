-- 1. Selecione todos os nomes e números de telefones de usuário
SELECT nome AS NOME, phoneNumber AS TELEFONE FROM users;
 
 
-- 2. Liste o nome dos compradores
SELECT nome FROM users WHERE pk_userID IN(SELECT * FROM buyer);
 
 
-- 3. Liste o nome dos vendedores
SELECT nome FROM users WHERE pk_userID IN(SELECT * FROM seller);
 
 
-- 4. Encontre todas as informações de cartão de crédito dos usuários.
-- credito
SELECT 
	bank.pk_cardNumber, bank.expiryDate, bank.bank, credito.fk_userID, credito.organization
FROM 
	bankCard AS bank 
JOIN
	creditcard AS credito
ON 
	bank.pk_cardNumber = credito.pk_cardNumber;
 
 
-- debito
SELECT bank.pk_cardNumber, bank.expiryDate, bank.bank, debito.fk_userID
FROM bankCard AS bank
JOIN debitCard AS debito 
ON bank.pk_cardNumber = debito.pk_cardNumber;
 
 
-- 5. Selecione os nomes dos produtos e seus preços.
SELECT 
	NAME AS PRODUTO, price AS PREÇO 
FROM 
	product;
 
 
-- 6. Liste todos os produtos de uma determinada marca (por exemplo,'Samsung').
SELECT 
	name AS PRODUTO, fk_brandName AS MARCA, price AS PREÇO
FROM 
	product 
WHERE 
	fk_brandName = "microsoft";
 
 
-- 7. Encontre o número de itens em cada pedido.
SELECT 
	fk_orderNumber AS NUM_PEDIDO, SUM(qunatity) AS QUANTIDADE_ITENS 
FROM contain
GROUP BY NUM_PEDIDO 
ORDER BY QUANTIDADE_ITENS DESC;
 
 
-- 8. Calcule o total de vendas por loja
SELECT
	s.name AS STORE_NAME,
    sum(o.price) AS PREÇO
FROM store AS s
INNER JOIN product AS p ON s.pk_sid = p.fk_sid 
INNER JOIN orderitem AS o ON p.pk_pid = o.fk_pid
GROUP BY STORE_NAME;
 
 
-- 9. Liste as avaliações dos produtos(grade) com seus nomes e conteúdo de usuário
SELECT 
	u.nome AS USUÁRIO, p.name AS PRODUTO, c.grade AS NOTA, c.content AS COMENTÁRIO  
FROM 
	comments AS c 
INNER JOIN 
	product AS p ON c.fk_pid = p.pk_pid
INNER JOIN
	users AS u ON c.fk_userID = u.pk_userID
ORDER BY grade DESC;
 
 
-- 10. Selecione os nomes dos compradores que fizeram pedidos
SELECT 
	DISTINCT u.nome
FROM 
	buyer AS b
JOIN users u ON b.pk_userID = u.pk_userID
JOIN creditcard AS c ON u.pk_userID = c.fk_userID
JOIN payment AS p ON c.pk_cardNumber = p.fk_creditCardNumber;
 
 
-- 11. Encontre os vendedores que gerenciam várias lojas.
SELECT 
	u.pk_userID AS ID, st.name AS LOJA, u.nome AS VENDEDOR
FROM
	users AS u
JOIN seller AS sl ON u.pk_userID = sl.pk_userID
JOIN manage AS m ON sl.pk_userID = m.fk_userid
JOIN store AS st ON m.fk_sid = st.pk_sid;
 
 
-- 12. Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple")
SELECT
	s.name AS LOJA, p.fk_brandName AS MARCA
FROM
	product AS p
JOIN store AS s ON p.fk_sid = s.pk_sid
WHERE p.fk_brandName = "Microsoft";
 
 
-- 13. Encontre as informações de entrega de um pedido específico (por exemplo, orderNumber = 123)
SELECT
	a.province, a.city AS CIDADE, a.streetAddr AS RUA, a.postCode AS CEP, o.pk_orderNumber
FROM
	orders AS o
JOIN deliver_to AS d ON o.pk_orderNumber = d.fk_orderNumber
JOIN address AS a ON d.fk_addID = a.pk_addID
WHERE o.pk_orderNumber = "76023921";
 
 
-- 14. Calcule o valor médio das compras dos compradores.
SELECT 
    AVG(o.totalAmount) AS MEDIA
FROM 
    orders AS o
JOIN payment AS p ON o.pk_orderNumber = p.fk_orderNumber
JOIN creditcard AS c ON p.fk_creditCardNumber = c.pk_cardNumber
JOIN users AS u ON c.fk_userID = u.pk_userID
JOIN buyer AS b ON u.pk_userID = b.pk_userID;

 

 
-- 15. Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York")
SELECT 
	b.pk_brand AS MARCA, sp.city AS CIDADE
FROM 
	brand AS b
JOIN after_sales_service_at AS ass ON b.pk_brand = ass.fk_brandName
JOIN servicepoint AS sp ON ass.fk_spid = sp.pk_spid
WHERE sp.city ="Montreal";
 
 
-- 16. Encontre o nome e o endereço das lojas com uma classificação de cliente superior a 4.
SELECT 
	name AS LOJA, streetaddr AS ENDEREÇO, costumerGrade AS NOTA
FROM 
	store 
WHERE costumerGrade > 4;
 
 
-- 17. Liste os produtos com estoque esgotado.
SELECT 
	name AS PRODUTO
FROM
	product
WHERE amount = 0;
 
 
-- 18. Encontre os produtos mais caros em cada marca
SELECT 
    b.pk_brand AS MARCA, 
    p.name AS PRODUTO, 
    MAX(p.price) AS PREÇO
FROM 
    brand b
JOIN product p ON b.pk_brand = p.fk_brandName
GROUP BY b.pk_brand, p.name;


 
 
-- 19. Calcule o total de pedidos em que um determinado cartão de crédito (por exemplo, cardNumber = '1234567890') foi usado.
SELECT 
	fk_creditCardNumber AS CARTÃO, COUNT(fk_orderNumber) AS QUANTIDADE_COMPRAS
FROM
	payment 
WHERE fk_creditCardNumber = "4023 1231 3431 8623";


-- 20. Liste os nomes e números de telefone dos usuários que não fizeram pedidos
SELECT 
	u.nome AS USUÁRIO, u.phoneNumber AS TELEFONE
FROM 
	users AS u
LEFT JOIN orders AS o ON u.pk_userID = o.pk_orderNumber
WHERE o.pk_orderNumber IS NULL;
 
 
-- 21.Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4.
SELECT 
	p.name nome, c.grade
FROM
	product p
JOIN comments AS c ON p.pk_pid = c.fk_pid
WHERE c.grade > 4;
 
 
-- 22.Encontre os nomes dos vendedores que não gerenciam nenhuma loja.
SELECT
	u.nome AS Vendedores,
	count(st.pk_sid) AS lojas
FROM
	users AS u
JOIN seller AS s ON u.pk_userID = s.pk_userID
JOIN manage AS m ON s.pk_userID = m.fk_userid
JOIN store AS st ON  m.fk_sid = st.pk_sid
GROUP BY nome
HAVING lojas = 0;
 
 
-- 23.Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.
SELECT
	u.pk_userID AS ID,
    u.nome AS NOME,
    COUNT(o.pk_orderNumber) AS qtde_pedidos
FROM users u
JOIN creditCard cc ON u.pk_userID = cc.fk_userID
JOIN bankCard bc ON cc.pk_cardNumber = bc.pk_cardNumber
JOIN payment p ON bc.pk_cardNumber = p.fk_creditCardNumber
JOIN orders o ON p.fk_orderNumber = o.pk_orderNumber
GROUP BY ID, NOME
HAVING qtde_pedidos >= 3;
 
 
-- 24.Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito.
SELECT
	count(cc.pk_cardNumber) credito,
    count(db.pk_cardNumber) debito
FROM
	payment p
LEFT OUTER JOIN creditcard cc
ON p.fk_creditcardNumber = cc.pk_cardNumber
LEFT OUTER JOIN debitcard db
ON p.fk_creditcardNumber = db.pk_cardNumber;


-- 26. Calcule a quantidade média de produtos disponíveis em todas as lojas.
SELECT 
	AVG(amount) AS QUANTIDADE_MEDIA
FROM
	product;
 
 
-- 27. Encontre os nomes das lojas que não têm produtos em estoque (amount = 0).
SELECT 
	s.name AS LOJA
FROM 
	store AS s
JOIN product p ON s.pk_sid = p.fk_sid
GROUP BY s.name
HAVING SUM(p.amount) = 0;
 
 
-- 28. Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo".
SELECT
	u.nome AS VENDEDOR, st.name AS LOJA, st.city AS CIDADE_LOJA
FROM
	users AS u
JOIN seller s ON u.pk_userID = s.pk_userID
JOIN manage AS m ON u.pk_userID = m.fk_userid
JOIN store AS st ON m.fk_sid = st.pk_sid
WHERE st.city = 'São Paulo';
 
 
-- 29. Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.
SELECT 
	fk_brandName AS MARCA, COUNT(pk_pid) AS TOTAL_PRODUTOS
FROM
	product
WHERE fk_brandName = "Microsoft";
 
 
-- 30. Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1).
SELECT u.pk_userID AS ID, u.nome AS CLIENTE, SUM(o.totalAmount) AS TOTAL_COMPRAS
FROM users u
JOIN creditCard cc ON u.pk_userID = cc.fk_userID
JOIN bankCard bc ON cc.pk_cardNumber = bc.pk_cardNumber
JOIN payment p ON bc.pk_cardNumber = p.fk_creditCardNumber
JOIN orders o ON p.fk_orderNumber = o.pk_orderNumber
WHERE u.pk_userID = 5
GROUP BY u.pk_userID, u.nome, u.phoneNumber, bc.pk_cardNumber;
 