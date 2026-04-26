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

-- Them 3 tac gia
INSERT INTO authors (full_name, birth_year, nationality) VALUES
('Nguyen Nhat Anh', 1955, 'Viet Nam'),
('Agatha Christie', 1890, 'Anh'),
('Dale Carnegie', 1888, 'My');

-- Them 8 cuon sach thuoc nhieu the loai
INSERT INTO books (book_name, category, author_id, price, publish_year) VALUES
('Mat Biec', 'Van hoc', 1, 85000, 1990),
('Cho toi xin mot ve di tuoi tho', 'Van hoc', 1, 92000, 2008),
('Mua he khong ten', 'Van hoc', 1, 78000, 2012),
('An mang tren chuyen tau toc hanh Phuong Dong', 'Trinh tham', 2, 115000, 1934),
('Mau xanh bi an', 'Trinh tham', 2, 109000, 1928),
('Ai la ke sat nhan?', 'Trinh tham', 2, 99000, 1940),
('Dac nhan tam', 'Ky nang', 3, 120000, 1936),
('Quang ganh lo di va vui song', 'Ky nang', 3, 98000, 1948);

-- Them 5 khach hang hop le
INSERT INTO customers (full_name, email, phone) VALUES
('Tran Minh Quan', 'quan.tm@gmail.com', '0901000001'),
('Le Thu Ha', 'ha.lt@gmail.com', '0901000002'),
('Pham Gia Bao', 'bao.pg@gmail.com', '0901000003'),
('Vo Khanh Linh', 'linh.vk@gmail.com', '0901000004'),
('Doan Anh Thu', 'thu.da@gmail.com', '0901000005');

-- =========================
-- KIEM TRA RANG BUOC UNIQUE
-- =========================
-- Lenh ben duoi co email trung voi khach hang "Le Thu Ha".
-- He thong se BAO LOI va KHONG cho chen ban ghi moi
-- vi cot customers.email da duoc dat UNIQUE.
INSERT INTO customers (full_name, email, phone) VALUES
('Nguyen Van A', 'ha.lt@gmail.com', '0901000099');
