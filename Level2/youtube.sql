DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

CREATE TABLE youtube_user (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(60) NOT NULL UNIQUE,
	email VARCHAR(60) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
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
    reproductions BIGINT UNSIGNED, 
    likes BIGINT UNSIGNED, 
    dislikes BIGINT UNSIGNED,
    video_state ENUM ("Public", "Hidden" , "Private") NOT NULL,
    CONSTRAINT fk_video_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id)
);
    
CREATE TABLE tag(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(100) NOT NULL UNIQUE,
	creation_date DATETIME NOT NULL
);  
    
CREATE TABLE video_tag(
	video_id  INT UNSIGNED NOT NULL,
	tag_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (video_id, tag_id),
	CONSTRAINT fk_video_tag_video FOREIGN KEY (video_id) REFERENCES video(id),
	CONSTRAINT fk_video_tag_tag FOREIGN KEY (tag_id) REFERENCES tag(id)
);
    
CREATE TABLE channel (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    channel_name VARCHAR(60) NOT NULL UNIQUE,
	description VARCHAR(1000) NOT NULL,
	creation_date DATETIME NOT NULL,
    user_id INT UNSIGNED NOT NULL,
	CONSTRAINT fk_channel_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id)
);

CREATE TABLE channel_subscriptions(
	channel_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (channel_id, user_id),
    CONSTRAINT fk_channel_subscription_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id),
    CONSTRAINT fk_channel_subscription_channel_id FOREIGN KEY (channel_id) REFERENCES channel(id)
);

CREATE TABLE video_reaction(
	video_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (video_id, user_id),
    reaction ENUM ("Like", "Dislike") NOT NULL,
    reaction_date DATETIME NOT NULL,
    CONSTRAINT fk_video_reaction_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id),
    CONSTRAINT fk_video_reaction_video_id FOREIGN KEY (video_id) REFERENCES video(id)
);

CREATE TABLE playlist (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    playlist_name VARCHAR(60) NOT NULL,
	creation_date DATETIME NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    playlist_state ENUM ("Public","Private") NOT NULL,
	CONSTRAINT fk_playlist_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id)
);

CREATE TABLE playlist_video(
	playlist_id INT UNSIGNED NOT NULL,
	video_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (playlist_id, video_id),
    CONSTRAINT fk_playlist_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(id),
    CONSTRAINT fk_playlist_video_id FOREIGN KEY (video_id) REFERENCES video(id)
);
    
CREATE TABLE video_comment(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    video_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
    comment_text VARCHAR(1000) NOT NULL,
	creation_date DATETIME NOT NULL,
    CONSTRAINT fk_video_comment_video_id FOREIGN KEY (video_id) REFERENCES video(id),
    CONSTRAINT fk_video_comment_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id)
);

CREATE TABLE comment_reaction (
    comment_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    reaction ENUM('Like', 'Dislike') NOT NULL,
    reaction_date DATETIME NOT NULL,
    PRIMARY KEY (comment_id, user_id),
    CONSTRAINT fk_comment_reaction_comment_id FOREIGN KEY (comment_id) REFERENCES video_comment(id),
    CONSTRAINT fk_comment_reaction_user_id FOREIGN KEY (user_id) REFERENCES youtube_user(id)
);