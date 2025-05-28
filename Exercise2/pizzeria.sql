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
	nif VARCHAR(20) NOT NULL UNIQUE,
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
    product_description  VARCHAR(100) NOT NULL,
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
    pizzeria_id INT UNSIGNED NOT NULL, 
    server_id  INT UNSIGNED NOT NULL, 
    time_stamp DATETIME NOT NULL,
	order_price DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customer(id),
    CONSTRAINT fk_customer_order_pizzera FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id),
    CONSTRAINT fk_customer_order_server_id FOREIGN KEY (server_id) REFERENCES employee(id)
 );
 
 CREATE TABLE order_product (
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
('Calle Mayor 1', '28001', 'Madrid', 'Madrid'),
('Av. Diagonal 100', '08019', 'Barcelona', 'Barcelona');

INSERT INTO employee (employee_name, surname1, surname2, nif, phone, position, pizzeria) VALUES
('Carlos', 'Gómez', 'López', '12345678A', '600123456', 'cooker', 1),
('Lucía', 'Pérez', 'Martínez', '23456789B', '600234567', 'runner', 1),
('David', 'Fernández', 'Ruiz', '34567890C', '600345678', 'cooker', 2),
('Laura', 'Sánchez', 'García', '45678901D', '600456789', 'runner', 2);


INSERT INTO pizza_type (type_name) VALUES
('Clásica'),
('Especialidad'),
('Vegetariana');

INSERT INTO product (product_type, product_description, image, price) VALUES
('pizza', 'Pizza Margarita', 'margarita.jpg', 8.50),
('pizza', 'Pizza Cuatro Quesos', 'cuatro_quesos.jpg', 9.50),
('pizza', 'Pizza Napolitana', 'napolitana.jpg', 10.50),
('burger', 'Hamburguesa Clásica', 'hamburguesa.jpg', 7.00),
('drinks', 'Coca-Cola 33cl', 'coca_cola.jpg', 1.80),
('drinks', 'Agua mineral 50cl', 'agua.jpg', 1.20);
                  

INSERT INTO pizza (id, pizza_type_id) VALUES
(1, 1),  
(2, 2), 
(3, 3);  

INSERT INTO customer (customer_name, surname1, surname2, full_address, zip_code, city, province, phone) VALUES
('Juan', 'Martínez', 'Pérez', 'Calle Sol 10', '28010', 'Madrid', 'Madrid', '611111111'),
('María', 'López', 'Gómez', 'Av. del Mar 5', '08010', 'Barcelona', 'Barcelona', '622222222');


INSERT INTO customer_order (customer_id, order_type, pizzeria_id, server_id, time_stamp, order_price) VALUES
(1, 'delivery', 1, 2, '2025-05-27 13:45:00', 20.00),
(2, 'take_away', 2, 2, '2025-05-27 19:15:00', 11.00);

INSERT INTO order_product (order_id, product_id, amount) VALUES
(1, 1, 1),  
(1, 5, 1),
(2, 2, 1);  

INSERT INTO delivery (id, runner_id, time_stamp) VALUES
(1, 2, '2025-05-28 12:30:00');  -- Delivered by Alice






