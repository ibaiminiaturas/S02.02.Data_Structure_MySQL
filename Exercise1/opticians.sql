DROP DATABASE IF EXISTS opticians;
CREATE DATABASE opticians CHARACTER SET utf8mb4;
USE opticians;

CREATE TABLE supplier (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL UNIQUE,
  nif VARCHAR(20) NOT NULL,
  street VARCHAR(60) NOT NULL,
  number VARCHAR(10) NOT NULL,
  floor VARCHAR(10) NOT NULL,
  door VARCHAR(10) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  fax VARCHAR(20) NOT NULL
);


CREATE TABLE brand (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    supplier INT UNSIGNED NOT NULL,
    CONSTRAINT fk_suppier FOREIGN KEY (supplier) REFERENCES supplier(id)
);

CREATE TABLE glasses (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand INT UNSIGNED NOT NULL,
    left_prescription DECIMAL(4,2),
    right_prescription DECIMAL(4,2),
    glass_frame ENUM('rimless', 'plastic', 'metal') NOT NULL,
    frame_color VARCHAR(20) NOT NULL,
    left_color VARCHAR(20),
    right_color VARCHAR(20),
    price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_brand FOREIGN KEY (brand) REFERENCES brand(id)
);

CREATE TABLE customer (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	customer_name VARCHAR(100) NOT NULL,
    full_address VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    referrer_id INT UNSIGNED,
    CONSTRAINT check_email CHECK (email LIKE '%@%'),
	CONSTRAINT fk_customer_customer_id FOREIGN KEY (referrer_id) REFERENCES customer(id),
    sign_in_date DATE NOT NULL
);

CREATE TABLE employee (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	employee_name VARCHAR(100) NOT NULL
    );

CREATE TABLE purchase (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    glasses_id INT UNSIGNED NOT NULL,
    quarter ENUM('Q1', 'Q2', 'Q3', 'Q4'),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer(id),
    CONSTRAINT fk_purchase_employee_id FOREIGN KEY (employee_id) REFERENCES employee(id),
    CONSTRAINT fk_glasses_id FOREIGN KEY (glasses_id) REFERENCES glasses(id)
);




INSERT INTO supplier (supplier_name, nif, street, number, floor, door, zip_code, phone, fax) VALUES
('OptiSupply Ltd.', 'A12345678', 'Main St.', '45', '3', 'B', '28001', '+34 912345678', '+34 912345679'),
('VisionPro', 'B23456789', '2nd Avenue', '12', '1', 'A', '28002', '+34 913456789', '+34 913456780'),
('ClearView Suppliers', 'C34567890', 'Broadway', '100', '5', 'C', '28003', '+34 914567890', '+34 914567891'),
('SunGlasses Co.', 'D45678901', 'Elm Street', '7', '2', 'D', '28004', '+34 915678901', '+34 915678902'),
('LensMasters', 'E56789012', 'Oak Road', '23', '4', 'E', '28005', '+34 916789012', '+34 916789013'),
('FocusOptics', 'F67890123', 'Pine Lane', '56', '6', 'F', '28006', '+34 917890123', '+34 917890124'),
('EyeTrend', 'G78901234', 'Maple Blvd', '9', '1', 'G', '28007', '+34 918901234', '+34 918901235'),
('SharpVision', 'H89012345', 'Cedar Ave', '33', '2', 'H', '28008', '+34 919012345', '+34 919012346'),
('CrystalClear', 'I90123456', 'Birch Street', '15', '3', 'I', '28009', '+34 910123456', '+34 910123457'),
('OpticWorld', 'J01234567', 'Willow Road', '77', '5', 'J', '28010', '+34 911234567', '+34 911234568'),
('BrightEyes', 'K12345670', 'Ash Blvd', '88', '2', 'K', '28011', '+34 912345670', '+34 912345671'),
('EyePlus', 'L23456781', 'Chestnut Street', '42', '4', 'L', '28012', '+34 913456781', '+34 913456782'),
('VisionWorks', 'M34567892', 'Poplar Ave', '30', '1', 'M', '28013', '+34 914567892', '+34 914567893'),
('OpticPoint', 'N45678903', 'Spruce Road', '16', '3', 'N', '28014', '+34 915678903', '+34 915678904'),
('SeeClear', 'O56789014', 'Fir Street', '55', '5', 'O', '28015', '+34 916789014', '+34 916789015');


INSERT INTO brand (brand_name, supplier) VALUES
('SunGuard', 4),
('ClearView', 3),
('OptiLux', 1),
('VisionMax', 2),
('EyeStyle', 5),
('FocusPro', 6),
('SharpLook', 7),
('CrystalEye', 9),
('BrightLens', 11),
('EyeMaster', 8),
('LensStar', 10),
('OptiTrend', 12),
('SeeWell', 13),
('PureVision', 14),
('SightLine', 15);


INSERT INTO glasses (brand, left_prescription, right_prescription, glass_frame, frame_color, left_color, right_color, price) VALUES
(4, -2.00, -1.75, 'rimless', 'black', 'clear', 'clear', 150.00),
(3, -1.50, -1.50, 'plastic', 'tortoise', 'brown', 'brown', 120.50),
(1, -0.75, -0.75, 'metal', 'silver', 'green', 'green', 200.00),
(2, -3.00, -2.75, 'rimless', 'gunmetal', 'clear', 'clear', 180.00),
(5, -1.25, -1.00, 'plastic', 'red', 'blue', 'blue', 140.00),
(6, -2.50, -2.50, 'metal', 'gold', 'grey', 'grey', 220.00),
(7, -1.00, -1.00, 'rimless', 'black', 'clear', 'clear', 160.00),
(9, -0.50, -0.50, 'plastic', 'brown', 'brown', 'brown', 130.00),
(11, -2.25, -2.00, 'metal', 'bronze', 'green', 'green', 210.00),
(8, -1.75, -1.50, 'plastic', 'blue', 'blue', 'blue', 135.00),
(10, -3.25, -3.00, 'rimless', 'grey', 'clear', 'clear', 175.00),
(12, -0.25, -0.25, 'metal', 'black', 'clear', 'clear', 190.00),
(13, -1.80, -1.80, 'plastic', 'purple', 'brown', 'brown', 145.00),
(14, -2.10, -2.00, 'metal', 'silver', 'grey', 'grey', 215.00),
(15, -1.00, -1.25, 'rimless', 'black', 'clear', 'clear', 170.00);


INSERT INTO customer (customer_name, full_address, phone, email, referrer_id, sign_in_date) VALUES
('Ana García', 'Calle Mayor 12, 1ºA, Madrid, 28001', '+34 912345678', 'ana.garcia@email.com', NULL, '2025-05-01'),
('Luis Pérez', 'Avenida de la Paz 45, 2ºB, Barcelona, 08002', '+34 933456789', 'luis.perez@email.com', 1, '2025-05-02'),
('María López', 'Calle del Sol 78, 3ºC, Valencia, 46003', '+34 961234567', 'maria.lopez@email.com', 2, '2025-05-03'),
('Carlos Fernández', 'Plaza Mayor 34, 4ºD, Sevilla, 41004', '+34 954345678', 'carlos.fernandez@email.com', 3, '2025-05-04'),
('Laura Martínez', 'Calle del Mar 56, 5ºE, Málaga, 29005', '+34 952456789', 'laura.martinez@email.com', 4, '2025-05-05'),
('José Rodríguez', 'Avenida Libertad 89, 6ºF, Zaragoza, 50006', '+34 976567890', 'jose.rodriguez@email.com', 5, '2025-05-06'),
('Patricia Sánchez', 'Calle de la Luna 12, 7ºG, Bilbao, 48007', '+34 944678901', 'patricia.sanchez@email.com', 6, '2025-05-07'),
('Fernando Díaz', 'Calle Real 34, 8ºH, Alicante, 03008', '+34 965789012', 'fernando.diaz@email.com', 7, '2025-05-08'),
('Isabel Gómez', 'Avenida Europa 56, 9ºI, Murcia, 30009', '+34 968890123', 'isabel.gomez@email.com', 8, '2025-05-09'),
('Antonio Ruiz', 'Calle del Río 78, 10ºJ, Valladolid, 47010', '+34 983901234', 'antonio.ruiz@email.com', 9, '2025-05-10'),
('Elena Jiménez', 'Plaza de España 12, 11ºK, Oviedo, 33011', '+34 985012345', 'elena.jimenez@email.com', 10, '2025-05-11'),
('Pedro Sánchez', 'Calle de la Estrella 34, 12ºL, Salamanca, 37012', '+34 923123456', 'pedro.sanchez@email.com', 11, '2025-05-12'),
('Carmen Pérez', 'Avenida de Castilla 56, 13ºM, León, 24013', '+34 987234567', 'carmen.perez@email.com', 12, '2025-05-13'),
('Javier Martín', 'Calle de la Paz 78, 14ºN, Lugo, 27014', '+34 982345678', 'javier.martin@email.com', 13, '2025-05-14'),
('Marta Hernández', 'Plaza del Sol 89, 15ºO, Girona, 17015', '+34 972456789', 'marta.hernandez@email.com', 14, '2025-05-15');

INSERT INTO employee (employee_name) VALUES
('Pedro Martínez'),
('Laura Sánchez'),
('Carlos López'),
('Ana Fernández'),
('José García'),
('María Rodríguez'),
('Luis Pérez'),
('Patricia Gómez'),
('Antonio Díaz'),
('Elena Ruiz'),
('Fernando Jiménez'),
('Isabel Sánchez'),
('Javier Hernández'),
('Carmen Martín'),
('Marta Pérez');

INSERT INTO purchase (customer_id, employee_id, glasses_id, quarter) VALUES
(1, 1, 1, 'Q1'),
(2, 2, 2, 'Q1'),
(3, 3, 3, 'Q1'),
(4, 4, 4, 'Q1'),
(5, 5, 5, 'Q1'),
(6, 6, 6, 'Q1'),
(7, 7, 7, 'Q1'),
(8, 8, 8, 'Q1'),
(9, 9, 9, 'Q1'),
(10, 10, 10, 'Q1'),
(11, 11, 11, 'Q1'),
(12, 12, 12, 'Q1'),
(13, 13, 13, 'Q1'),
(14, 14, 14, 'Q1'),
(15, 15, 15, 'Q1');




