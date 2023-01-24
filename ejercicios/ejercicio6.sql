DROP DATABASE IF EXISTS ejercicio6;

CREATE DATABASE ejercicio6;

USE ejercicio6;

CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE profiles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    profile_picture VARCHAR(255) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE profile_following(
    follower_profile_id INT UNSIGNED NOT NULL,
    following_profile_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (follower_profile_id, following_profile_id),

    FOREIGN KEY (follower_profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (following_profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE posts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id INT UNSIGNED NOT NULL,
    description VARCHAR(255) NULL,
    date DATETIME NOT NULL,

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE post_images(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    post_id INT UNSIGNED NOT NULL,
    url VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE comments(
    profile_id INT UNSIGNED NOT NULL,
    post_id INT UNSIGNED NOT NULL,
    date DATETIME NOT NULL,
    content VARCHAR(512),

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);