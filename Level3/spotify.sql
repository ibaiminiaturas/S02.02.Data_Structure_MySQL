DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE spotify_user (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(60) NOT NULL UNIQUE,
    user_type ENUM ("Free", "Premium") DEFAULT "Free",
	email VARCHAR(60) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
    birthday_date DATETIME NOT NULL,
    sex ENUM ("Male", "Female") NOT NULL,
    country VARCHAR(60) NOT NULL,
    zip_code VARCHAR(20) NOT NULL	
);

CREATE TABLE subscription(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED PRIMARY KEY,
    begin_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL, -- This is the subscription renewal date, because is the same as the end date and I like it more this way
    payment_method ENUM ("Credit Card", "Paypal") DEFAULT "Credit Card",
    CONSTRAINT fk_subscription_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);

CREATE TABLE credit_card(
	number VARCHAR(19) NOT NULL UNIQUE,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (number, user_id),
    expiration_month VARCHAR(2) NOT NULL,
    expiration_year VARCHAR(4) NOT NULL,
    cvs VARCHAR(3) NOT NULL,
    CONSTRAINT fk_credic_card_user FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);

