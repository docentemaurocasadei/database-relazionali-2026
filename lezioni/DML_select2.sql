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