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

INSERT INTO youtube_user (user_name, email, password, birthday_date, sex, country, zip_code) VALUES
('alice', 'alice@example.com', 'hashed_pw_1', '1990-04-23', 'Female', 'USA', '90210'),
('bob', 'bob@example.com', 'hashed_pw_2', '1988-11-05', 'Male', 'Canada', 'M5V3L9'),
('charlie', 'charlie@example.com', 'hashed_pw_3', '1995-07-14', 'Male', 'UK', 'SW1A1AA');

INSERT INTO video (user_id, publishing_date, title, description, file_name, size, duration, thumbnail, reproductions, likes, dislikes, video_state)
VALUES
(1, '2025-05-01 12:00:00', 'My First Video', 'Welcome to my channel!', 'video1.mp4', 25.5, 3.2, 'thumbnail1', 100, 10, 2, 'Public'),
(2, '2025-05-02 14:30:00', 'Funny Cat Compilation', 'LOL cats all day.', 'video2.mp4', 48.2, 5.7, 'thumbnail2', 540, 85, 1, 'Public'),
(1, '2025-05-03 16:45:00', 'Workout Routine', 'Daily home workout.', 'video3.mp4', 30.0, 7.1, 'thumbnail3', 200, 50, 5, 'Private');

INSERT INTO tag (tag_name, creation_date) VALUES
('Fitness', '2025-05-01'),
('Cats', '2025-05-02'),
('Funny', '2025-05-02'),
('Tutorial', '2025-05-01');

INSERT INTO video_tag (video_id, tag_id) VALUES
(1, 4),
(2, 2),
(2, 3),
(3, 1);

INSERT INTO channel (channel_name, description, creation_date, user_id) VALUES
('AliceFitness', 'Fitness and wellness tips', '2025-04-30', 1),
('BobLaughs', 'Funny videos every week!', '2025-04-30', 2);

INSERT INTO channel_subscriptions (channel_id, user_id) VALUES
(1, 2),
(2, 1),
(2, 3);

INSERT INTO video_reaction (video_id, user_id, reaction, reaction_date) VALUES
(1, 2, 'Like', '2025-05-01 13:00:00'),
(2, 1, 'Like', '2025-05-02 15:00:00'),
(2, 3, 'Dislike', '2025-05-02 15:05:00');

INSERT INTO playlist (playlist_name, creation_date, user_id, playlist_state) VALUES
('My Favorites', '2025-05-03', 1, 'Private'),
('Laugh Out Loud', '2025-05-03', 2, 'Public');

INSERT INTO playlist_video (playlist_id, video_id) VALUES
(1, 1),
(1, 3),
(2, 2);

INSERT INTO video_comment (video_id, user_id, comment_text, creation_date) VALUES
(1, 2, 'Nice intro!', '2025-05-01 13:05:00'),
(2, 3, 'This cracked me up!', '2025-05-02 16:00:00'),
(2, 1, 'Hahaha, loved it!', '2025-05-02 16:05:00');

INSERT INTO comment_reaction (comment_id, user_id, reaction, reaction_date) VALUES
(1, 1, 'Like', '2025-05-01 13:10:00'),
(2, 2, 'Like', '2025-05-02 16:10:00'),
(3, 3, 'Dislike', '2025-05-02 16:15:00');
