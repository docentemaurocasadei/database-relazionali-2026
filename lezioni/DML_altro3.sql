SELECT JSON_EXTRACT('
{
    "nome": "Giovanni",
    "cognome": "Rossi",
    "anno_nascita": 1990,
    "citta": {"nome": "Roma", "cap": "00101"}
}', '$.citta.nome') AS citta_nome;


{
    "nome": "Maria",
}

SELECT JSON_OBJECT('nome', 'Maria', 'cognome', 'Bianchi', 'anno_nascita', 1985) AS persona;