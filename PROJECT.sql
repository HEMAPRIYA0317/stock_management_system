CREATE DATABASE stock_management;
USE stock_management;

-- 1. Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 2. Subcategories
CREATE TABLE subcategories (
    subcategory_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    subcategory_name VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. Brands
CREATE TABLE brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL
);

-- 4. Units
CREATE TABLE units (
    unit_id INT PRIMARY KEY AUTO_INCREMENT,
    unit_name VARCHAR(50) NOT NULL
);

-- 5. Warehouses
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_name VARCHAR(100),
    location VARCHAR(100)
);

-- 6. Suppliers
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(100)
);

-- 7. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(100)
);

-- 8. Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    role VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- 9. Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    subcategory_id INT,
    brand_id INT,
    unit_id INT,
    supplier_id INT,
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    reorder_level INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategories(subcategory_id),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 10. Stock Movements
CREATE TABLE stock_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    warehouse_id INT,
    movement_type ENUM('IN','OUT'),
    quantity INT,
    movement_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- 11. Purchases
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    employee_id INT,
    purchase_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 12. Purchase Details
CREATE TABLE purchase_details (
    purchase_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 13. Sales
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    employee_id INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 14. Sales Details
CREATE TABLE sales_details (
    sale_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 15. Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

-- 16. Returns
CREATE TABLE returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT,
    product_id INT,
    quantity INT,
    return_date DATE,
    reason TEXT,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 17. Discounts
CREATE TABLE discounts (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    discount_percentage DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 18. Audit Logs
CREATE TABLE audit_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100),
    action_type VARCHAR(50),
    action_date DATETIME,
    performed_by INT,
    FOREIGN KEY (performed_by) REFERENCES employees(employee_id)
);
USE stock_management;

-- 1. Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics','Electronic items'),
('Groceries','Daily essentials'),
('Clothing','Apparel'),
('Stationery','Office supplies'),
('Furniture','Home furniture'),
('Sports','Sports goods'),
('Toys','Kids toys'),
('Footwear','Shoes'),
('Cosmetics','Beauty items'),
('Automobile','Vehicle parts'),
('Books','Reading materials'),
('Hardware','Tools'),
('Jewelry','Accessories'),
('Pharmacy','Medicines'),
('Pet Supplies','Pet items'),
('Garden','Gardening tools');

-- 2. Subcategories
INSERT INTO subcategories (category_id, subcategory_name) VALUES
(1,'Mobiles'),(1,'Laptops'),
(2,'Rice'),(2,'Oil'),
(3,'Men Wear'),(3,'Women Wear'),
(4,'Pens'),(4,'Notebooks'),
(5,'Chairs'),(5,'Tables'),
(6,'Cricket'),(6,'Football'),
(7,'Action Figures'),(8,'Sports Shoes'),
(9,'Skincare'),(10,'Car Parts');

-- 3. Brands
INSERT INTO brands (brand_name) VALUES
('Samsung'),('Apple'),('Nike'),('Adidas'),
('Puma'),('Dell'),('HP'),('Lenovo'),
('Sony'),('LG'),('Nestle'),('Amul'),
('Classmate'),('Reynolds'),('IKEA'),('Honda');

-- 4. Units
INSERT INTO units (unit_name) VALUES
('Piece'),('Kg'),('Litre'),('Box'),
('Pack'),('Dozen'),('Meter'),('Set'),
('Pair'),('Bottle'),('Tablet'),('Strip'),
('Gram'),('Carton'),('Roll'),('Unit');

-- 5. Warehouses
INSERT INTO warehouses (warehouse_name, location) VALUES
('WH1','Chennai'),('WH2','Bangalore'),('WH3','Hyderabad'),
('WH4','Mumbai'),('WH5','Delhi'),('WH6','Kolkata'),
('WH7','Pune'),('WH8','Coimbatore'),
('WH9','Madurai'),('WH10','Trichy'),
('WH11','Salem'),('WH12','Vizag'),
('WH13','Jaipur'),('WH14','Lucknow'),
('WH15','Bhopal'),('WH16','Patna');

-- 6. Suppliers
INSERT INTO suppliers (supplier_name, phone, email, city) VALUES
('Supplier1','9000000001','s1@mail.com','Chennai'),
('Supplier2','9000000002','s2@mail.com','Bangalore'),
('Supplier3','9000000003','s3@mail.com','Hyderabad'),
('Supplier4','9000000004','s4@mail.com','Mumbai'),
('Supplier5','9000000005','s5@mail.com','Delhi'),
('Supplier6','9000000006','s6@mail.com','Pune'),
('Supplier7','9000000007','s7@mail.com','Madurai'),
('Supplier8','9000000008','s8@mail.com','Trichy'),
('Supplier9','9000000009','s9@mail.com','Salem'),
('Supplier10','9000000010','s10@mail.com','Coimbatore'),
('Supplier11','9000000011','s11@mail.com','Jaipur'),
('Supplier12','9000000012','s12@mail.com','Lucknow'),
('Supplier13','9000000013','s13@mail.com','Bhopal'),
('Supplier14','9000000014','s14@mail.com','Patna'),
('Supplier15','9000000015','s15@mail.com','Vizag'),
('Supplier16','9000000016','s16@mail.com','Kolkata');

-- 7. Customers
INSERT INTO customers (customer_name, phone, email, city) VALUES
('Customer1','8000000001','c1@mail.com','Chennai'),
('Customer2','8000000002','c2@mail.com','Bangalore'),
('Customer3','8000000003','c3@mail.com','Hyderabad'),
('Customer4','8000000004','c4@mail.com','Mumbai'),
('Customer5','8000000005','c5@mail.com','Delhi'),
('Customer6','8000000006','c6@mail.com','Pune'),
('Customer7','8000000007','c7@mail.com','Madurai'),
('Customer8','8000000008','c8@mail.com','Trichy'),
('Customer9','8000000009','c9@mail.com','Salem'),
('Customer10','8000000010','c10@mail.com','Coimbatore'),
('Customer11','8000000011','c11@mail.com','Jaipur'),
('Customer12','8000000012','c12@mail.com','Lucknow'),
('Customer13','8000000013','c13@mail.com','Bhopal'),
('Customer14','8000000014','c14@mail.com','Patna'),
('Customer15','8000000015','c15@mail.com','Vizag'),
('Customer16','8000000016','c16@mail.com','Kolkata');

-- 8. Employees
INSERT INTO employees (employee_name, role, salary, hire_date) VALUES
('Emp1','Manager',50000,'2023-01-01'),
('Emp2','Sales',25000,'2023-02-01'),
('Emp3','Sales',26000,'2023-03-01'),
('Emp4','Purchase',30000,'2023-04-01'),
('Emp5','Cashier',22000,'2023-05-01'),
('Emp6','Store Keeper',24000,'2023-06-01'),
('Emp7','HR',35000,'2023-07-01'),
('Emp8','Admin',28000,'2023-08-01'),
('Emp9','Sales',27000,'2023-09-01'),
('Emp10','Sales',26000,'2023-10-01'),
('Emp11','Manager',52000,'2023-11-01'),
('Emp12','Cashier',23000,'2023-12-01'),
('Emp13','Store Keeper',25000,'2024-01-01'),
('Emp14','Purchase',31000,'2024-02-01'),
('Emp15','Admin',29000,'2024-03-01'),
('Emp16','Sales',25500,'2024-04-01');

-- 9. Products (16 valid references)
INSERT INTO products (product_name, category_id, subcategory_id, brand_id, unit_id, supplier_id, price, stock_quantity, reorder_level) VALUES
('iPhone',1,1,2,1,1,80000,50,10),
('Galaxy',1,1,1,1,2,60000,40,10),
('Rice Bag',2,3,11,2,3,1200,100,20),
('Sunflower Oil',2,4,11,3,4,150,200,30),
('T-Shirt',3,5,3,1,5,800,70,15),
('Dell Laptop',1,2,6,1,6,55000,30,5),
('Notebook',4,8,13,1,7,50,500,50),
('Chair',5,9,15,1,8,2000,25,5),
('Cricket Bat',6,11,3,1,9,1500,60,10),
('Football',6,12,4,1,10,1200,80,15),
('Running Shoes',8,14,4,9,11,3000,45,10),
('Face Cream',9,15,12,1,12,250,90,20),
('Car Mirror',10,16,16,1,13,1200,35,5),
('Novel Book',11,16,14,1,14,300,120,25),
('Medicine Strip',14,15,15,12,15,100,200,30),
('Garden Shovel',16,16,15,1,16,600,40,10);

-- 10. Stock Movements
INSERT INTO stock_movements (product_id, warehouse_id, movement_type, quantity, movement_date) VALUES
(1,1,'IN',20,'2024-01-01'),
(2,2,'IN',15,'2024-01-02'),
(3,3,'IN',50,'2024-01-03'),
(4,4,'IN',60,'2024-01-04'),
(5,5,'IN',25,'2024-01-05'),
(6,6,'IN',10,'2024-01-06'),
(7,7,'IN',100,'2024-01-07'),
(8,8,'IN',15,'2024-01-08'),
(9,9,'IN',30,'2024-01-09'),
(10,10,'IN',40,'2024-01-10'),
(11,11,'OUT',5,'2024-01-11'),
(12,12,'OUT',10,'2024-01-12'),
(13,13,'OUT',4,'2024-01-13'),
(14,14,'OUT',8,'2024-01-14'),
(15,15,'OUT',20,'2024-01-15'),
(16,16,'OUT',6,'2024-01-16');

-- 11–18 Transaction tables (each 16 rows)

INSERT INTO purchases (supplier_id, employee_id, purchase_date, total_amount) VALUES
(1,4,'2024-01-01',200000),(2,4,'2024-01-02',150000),(3,14,'2024-01-03',50000),(4,14,'2024-01-04',25000),
(5,4,'2024-01-05',100000),(6,4,'2024-01-06',80000),(7,14,'2024-01-07',30000),(8,14,'2024-01-08',45000),
(9,4,'2024-01-09',60000),(10,4,'2024-01-10',70000),(11,14,'2024-01-11',55000),(12,14,'2024-01-12',20000),
(13,4,'2024-01-13',40000),(14,4,'2024-01-14',35000),(15,14,'2024-01-15',15000),(16,14,'2024-01-16',25000);

INSERT INTO sales (customer_id, employee_id, sale_date, total_amount) VALUES
(1,2,'2024-02-01',90000),(2,3,'2024-02-02',60000),(3,9,'2024-02-03',5000),(4,10,'2024-02-04',2000),
(5,16,'2024-02-05',1500),(6,2,'2024-02-06',70000),(7,3,'2024-02-07',3000),(8,9,'2024-02-08',2500),
(9,10,'2024-02-09',10000),(10,16,'2024-02-10',5000),(11,2,'2024-02-11',4500),(12,3,'2024-02-12',3500),
(13,9,'2024-02-13',4000),(14,10,'2024-02-14',6000),(15,16,'2024-02-15',3000),(16,2,'2024-02-16',2000);

INSERT INTO payments (sale_id, payment_date, payment_method, amount) VALUES
(1,'2024-02-01','Cash',90000),(2,'2024-02-02','UPI',60000),(3,'2024-02-03','Card',5000),(4,'2024-02-04','Cash',2000),
(5,'2024-02-05','UPI',1500),(6,'2024-02-06','Card',70000),(7,'2024-02-07','Cash',3000),(8,'2024-02-08','UPI',2500),
(9,'2024-02-09','Card',10000),(10,'2024-02-10','Cash',5000),(11,'2024-02-11','UPI',4500),(12,'2024-02-12','Card',3500),
(13,'2024-02-13','Cash',4000),(14,'2024-02-14','UPI',6000),(15,'2024-02-15','Card',3000),(16,'2024-02-16','Cash',2000);

INSERT INTO discounts (product_id, discount_percentage, start_date, end_date) VALUES
(1,10,'2024-01-01','2024-01-31'),(2,5,'2024-01-01','2024-01-31'),
(3,15,'2024-01-01','2024-01-31'),(4,8,'2024-01-01','2024-01-31'),
(5,12,'2024-01-01','2024-01-31'),(6,7,'2024-01-01','2024-01-31'),
(7,20,'2024-01-01','2024-01-31'),(8,10,'2024-01-01','2024-01-31'),
(9,5,'2024-01-01','2024-01-31'),(10,18,'2024-01-01','2024-01-31'),
(11,6,'2024-01-01','2024-01-31'),(12,9,'2024-01-01','2024-01-31'),
(13,11,'2024-01-01','2024-01-31'),(14,13,'2024-01-01','2024-01-31'),
(15,14,'2024-01-01','2024-01-31'),(16,10,'2024-01-01','2024-01-31');

USE stock_management;

-- 1. View all products
SELECT * FROM products;

-- 2. Products with category name
SELECT p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 3. Products with brand name
SELECT p.product_name, b.brand_name, p.price
FROM products p
JOIN brands b ON p.brand_id = b.brand_id;

-- 4. Low stock products
SELECT product_name, stock_quantity, reorder_level
FROM products
WHERE stock_quantity <= reorder_level;

-- 5. Products above 50000
SELECT product_name, price
FROM products
WHERE price > 50000;

-- 6. Total number of products
SELECT COUNT(*) AS total_products FROM products;

-- 7. Average product price
SELECT AVG(price) AS avg_price FROM products;

-- 8. Maximum product price
SELECT MAX(price) AS max_price FROM products;

-- 9. Total sales amount
SELECT SUM(total_amount) AS total_sales FROM sales;

-- 10. Total purchase amount
SELECT SUM(total_amount) AS total_purchase FROM purchases;

-- 11. Sales with customer name
SELECT s.sale_id, c.customer_name, s.total_amount
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id;

-- 12. Purchases with supplier name
SELECT p.purchase_id, s.supplier_name, p.total_amount
FROM purchases p
JOIN suppliers s ON p.supplier_id = s.supplier_id;

-- 13. Sales count by employee
SELECT e.employee_name, COUNT(s.sale_id) AS total_sales
FROM employees e
JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_name;

-- 14. Product-wise total sold quantity
SELECT p.product_name, SUM(sd.quantity) AS total_sold
FROM sales_details sd
JOIN products p ON sd.product_id = p.product_id
GROUP BY p.product_name;

-- 15. Supplier-wise purchase count
SELECT s.supplier_name, COUNT(p.purchase_id) AS purchase_count
FROM suppliers s
JOIN purchases p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name;

-- 16. Categories having more than 1 product
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 1;

-- 17. Employees with more than 2 sales
SELECT e.employee_name, COUNT(s.sale_id) AS sales_count
FROM employees e
JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_name
HAVING COUNT(s.sale_id) > 2;

-- 18. Product with highest price
SELECT product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- 19. Sales above average sales amount
SELECT sale_id, total_amount
FROM sales
WHERE total_amount > (SELECT AVG(total_amount) FROM sales);

-- 20. Sales in February 2024
SELECT * FROM sales
WHERE MONTH(sale_date) = 2 AND YEAR(sale_date) = 2024;

-- 21. Purchases between two dates
SELECT * FROM purchases
WHERE purchase_date BETWEEN '2024-01-01' AND '2024-01-10';

-- 22. Warehouse-wise stock movements
SELECT w.warehouse_name, COUNT(sm.movement_id) AS movements
FROM stock_movements sm
JOIN warehouses w ON sm.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name;

-- 23. Discount details with product
SELECT p.product_name, d.discount_percentage
FROM discounts d
JOIN products p ON d.product_id = p.product_id;

-- 24. Total returned quantity per product
SELECT p.product_name, SUM(r.quantity) AS total_returned
FROM returns r
JOIN products p ON r.product_id = p.product_id
GROUP BY p.product_name;

-- 25. Estimated profit per product
SELECT product_name,
       (price * 0.2) AS estimated_profit
FROM products;