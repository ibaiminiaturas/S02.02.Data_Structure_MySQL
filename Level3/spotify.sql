DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE spotify_user (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(60) NOT NULL UNIQUE,
    user_type ENUM ("Free", "Premium") DEFAULT "Free",
	email VARCHAR(60) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
    birthday_date DATE NOT NULL,
    sex ENUM ("Male", "Female") NOT NULL,
    country VARCHAR(60) NOT NULL,
    zip_code VARCHAR(20) NOT NULL	
);

CREATE TABLE subscription(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED,
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


CREATE TABLE artist(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    image MEDIUMBLOB
);

CREATE TABLE artist_following(
	artist_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (artist_id, user_id),
	CONSTRAINT fk_artist_following_artist_id FOREIGN KEY (artist_id) REFERENCES artist(id),
    CONSTRAINT fk_artist_following_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id)
);	

CREATE TABLE artists_relation(
	artist_id INT UNSIGNED NOT NULL,
    related_artist_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (artist_id, related_artist_id),
	CONSTRAINT fk_artist_connection_artist_id FOREIGN KEY (artist_id) REFERENCES artist(id),
    CONSTRAINT fk_artist_connection_related_artist_id FOREIGN KEY (related_artist_id) REFERENCES artist(id)
);

CREATE TABLE album(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    publishing_year YEAR NOT NULL,
    album_cover MEDIUMBLOB,
    artist_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_album_artist_id FOREIGN KEY (artist_id) REFERENCES artist(id)
);

CREATE TABLE song(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration_seconds  INT UNSIGNED NOT NULL,
    reproduction_count  BIGINT UNSIGNED NOT NULL,
    album_id INT UNSIGNED NOT NULL,
	CONSTRAINT fk_song_album_id FOREIGN KEY (album_id) REFERENCES album(id)
);

-- Here I am supossing that you can not add a song to a playlist more than once, no? it would be a bit stupid I think.
CREATE TABLE playlist_song(
	playlist_id INT UNSIGNED NOT NULL,
    song_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    adding_date DATETIME NOT NULL,
    PRIMARY KEY (playlist_id, song_id),
    CONSTRAINT fk_splaylist_songs_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id),
    CONSTRAINT fk_playlist_songs_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(id),
    CONSTRAINT fk_playlist_songs_SONG_id FOREIGN KEY (song_id) REFERENCES song(id)
);

CREATE TABLE user_fav_album(
    user_id INT UNSIGNED NOT NULL,
    album_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, album_id),
    CONSTRAINT fk_user_fav_album_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id),
    CONSTRAINT fk_user_fav_album_album_id FOREIGN KEY (album_id) REFERENCES album(id)
);


CREATE TABLE user_fav_song(
    user_id INT UNSIGNED NOT NULL,
    song_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, song_id),
    CONSTRAINT fk_user_fav_song_user_id FOREIGN KEY (user_id) REFERENCES spotify_user(id),
    CONSTRAINT fk_user_fav_song_song_id FOREIGN KEY (song_id) REFERENCES song(id)
);


INSERT INTO spotify_user (user_name, user_type, email, password, birthday_date, sex, country, zip_code) VALUES
('alice123', 'Premium', 'alice@example.com', 'hashed_password1', '1990-04-15', 'Female', 'USA', '10001'),
('bob456', 'Free', 'bob@example.com', 'hashed_password2', '1985-11-22', 'Male', 'UK', 'SW1A1AA'),
('carol789', 'Premium', 'carol@example.com', 'hashed_password3', '1992-07-08', 'Female', 'Canada', 'M5V3L9'),
('dave321', 'Free', 'dave@example.com', 'hashed_password4', '1988-03-30', 'Male', 'Australia', '2000'),
('eve654', 'Premium', 'eve@example.com', 'hashed_password5', '1995-12-12', 'Female', 'Germany', '10115'),
('frank987', 'Free', 'frank@example.com', 'hashed_password6', '1983-09-20', 'Male', 'France', '75001');

INSERT INTO subscription (user_id, begin_date, end_date, payment_method) VALUES
(1, '2025-01-01 00:00:00', '2025-02-01 00:00:00', 'Credit Card'),
(3, '2025-03-15 00:00:00', '2025-04-15 00:00:00', 'Paypal'),
(5, '2025-04-01 00:00:00', '2025-05-01 00:00:00', 'Credit Card'),
(6, '2025-02-10 00:00:00', '2025-03-10 00:00:00', 'Paypal');

INSERT INTO credit_card (number, user_id, expiration_month, expiration_year, cvs) VALUES
('1234567890123456', 1, '12', '2026', '123'),
('9876543210987654', 5, '06', '2027', '456');

INSERT INTO paypal_user (paypal_user_id, spotify_user_id) VALUES
('paypal_user_001', 3),
('paypal_user_002', 6);

INSERT INTO playlist (playlist_name, creation_date, songs_number, user_id, is_deleted, is_shared) VALUES
('Top Hits', '2025-05-01 10:00:00', 0, 1, 0, 1),
('Workout', '2025-05-02 08:30:00', 0, 2, 0, 0),
('Chill Vibes', '2025-05-03 12:00:00', 0, 3, 0, 1),
('Oldies', '2025-05-04 15:00:00', 0, 5, 0, 0);

INSERT INTO artist (name, image) VALUES
('The Beatles', NULL),
('Coldplay', NULL),
('Beyonce', NULL),
('Adele', NULL),
('Drake', NULL),
('Taylor Swift', NULL);

INSERT INTO artists_relation (artist_id, related_artist_id) VALUES
(1, 2),
(2, 3),
(4, 5),
(5, 6);

INSERT INTO album (title, publishing_year, album_cover, artist_id) VALUES
('Abbey Road', 1969, NULL, 1),
('Parachutes', 2000, NULL, 2),
('Lemonade', 2016, NULL, 3),
('25', 2015, NULL, 4),
('Scorpion', 2018, NULL, 5),
('1989', 2014, NULL, 6);

INSERT INTO song (title, duration_seconds, reproduction_count, album_id) VALUES
('Come Together', 259, 1000000, 1),
('Yellow', 269, 800000, 2),
('Formation', 213, 950000, 3),
('Hello', 295, 1200000, 4),
('God\'s Plan', 198, 1100000, 5),
('Blank Space', 231, 1050000, 6);

INSERT INTO playlist_song (playlist_id, song_id, user_id, adding_date) VALUES
(1, 1, 1, '2025-05-01 10:05:00'),
(1, 2, 1, '2025-05-01 10:10:00'),
(2, 3, 2, '2025-05-02 08:35:00'),
(3, 4, 3, '2025-05-03 12:05:00'),
(3, 5, 3, '2025-05-03 12:10:00'),
(4, 6, 5, '2025-05-04 15:05:00');


INSERT INTO user_fav_album (user_id, album_id) VALUES
(1, 1),
(3, 3),
(5, 5),
(6, 6);


INSERT INTO user_fav_song (user_id, song_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(5, 5);
