#DELETE
DELETE FROM suppliers WHERE id = 4;

#TRANSAZIONI
START TRANSACTION;
try {
    INSERT INTO orders (order_date, status, workshop_id) VALUES ('2026-02-10', 'pending', 1);
    INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES (LAST_INSERT_ID(), 1, 2, 50.00);
    INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES (LAST_INSERT_ID(), 2, 2, 50.00);
    INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES (LAST_INSERT_ID(), 3, 1, 100.00);
    UPDATE products SET stock_quantity = stock_quantity - 2 WHERE id = 1;
    UPDATE products SET stock_quantity = stock_quantity - 2 WHERE id = 2;
    UPDATE products SET stock_quantity = stock_quantity - 1 WHERE id = 3;
    UPDATE orders SET status = 'In Lavorazione' WHERE id = LAST_INSERT_ID();
    COMMIT;
} catch (Exception $e) {
    ROLLBACK;
}   
UPDATE suppliers SET company_name = 'Nuova Azienda' WHERE id = 2;
DELETE FROM suppliers WHERE id = 1;
ROLLBACK;

#SAVEPOINT
START TRANSACTION;
UPDATE suppliers SET company_name = 'Nuova Azienda' WHERE id = 2;
SAVEPOINT after_update_supplier;
UPDATE products SET stock_quantity = stock_quantity - 10 WHERE id = 1;
SAVEPOINT after_update_product;
ROLLBACK TO after_update_supplier;
COMMIT;

#Esercizio: 
- aggiornare la quantity del prodotto con id 3 dell'ordine con id 1 a quantità: 5
- aggiornare la stock_quantity del prodotto con id 3 diminuendola di 5
- utilizzare le transazioni in modo da annullare entrambe le operazioni
START TRANSACTION;
UPDATE order_item SET quantity = 5 WHERE order_id = 1 AND product_id = 3;
UPDATE products SET stock_quantity = stock_quantity - 5 WHERE id = 3;
ROLLBACK;


- dopo la UPDATE products inserire un savepoint 
- aggiungere dopo al savepoint una insert per inserire il prodotto con id 2 
nell\'ordine 1 (unit_price: 50.00, quantity: 4)
- alla fine fare un rollback al savepoint in modo da annullare solo 
l\'inserimento del prodotto 2

START TRANSACTION;
UPDATE order_item SET quantity = 5 WHERE order_id = 1 AND product_id = 3;
UPDATE products SET stock_quantity = stock_quantity - 5 WHERE id = 3;
SAVEPOINT after_update_product;
INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES (1, 2, 4, 50.00);
ROLLBACK TO after_update_product;

#variabili locali
#inserisco un ordine
INSERT INTO orders (order_date, status, workshop_id) 
VALUES ('2026-02-10', 'In Bozza', 2);
SET @last_order_id = LAST_INSERT_ID();

#inserisco 2 prodotti per quell'ordine
insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, 1, 2, 50.00), 
(@last_order_id, 2, 5, 22.50);

#inserisco un nuovo prodotto 
insert into products (name, description, stock_quantity, sell_price, category_id, sku)
VALUES ('Kit frizione', 'Kit frizione completo per auto', 20, 150.00, 2, 'KF123');

SET @last_product_id = LAST_INSERT_ID();

insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, 3, 1, 98.90);

#aggiungo all\'ordine appena creato il nuovo prodotto
insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, @last_product_id, 11, 145.90);

select @last_order_id;
select @last_product_id;

#esercizio:
#inserire un nuovo workshop con i seguenti dati:
#business_name: Officina Milano & Co
#fiscal_code: 00123123145
#street_number: 10
#street_address: Via Roma
#city: Verona

#salvare l'id del workshop appena inserito in una variabile 
#inserire un nuovo ordine per quel workshop 
#nell'ordine inseire 2 prodotti 
- 5 con quantità 3 e unit_price 50.00
- 6 con quantità 2 e unit_price 22.50

START TRANSACTION;
INSERT INTO workshops 
(business_name, fiscal_code, street_number, street_address, city, vat_number) 
VALUES 
('Officina Ancona & Co', '00123123145', '10', 'Via Roma', 'Ancona', '00023322558');

set @last_workshop_id = LAST_INSERT_ID();

INSERT INTO orders (order_date, status, workshop_id) 
VALUES ('2026-02-10', 'In Bozza', @last_workshop_id);

set @last_order_id = LAST_INSERT_ID();

insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, 5, 3, 50.00),
(@last_order_id, 6, 2, 22.50);  

select @last_workshop_id;
select @last_order_id;
COMMIT;


#ESTRAE GLI ORDINI CHE SONO STATI EFFETTUATI
DAL 01/02/2026 AL 10/02/2026 
- TOTALE ORDINE

CREATE OR REPLACE VIEW vw_order_totals AS
SELECT orders.id, orders.order_date,  
SUM(order_item.quantity * order_item.unit_price) AS total_order
FROM orders
JOIN order_item ON orders.id = order_item.order_id
WHERE orders.order_date BETWEEN '2026-02-01' AND '2026-02-10'
GROUP BY orders.id, orders.order_date;

#STORED PROCEDURE
DELIMITER $$
DROP PROCEDURE IF EXISTS pc_get_order_total $$
CREATE PROCEDURE pc_get_order_total(IN p_order_id INT, OUT p_total DECIMAL(10,2)) 
BEGIN
    SELECT SUM(quantity * unit_price) INTO p_total
    FROM order_item
    WHERE order_id = p_order_id;

END $$

DELIMITER ;
CALL pc_get_order_total(1, @total);
SELECT @total;

#Esercizio STORED PROCEDURE:
1. creare una stored procedure che prenda in input un id 
di workshop e restituisca il numero totale di ordini effettuati da quel workshop

1a: chiamare con CALL() la stored procedure per un workshop a scelta

2. aggiungere alla stored procedure altri 2 parametri di input: 
data_inizio e data_fine, in modo da restituire il numero totale di ordini effettuati 
da quel workshop in un intervallo di date specifico

2a: chiamare con CALL() la stored procedure per un workshop a scelta e 
un intervallo di date a scelta

#SOLUZIONE 1a
DELIMITER $$
DROP PROCEDURE IF EXISTS pc_get_workshop_order_count $$
CREATE PROCEDURE pc_get_workshop_order_count(IN p_workshop_id INT, OUT p_order_count INT)
BEGIN
    SELECT COUNT(*) INTO p_order_count FROM orders 
    WHERE workshop_id = p_workshop_id;
END $$

DELIMITER ;

CALL pc_get_workshop_order_count(4, @order_count);
SELECT @order_count;

#SOLUZIONE 2a
DELIMITER $$
DROP PROCEDURE IF EXISTS pc_get_workshop_order_count_by_date $$
CREATE PROCEDURE pc_get_workshop_order_count_by_date(
    IN p_workshop_id INT, 
    IN p_start_date DATE, 
    IN p_end_date DATE, 
    OUT p_order_count INT)
BEGIN
    SELECT COUNT(*) INTO p_order_count FROM orders 
    WHERE workshop_id = p_workshop_id
    AND order_date BETWEEN p_start_date AND p_end_date;
END $$

DELIMITER ;

CALL pc_get_workshop_order_count_by_date(4, '2026-02-01', '2026-02-10', @order_count);
SELECT @order_count;

#STORED FUNCTION
#creare una funzione che prenda in input un id di supplier e restituisca il numero di prodotti forniti da quel supplier


DELIMITER $$
DROP FUNCTION IF EXISTS fn_supplier_product_count $$
CREATE FUNCTION fn_supplier_product_count(p_supplier_id int)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE product_count INT;
    SELECT COUNT(*) INTO product_count FROM product_supplier WHERE supplier_id = p_supplier_id;
    RETURN product_count;
END $$

DELIMITER ;
SELECT fn_supplier_product_count(1);
SELECT fn_supplier_product_count(2);
SELECT fn_supplier_product_count(3);
SELECT fn_supplier_product_count(4);

#TRIGGER

CREATE TABLE `ricambi_mc`.`order_logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL,
  `action` VARCHAR(45) NULL,
  `message` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE);

DELIMITER $$

#creare un trigger che dopo l'inserimento di un nuovo ordine nella tabella orders, inserisca una nuova riga nella tabella order_logs con i seguenti dati:
- order_id: id dell'ordine appena inserito
CREATE TRIGGER tr_order_status_create
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_logs (order_id, action, message) 
    VALUES (NEW.id, 'CREATED',CONCAT('Ordine creato da: ', USER()));
END $$
DELIMITER ;