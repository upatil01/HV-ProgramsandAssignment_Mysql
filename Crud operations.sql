SELECT * FROM products.suppliers;
Retrieve product names and their corresponding supplier names
SELECT p.Product_name, s.Suppliers_name FROM products p JOIN suppliers s ON p.Product_id = s.Product_id;

Find products with a price above 50 and their suppliers
SELECT p.Price, s.suppliers_name FROM products p JOIN suppliers s ON p.Product_id = s.Prod_id WHERE p.price > 50;
Retrieve products with specific suppliers (e.g., supplier_id 1 and 2)
select p.product_name,s.supplier_name from products p join supplier s on p.product_id = s.product_id where s.supplier_id=1 or s.supplier_id=2;

select p.product_name,s.supplier_name from products p join supplier s on p.product_id = s.product_id where s.supplier_id  in (1,3);

Calculate the average price of products supplied by each supplier