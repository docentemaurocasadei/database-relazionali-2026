#operatori artimetici nella SELECT
SELECT products.name, products.sell_price, 
products.sell_price * 1.22 AS prezzo_ivato
FROM products;

SELECT products.name, products.sell_price,
ROUND(products.sell_price / 1.22, 2) AS prezzo_senza_iva
FROM products;

SELECT products.name, stock_quantity % 6 AS prodotti_orfani, 
FLOOR(stock_quantity / 6) AS scatole_complete
FROM products;

#MYSQL FUNCTIONS
SELECT UPPER(CONCAT(street_address, ', ', street_number)) AS indirizzo_completo
FROM ricambi_mc.workshops;

SELECT LENGTH('Autofficina Bianchì 😊') AS lunghezza_nome; #25
SELECT CHAR_LENGTH('Autofficina Bianchì 😊') AS lunghezza_nome; #21

SELECT SUBSTRING(workshops.business_name, 1, 5) AS estratto_nome
FROM ricambi_mc.workshops
WHERE workshops.id >= 2; 

SELECT suppliers.company_name, LOCATE('-', email) AS posizione_chiocciola
FROM suppliers
WHERE email IS NOT NULL;

SELECT products.id, REPLACE(products.sku, '-', '|') AS sku_con_pipe
FROM products;

SELECT CONCAT_WS(' \n ', workshops.business_name, 
CONCAT(workshops.street_address, ', ', workshops.street_number),
workshops.city, workshops.province) AS indirizzo_completo
FROM workshops;

SELECT DATEDIFF(CURDATE(), order_date) AS giorni_dall_ordine
FROM orders;

SELECT TIMESTAMPDIFF(MONTH, order_date, CURDATE()) AS mesi_trascorsi
FROM orders;

SELECT DATE_FORMAT(order_date, '%d/%m/%Y') AS data_italiana
FROM orders;

SELECT ADDDATE(order_date, INTERVAL 30 DAY) AS data_pagamento_prevista
FROM orders;  

# MOSTRARE TUTTI GLI ORDINI LA CUI DATA DI PAGAMENTO NON E' ANCORA ARRIVATA (FUTURA)
#DATA DI PAGAMENTO = order_date + 30 GIORNI
SELECT id, order_date, status, ADDDATE(order_date, INTERVAL 30 DAY) as data_previsto_pagamento
FROM orders
WHERE ADDDATE(order_date, INTERVAL 30 DAY) > CURDATE();   

#mysql functions (numberiche)
SELECT ABS(-50) AS valore_assoluto;

#CEIL è L'ARROTONDAMENTO PER ECCESSO
#IPOTIZZIAMO DI VOLERE CREARE UN NUOVO "LISTINO" prodotti
# DOVE IL PREZZO DI PRODOTTO è AUMENTATO DEL 15% 
#E ARROTONDATO ALL'EURO SUPERIORE

SELECT name, sell_price, 
CEIL(sell_price * 1.15) AS prezzo_aumentato
FROM products;

#richiedere un numero randomico tra 1 e 50
SELECT CEIL(RAND() * 50) AS numero_randomico;

#contare il numero totale di prodotti nel magazzino
SELECT count(*) AS totale_prodotti FROM products;

# ============================================
SELECT COUNT(*) AS prodotti_maggiori_20 FROM products
WHERE sell_price > 20.00;

#NUMERO TOTALE DI PRODOTTI IN MAGAZZINO (GIACENZA TOTALE)
SELECT SUM(stock_quantity) AS totale_giacenza FROM products;

#VALORE MEDIO DI GIACENZA PER PRODOTTO
SELECT AVG(stock_quantity) AS giacenza_media FROM products;

#PREZZO MEDIO DEI PRODOTTI
SELECT AVG(sell_price) AS prezzo_medio FROM products;

#QUANTI PRODOTTI IN UN ORDINE
SELECT order_id, COUNT(*) AS numero_prodotti, 
SUM(unit_price * quantity) AS totale_ordine
FROM order_item
GROUP BY order_id; 

#mostrare la categoria e quanti prodotti appartengono a ciascuna categoria
SELECT categories.name,category_id, COUNT(*) AS numero_prodotti
FROM products JOIN categories
ON products.category_id = categories.id
GROUP BY category_id;

#1mostrare il numero di ordini effettuati da ciascun cliente mostrando solo
il workshop_id e il numero di ordini
SELECT workshop_id, COUNT(*) AS numero_ordini
FROM orders
GROUP BY workshop_id;


#2 aggiungere il business_name del workshop
SELECT workshops.business_name, orders.workshop_id, COUNT(*) AS numero_ordini
FROM orders JOIN workshops  
ON orders.workshop_id = workshops.id
GROUP BY orders.workshop_id;

SELECT ROW_NUMBER() OVER (PARTITION BY workshop_id ORDER BY workshop_id),workshop_id, id  FROM orders;

SELECT id, 
IF(updated_at IS NULL, 'MAI AGGIORNATO', 'AGGIORNATO') AS aggiornamento_ordine
FROM orders;
SELECT JSON_OBJECT('id', id, 'company_name', company_name, 
'email', email) AS info_fornitore
FROM suppliers

#{"id": 1, "business_name": "Forniture Inc.", "email": "info@fornitureinc.com"}

13 (ma non considerate having), 18,19,22,23,24,25