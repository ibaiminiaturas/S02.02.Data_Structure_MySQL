DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE pizzeria (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	full_address VARCHAR(100) NOT NULL,
	zip_code VARCHAR(10) NOT NULL,
	city VARCHAR(60) NOT NULL,
	province VARCHAR(60) NOT NULL
);

CREATE TABLE employee (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	employee_name VARCHAR(60) NOT NULL,
	surname1 VARCHAR(60) NOT NULL,
	surname2 VARCHAR(60) NOT NULL,
	nif VARCHAR(20) NOT NULL,
	phone VARCHAR(20) NOT NULL,
    position ENUM ('cooker', 'runner') NOT NULL,
	pizzeria INT UNSIGNED NOT NULL,
	CONSTRAINT fk_pizzeria FOREIGN KEY (pizzeria) REFERENCES pizzeria(id)
    );
    
CREATE TABLE pizza_type (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	type_name VARCHAR(60) NOT NULL
);


CREATE TABLE product (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_type ENUM('pizza', 'burger', 'drinks')NOT NULL,
    description  VARCHAR(100) NOT NULL,
    image  VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
    
);
    

CREATE TABLE pizza (
	id INT UNSIGNED PRIMARY KEY,
	pizza_type_id INT UNSIGNED NOT NULL,
	CONSTRAINT fk_pizza_type FOREIGN KEY (pizza_type_id) REFERENCES pizza_type(id),
    CONSTRAINT fk_pizza_id FOREIGN KEY (id) REFERENCES product(id)
);
     
CREATE TABLE customer (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	customer_name VARCHAR(100) NOT NULL,
	surname1 VARCHAR(60) NOT NULL,
	surname2 VARCHAR(60) NOT NULL,
	full_address VARCHAR(100) NOT NULL,
	zip_code VARCHAR(10) NOT NULL,
	city VARCHAR(60) NOT NULL,
	province VARCHAR(60) NOT NULL,
	phone VARCHAR(20) NOT NULL,
    UNIQUE (customer_name, surname1, surname2)
);
 
 
 CREATE TABLE customer_order (
 	id INT UNSIGNED AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    order_type ENUM ('take_away', 'delivery') NOT NULL, 
    time_stamp DATETIME NOT NULL,
	order_price DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customer(id)
 );
 
 CREATE TABLE order_products (
	order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    amount INT UNSIGNED NOT NULL, 
    PRIMARY KEY (order_id, product_id),
	CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES customer_order(id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(id)
 );
 

CREATE TABLE delivery (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
    runner_id INT UNSIGNED NOT NULL,
    time_stamp DATETIME NOT NULL,
	CONSTRAINT fk_employee FOREIGN KEY (runner_id) REFERENCES employee(id),
    CONSTRAINT fk_order_delivery FOREIGN KEY (id) REFERENCES customer_order(id)
);


INSERT INTO pizzeria (full_address, zip_code, city, province) VALUES
('123 Main St', '10001', 'New York', 'New York'),
('456 Elm St', '90001', 'Los Angeles', 'California');

INSERT INTO employee (employee_name, surname1, surname2, nif, phone, position, pizzeria) VALUES
('John', 'Doe', 'Smith', 'NIF001', '555-0101', 'cooker', 1),
('Alice', 'Brown', 'Jones', 'NIF002', '555-0102', 'runner', 1),
('Carlos', 'Garcia', 'Lopez', 'NIF003', '555-0103', 'cooker', 2),
('Emma', 'Johnson', 'Martinez', 'NIF004', '555-0104', 'runner', 2);


INSERT INTO pizza_type (type_name) VALUES
('Margherita'),
('Pepperoni'),
('Hawaiian');

INSERT INTO product (product_type, description, image, price) VALUES
('pizza', 'Classic Margherita Pizza', 'margherita.jpg', 8.99), 
('pizza', 'Spicy Pepperoni Pizza', 'pepperoni.jpg', 9.99),     
('pizza', 'Hawaiian Pizza', 'hawaiian.jpg', 10.49),           
('burger', 'Cheeseburger', 'cheeseburger.jpg', 6.99),          
('drinks', 'Cola', 'cola.jpg', 1.99),                        
('drinks', 'Orange Juice', 'oj.jpg', 2.49);                     

INSERT INTO pizza (id, pizza_type_id) VALUES
(1, 1),  
(2, 2), 
(3, 3);  

INSERT INTO customer (customer_name, surname1, surname2, full_address, zip_code, city, province, phone) VALUES
('Michael', 'Scott', 'Halpert', '1725 Slough Ave', '18504', 'Scranton', 'Pennsylvania', '570-0001'),
('Pam', 'Beesly', 'Halpert', '42 Art Lane', '18504', 'Scranton', 'Pennsylvania', '570-0002');

INSERT INTO customer_order (customer_id, order_type, time_stamp, order_price) VALUES
(1, 'delivery', '2025-05-28 12:00:00', 18.97),  
(2, 'take_away', '2025-05-28 13:00:00', 9.99);  

INSERT INTO order_products (order_id, product_id, amount) VALUES
(1, 1, 1),  
(1, 5, 1),
(2, 2, 1);  

INSERT INTO delivery (id, runner_id, time_stamp) VALUES
(1, 2, '2025-05-28 12:30:00');  -- Delivered by Alice






