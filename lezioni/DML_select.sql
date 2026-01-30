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