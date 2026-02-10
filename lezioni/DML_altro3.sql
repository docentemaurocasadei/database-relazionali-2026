SELECT JSON_EXTRACT('
{
    "nome": "Giovanni",
    "cognome": "Rossi",
    "anno_nascita": 1990,
    "citta": {"nome": "Roma", "cap": "00101"}
}', '$.citta.nome') AS citta_nome;


UPDATE `ricambi_mc`.`workshops` SET `legale_rappresentante` = 
'{
    "nome": "Maria",
    "cognome": "Bianchi",
    "anno_nascita": 1985,
    "citta": {"nome": "Milano", "cap": "20100"},
    "interessi" : ["musica", "sport", "lettura"],
    "titolo_studio": "laurea"
}'
 WHERE (`id` = '2');


SELECT JSON_OBJECT('nome', 'Maria', 'cognome', 'Bianchi', 'anno_nascita', 1985) AS persona;

SELECT 
JSON_UNQUOTE(
    JSON_EXTRACT(
        legale_rappresentante, '$.nome'
    )
) AS nome_rappresentante
FROM `ricambi_mc`.`workshops`;

#[A-z]{6}[\d]{2}[A-t]{1}[0-9]{2}[A-z0-9]{4}[A-z]{1}

SELECT fiscal_code, 
REGEXP_LIKE(fiscal_code, '^[A-Z]{6}[0-9]{2}[A-T]{1}[0-9]{2}[A-Z0-9]{4}[A-Z]{1}$') AS is_valid
FROM `ricambi_mc`.`workshops`;

#estrarre tutti i record dove un workshops ha una partita iva non valida 
#(non ha 11 cifre numeriche)
SELECT vat_number,
IF(REGEXP_LIKE(vat_number, '^[0-9]{11}$'), 'valido', 'invalido') AS is_valid
FROM `ricambi_mc`.`workshops`
WHERE NOT REGEXP_LIKE(vat_number, '^[0-9]{11}$');

SELECT DISTINCT(status) from orders;

SELECT COUNT(status) AS totale_status, status
FROM orders
GROUP BY status;

SELECT CONCAT('ws: ',business_name),'ws' as source from `ricambi_mc`.`workshops`
UNION
SELECT CONCAT('sup: ',company_name),'sup' as source from `ricambi_mc`.`suppliers`;

username: [' UNION SELECT company_name from suppliers; --
password: [password123]
invia

SELECT nome,cognome FROM utenti WHERE
username = 'giovanni' and password = 'password123';

#id 25 (200 OK)
# (404 NOT FOUND)

Ricerca[maglia]

query_exec("SELECT * FROM prodotti WHERE nome LIKE ?;", ['%maglia%']);

SELECT count(*) AS totale_ordini, workshop_id FROM orders
group by workshop_id
HAVING count(*) > 2;

SELECT business_name FROM workshops JOIN orders ON workshops.id = orders.workshop_id
WHERE orders.id IN (
SELECT order_id FROM order_item
JOIN orders ON orders.id = order_item.order_id
GROUP BY order_id
HAVING SUM(unit_price * quantity) > 200);


1. estrarre tutti i prodotti che hanno un prezzo sell_price superiore a 10 euro
mostrando solamente l'id del product

SELECT id FROM products WHERE sell_price > 10; [1,2,3,4]

2. estrarre con una IN tutti gli ordini che hanno uno di quei prodotti (SOLO id ordine  )
SELECT DISTINCT order_id FROM order_item
WHERE product_id IN (SELECT id FROM products WHERE sell_price > 10);

SELECT order_id FROM order_item 
WHERE EXISTS (
    SELECT 1 FROM products WHERE sell_price > 10 
    AND products.id = order_item.product_id
);

#ESTRARRE TUTTI I workshops in provincia MI o TO (con IN)
SELECT * FROM workshops WHERE province IN ('MI', 'TO');

ESTRARRE tutti gli ordini (id, order_date, status) fatti da un workshop 
in provincia MI o TO (con IN)
SELECT orders.id, orders.order_date, orders.status
FROM orders
WHERE orders.workshop_id IN (
    SELECT id FROM workshops WHERE province IN ('MI', 'TO')
);

#con EXISTS
SELECT orders.id, orders.order_date, orders.status
FROM orders
WHERE EXISTS (
    SELECT 1 FROM workshops 
    WHERE workshops.id = orders.workshop_id 
    AND workshops.province IN ('MI', 'TO')
);


SELECT orders.id, orders.order_date, orders.status, 
order_item.product_id, order_item.quantity, order_item.unit_price
FROM orders
JOIN order_item ON orders.id = order_item.order_id
ORDER BY order_item.unit_price DESC
LIMIT 3;

SELECT ADDDATE(CAST('2026-02-06' AS DATE), INTERVAL 1 DAY) AS data_cast;

SELECT ADDDATE('2026-02-06', INTERVAL 1 DAY) AS data_cast;

UPDATE `ricambi_mc`.`workshops` SET 
fiscal_code='CRANPM90A01H501Y', street_number='12B'
WHERE (`id` = '3');

#inserire un nuovo workshop con i seguenti dati:
#business_name: Officina Milano & Co
#fiscal_code: RSSGFF85C01H501Z
#street_number: 10
#province: MI
#vat_number: 00255455215
#street_address: Via Roma
#city: Milano
INSERT INTO `ricambi_mc`.`workshops` (
    business_name, 
    vat_number,
    street_address,
    street_number,
    city,
    province
    ) VALUES (
        'Officina Milano & Co',
        '00255455215',
        'Via Roma',
        '10',
        'Milano',
        'MI'
    );

#aggiornare il record appena inserito aggiungendo un telefono: 021231231 
e una email: info@officinamilano.it
UPDATE `ricambi_mc`.`workshops` SET 
phone = '021231231',
email = 'info@officinamilano.it'
WHERE (`id` = '4');


#aggiornare il record appena inserito aggiungendo un legale rappresentante con i seguenti dati:
#nome: Luca
#cognome: Verdi
#anno_nascita: 1980
#citta: {"nome": "Milano", "cap": "20100"}

UPDATE `ricambi_mc`.`workshops` SET 
legale_rappresentante = JSON_OBJECT(
    'nome', 'Luca',
    'cognome', 'Verdi',
    'anno_nascita', 1980,
    'citta', JSON_OBJECT('nome', 'Milano', 'cap', '20100')
)
WHERE (`id` = '4');

oppure

UPDATE `ricambi_mc`.`workshops` SET 
legale_rappresentante = {
    "nome": "Luca",
    "cognome": "Verdi",
    "anno_nascita": 1980,
    "citta": {"nome": "Milano", "cap": "20100"}
}
WHERE (`id` = '4');
