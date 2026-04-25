CREATE DATABASE Book_Worm;
USE Book_Worm;

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_year INT,
    nationality VARCHAR(50)
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(200) NOT NULL,
    category VARCHAR(100),
    author_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (price >= 0),
    publish_year INT,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
