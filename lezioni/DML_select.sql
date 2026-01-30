SELECT * FROM products;

SELECT id, category_id as category, `name` FROM ricambi.products;

SELECT id from categories;

#JOIN tra products e categories
SELECT products.name, products.sku, categories.name FROM products 
JOIN categories ON products.category_id = categories.id; 

SELECT p.name, p.sku, c.name FROM products p
JOIN categories c ON p.category_id = c.id; 

#query che estrae tutti gli item 
dall'ordine con il nome del prodotto

SELECT oi.orders_id, pr.name 
FROM order_item oi JOIN products pr
ON oi.products_id = pr.id 

#estrarre tutti gli ordini mostrando i campi 
#order_date, status e business_name del workshops

# 2024-01-15 In lavorazione Officina Meccanica Rossi
SELECT order_date, status, business_name FROM orders
JOIN workshops ON workshops_id = workshops.id;

SELECT order_date, status, business_name FROM orders
JOIN workshops ON orders.workshops_id = workshops.id
JOIN order_item ON orders.id = order_item.orders_id;

# ============================================
estrarre tutti i prodotti
mostrando il nome del prodotto, sku
e il company_name del fornitore che lo fornisce

SELECT 
`products`.`name` as product_name, 
products.sku, 
suppliers.company_name, 
categories.name as category_name
FROM products
JOIN product_supplier ON products.id = product_supplier.product_id
JOIN suppliers ON product_supplier.supplier_id = suppliers.id
JOIN categories ON products.category_id = categories.id;

#cancellare una categoria
set FOREIGN_KEY_CHECKS=0;
delete from categories where id = 1;
set FOREIGN_KEY_CHECKS=1;

#left join
SELECT 
`products`.`name` as product_name, 
products.sku, 
suppliers.company_name,
categories.name as category_name
FROM products
JOIN product_supplier ON products.id = product_supplier.product_id
JOIN suppliers ON product_supplier.supplier_id = suppliers.id
LEFT JOIN categories ON products.category_id = categories.id;

#operatori di confronto nella WHERE
SELECT * FROM products WHERE stock_quantity BETWEEN 60 AND 80;
SELECT * FROM products WHERE stock_quantity >= 60 AND stock_quantity <= 80;
SELECT * FROM products WHERE stock_quantity != 60;
SELECT * FROM products WHERE SKU IN ('FRN-001','FRN-002');
#EQUIVALE
SELECT * FROM products WHERE SKU='FRN-001' or SKU='FRN-002';
#like
SELECT * FROM products WHERE name LIKE '%freni%'; #contengono freni
SELECT * FROM products WHERE name LIKE 'pastiglie%'; #contengono freni

SELECT * FROM products where category_id IS NULL;


#richiesta 1
#estrarre tutti gli ordini 
#dell'officina 'Autofficina Bianchi'
#mostrando worshops.id, business_name, order_date
SELECT w.id, w.business_name, o.order_date
FROM workshops w
JOIN orders o ON w.id = o.workshop_id
WHERE w.business_name = 'Autofficina Bianchi';


#richiesta 2
#estrarre tutte le officine che hanno
#comprato il prodotto con sku 'FRN-002'
SELECT w.business_name FROM workshops w
JOIN orders o ON w.id = o.workshop_id
JOIN order_item oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.sku = 'FRN-002';


#richiesta 3
#estrarre tutte le officine che hanno
#comprato almeno un prodotto del fornitore 'Supplier Two Spa'
SELECT w.business_name FROM workshops w
JOIN orders o ON w.id = o.workshop_id
JOIN order_item oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN product_supplier ps ON p.id = ps.product_id
JOIN suppliers s ON ps.supplier_id = s.id
WHERE s.company_name = 'Supplier Two Spa'