DROP DATABASE IF EXISTS ejercicio8;

CREATE DATABASE ejercicio8;

USE ejercicio8;

CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE adresses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    state VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL,
    postal_code VARCHAR(255) NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE stores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE products (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    stock INT UNSIGNED NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    discount TINYINT UNSIGNED NOT NULL,
    store_id INT UNSIGNED NOT NULL,

    FOREIGN KEY (store_id) REFERENCES stores(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CHECK (discount <= 100)
);

CREATE TABLE product_images(
    product_id INT UNSIGNED NOT NULL,
    url VARCHAR(255) NOT NULL,

    FOREIGN KEY (product_id) REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE product_colors(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    color VARCHAR(255) NOT NULL,

    FOREIGN KEY (product_id) REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE product_sizes(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    size VARCHAR(255) NOT NULL,

    FOREIGN KEY (product_id) REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE orders(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total_price DECIMAL(8, 2) NOT NULL,
    status ENUM("pending", "delivered", "cancelled") NOT NULL,
    order_number VARCHAR(255) NOT NULL UNIQUE,
    user_id INT UNSIGNED NOT NULL,
    adress_id INT UNSIGNED NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (adress_id) REFERENCES adresses(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE product_order(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    product_color_id INT UNSIGNED NOT NULL,
    order_id INT UNSIGNED NOT NULL,
    product_size_id INT UNSIGNED NOT NULL,
    discount TINYINT NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    price DECIMAL(8, 2),

    FOREIGN KEY (product_id) REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    FOREIGN KEY (product_color_id) REFERENCES product_colors(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    FOREIGN KEY (product_size_id) REFERENCES product_sizes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (order_id) REFERENCES orders(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
