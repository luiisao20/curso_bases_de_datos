DROP DATABASE IF EXISTS ejercicio7;

CREATE DATABASE ejercicio7;

USE ejercicio7;

CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE app_accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    current_balance DECIMAL (9, 2) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE enterprises (
    app_account_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (app_account_id) REFERENCES app_accounts (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE transfers(
    from_account_id INT UNSIGNED NOT NULL,
    to_account_id INT UNSIGNED NOT NULL,
    status ENUM("processing", "done", "cancelled") NOT NULL,
    ammount_of_money DECIMAL(8, 2) NOT NULL,
    date DATETIME NOT NULL,

    FOREIGN KEY (from_account_id) REFERENCES app_accounts (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (to_account_id) REFERENCES app_accounts (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE bank_account_associations (
    app_account_id INT UNSIGNED NOT NULL,
    bank_account_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (app_account_id, bank_account_id),

    FOREIGN KEY (app_account_id) REFERENCES app_accounts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE transfers_app_to_bank (
    app_account_id INT UNSIGNED NOT NULL,
    bank_account_id INT UNSIGNED NOT NULL,
    status ENUM("processing", "done", "cancelled") NOT NULL,
    direction ENUM("app_to_bank", "bank_to_app") NOT NULL,
    ammount_of_money DECIMAL(8, 2) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,

    FOREIGN KEY (app_account_id) REFERENCES app_accounts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
