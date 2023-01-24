DROP DATABASE IF EXISTS ejercicio5;

CREATE DATABASE ejercicio5;

USE ejercicio5;

CREATE TABLE buildings (
    city VARCHAR(255) NOT NULL,
    number INT UNSIGNED NOT NULL,

    PRIMARY KEY(city, number)
);

CREATE TABLE departments(
    number VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    annual_budget DECIMAL(8, 2) NOT NULL,
    building_city VARCHAR(255) NOT NULL,
    building_number INT UNSIGNED NOT NULL,

    FOREIGN KEY (building_city, building_number) REFERENCES buildings(city, number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE employees (
    number INT UNSIGNED NOT NULL,
    department_number VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    manager_number INT UNSIGNED NOT NULL,
    manager_department_number VARCHAR(255) NOT NULL,

    PRIMARY KEY (number, department_number),

    FOREIGN KEY (department_number) REFERENCES departments(number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    FOREIGN KEY (manager_number, manager_department_number) REFERENCES employees(number, department_number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
