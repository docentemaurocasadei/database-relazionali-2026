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
INSERT INTO orders (order_date, status, workshop_id) 
VALUES ('2026-02-10', 'In Bozza', 2);
SET @last_order_id = LAST_INSERT_ID();

insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, 1, 2, 50.00), 
(@last_order_id, 2, 5, 22.50);

insert into products (name, description, stock_quantity, sell_price)
VALUES ('Kit frizione', 'Kit frizione completo per auto', 20, 150.00);

SET @last_product_id = LAST_INSERT_ID();

insert into order_item (order_id, product_id, quantity, unit_price)
VALUES (@last_order_id, 3, 1, 98.90);



select @last_order_id;
select @last_product_id;

