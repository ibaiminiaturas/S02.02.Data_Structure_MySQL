DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

CREATE TABLE youtube_user (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(60) NOT NULL,
	email VARCHAR(60) NOT NULL,
	password VARCHAR(30) NOT NULL,
    birthday_date DATETIME NOT NULL,
    sex ENUM ("Male", "Female") NOT NULL,
    country VARCHAR(60) NOT NULL,
    zip_code VARCHAR(20) NOT NULL	
    );
