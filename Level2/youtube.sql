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

CREATE TABLE video (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    publishing_date DATETIME NOT NULL,
	title VARCHAR(100) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    file_name VARCHAR(100) NOT NULL,
    size DOUBLE NOT NULL CHECK (size > 0),
    duration DOUBLE NOT NULL CHECK (duration > 0),
	thumbnail MEDIUMBLOB NOT NULL,
    reproductions BIGINT UNSIGNED , 
    likes BIGINT UNSIGNED , 
    dislikes BIGINT UNSIGNED,
    video_state ENUM ("Public", "Hidden" , "Private") NOT NULL
    );
    
    
    CREATE TABLE channel (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    channel_name VARCHAR(60) NOT NULL,
	description VARCHAR(1000) NOT NULL,
	creation_date DATETIME NOT NULL
    );
    
    CREATE TABLE channel (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    playlist_name VARCHAR(60) NOT NULL,
	creation_date DATETIME NOT NULL,
    playlist_state ENUM ("Public","Private")
    );
    
	CREATE TABLE comment(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(1000) NOT NULL,
	creation_date DATETIME NOT NULL
    );
    
    CREATE TABLE video_tag(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(100) NOT NULL,
	creation_date DATETIME NOT NULL
    );
    