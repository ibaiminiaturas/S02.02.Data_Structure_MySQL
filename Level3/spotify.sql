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
	id INT UNSIGNED AUTO_INCREMENT,
    user_id INT UNSIGNED,
    PRIMARY KEY(id, user_id),
    begin_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL, -- This is the subscription renewal date, because is the same as the end date and I like it more this way
    payment_method ENUM ("Credit Card", "Paypal") DEFAULT "Credit Card",
    CONSTRAINT fk_subscription_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);

CREATE TABLE credit_card(
	number VARCHAR(19) NOT NULL UNIQUE PRIMARY KEY, -- In this case if a credit card  changes is really a new creadit card so ...
    user_id INT UNSIGNED NOT NULL,
    expiration_month VARCHAR(2) NOT NULL,
    expiration_year VARCHAR(4) NOT NULL,
    cvs VARCHAR(3) NOT NULL,
    CONSTRAINT fk_credit_card_user FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);

CREATE TABLE paypal_user(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- The user can change the mail or user id for his/her paypal so let's keep the auto id as primary key
	paypal_user_id VARCHAR(100) NOT NULL UNIQUE,
    spotify_user_id  INT UNSIGNED NOT NULL,
    CONSTRAINT fk_paypal_user_user_id FOREIGN KEY (spotify_user_id) REFERENCES spotify_user(id)
);

CREATE TABLE subscription_payment(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	user_id INT UNSIGNED NOT NULL,
    subscription_id INT UNSIGNED NOT NULL,
	payment_date DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_subscription_payment_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id),
    CONSTRAINT fk_subscription_payment_subscription_id FOREIGN KEY (subscription_id) REFERENCES subscription(id)
    
);

CREATE TABLE playlist (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    playlist_name VARCHAR(60) NOT NULL,
	creation_date DATETIME NOT NULL,
    songs_number INT UNSIGNED, 
    user_id INT UNSIGNED NOT NULL,
    is_deleted TINYINT DEFAULT 0, -- not real booleans in mysql, weird...
    deletion_date DATETIME NULL,
    is_shared TINYINT DEFAULT 0, -- not real booleans in mysql, weird...
	CONSTRAINT fk_playlist_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);


-- Here I am supossing that you can not add a song to a playlist more than once, no? it would be a bit stupid I think.
CREATE TABLE playlist_songs(
	playlist_id INT UNSIGNED NOT NULL,
    song_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (playlist_id, song_id),
    adding_date DATETIME NOT NULL,
    CONSTRAINT fk_splaylist_songs_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id),
    CONSTRAINT fk_playlist_songs_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(id)
);


