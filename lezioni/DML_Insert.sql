#inserire dati in una tabella SQL
#per inserire i dati in una tabella si usa il comando INSERT INTO
#3 officine
INSERT INTO ricambi.workshops (
    business_name, 
    vat_number,
    street_address,
    street_number,
    city,
    province,
    phone,
    pec,
    email
    ) VALUES (
        'Officina Meccanica Rossi',
        '12345678901',
        'Via Roma',
        '10',
        'Milano',
        'MI',
        '0245678901',
        'officina.rossi@pec.it',
        'info@officina.rossi.it'
    ),(
        'Autofficina Bianchi',
        '10987654321',
        'Corso Venezia',
        '25',
        'Torino',
        'TO',
        '0112345678',
        'autofficina.bianchi@pec.it',
        'info@autofficina.bianchi.it'
    ),(
        'Centro Revisioni Verdi',
        '11223344556',
        'Piazza Duomo',
        '5',
        'Firenze',
        'FI',
        '0551234567',
        'centro.revisioni.verdi@pec.it',
        'info@centro.revisioni.verdi.it'
    );

#2 categorie
INSERT INTO ricambi.categories (name, description) VALUES 
('Freni', 'Componenti per il sistema frenante'), 
('Sospensioni', 'Componenti per il sistema di sospensione');


#2 prodotti ogni categoria
INSERT INTO `ricambi`.`products`
(`category_id`,
`sku`,
`name`,
`sell_price`,
`description`,
`stock_quantity`)
VALUES
(1,
'FRN-001',
'Pastiglie Freni Standard',
19.99,
'Pastiglie freni di alta qualità per veicoli standard.',
100),
(1, 
'FRN-002',
'Dischi Freni Ventilati',
49.99,
'Dischi freni ventilati per una migliore dissipazione del calore.',
50),
(2, 
'SPS-001',
'Ammortizzatori Anteriori',
89.99,
'Ammortizzatori anteriori per una guida confortevole.',
75),
(2, 
'SPS-002',
'Ammortizzatori Posteriori',
89.99,
'Ammortizzatori posteriori per una guida stabile.',
60);



#3 fornitori
INSERT INTO `ricambi`.`suppliers`
(`company_name`,
`vat_number`,
`street_address`,
`street_number`,
`city`,
`province`,
`phone`,
`email`)
VALUES
('Supplier One Srl',
'12345678901',
'Via Milano',
'15',
'Roma',
'RM',
'0612345678',
'supplier.one@example.com'
),
('Supplier Two Spa',
'10987654321',
'Corso Napoli',
'22',
'Bologna',
'BO',
'05112345678',
'supplier.two@example.com'
),
('Supplier Three Sas',
'11223344556',
'Piazza Torino',
'5',
'Torino',
'TO',
'01112345678',   
'supplier.three@example.com'
);

# associazione tra prodotti e fornitori
INSERT INTO `ricambi`.`product_supplier`
(`product_id`,
`supplier_id`,
`supply_cost`)
VALUES
(1, 1, 12.50),
(1, 2, 13.00),
(2, 1, 30.00),
(2, 3, 28.50),
(3, 2, 60.00),
(3, 3, 58.00),
(4, 1, 62.00),
(4, 2, 61.50);



#5 ordini, ogni ordine con almeno 2 prodotti
INSERT INTO `ricambi`.`orders`
(`workshops_id`,
`order_date`,
`status`)
VALUES
(1, '2024-01-15', 'In lavorazione'),
(2, '2024-01-20', 'Completato'),
(3, '2024-01-25', 'Spedito'),
(1, '2024-02-01', 'In lavorazione'),
(2, '2024-02-05', 'Completato');

INSERT INTO `ricambi`.`order_item`
(`orders_id`,
`products_id`,
`quantity`,
`unit_price`)
VALUES
(1, 1, 2, 19.99),
(1, 3, 1, 89.99),
(2, 2, 1, 49.99),
(2, 4, 2, 89.99),
(3, 1, 3, 19.99),
(3, 2, 1, 49.99),
(4, 3, 2, 89.99),
(4, 4, 1, 89.99),
(5, 1, 1, 19.99),
(5, 4, 2, 89.99);


