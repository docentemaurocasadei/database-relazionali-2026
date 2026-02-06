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

SELECT 