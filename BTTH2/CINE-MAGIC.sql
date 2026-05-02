CREATE TABLE movies (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_movies_age_restriction
        CHECK (age_restriction IN (0, 13, 16, 18))
);

CREATE TABLE rooms (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    CONSTRAINT chk_rooms_status
        CHECK (status IN ('active', 'maintenance'))
);

CREATE TABLE showtimes (
    id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_showtimes_ticket_price
        CHECK (ticket_price >= 0),
    CONSTRAINT fk_showtimes_movies
        FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT fk_showtimes_rooms
        FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE bookings (
    id INT PRIMARY KEY,
    showtime_id INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    booking_date DATETIME NOT NULL,
    CONSTRAINT fk_bookings_showtimes
        FOREIGN KEY (showtime_id) REFERENCES showtimes(id)
);

INSERT INTO movies (id, title, duration_minutes, age_restriction) VALUES
    (1, 'Avengers: Endgame', 181, 13),
    (2, 'Dune: Part Two', 166, 13),
    (3, 'Inside Out 2', 96, 0),
    (4, 'Deadpool & Wolverine', 127, 18);

INSERT INTO rooms (id, name, max_seats, status) VALUES
    (1, 'Phong Chieu 1', 120, 'active'),
    (2, 'Phong Chieu 2', 90, 'active'),
    (3, 'Phong Chieu 3', 100, 'maintenance');

INSERT INTO showtimes (id, movie_id, room_id, show_time, ticket_price) VALUES
    (1, 1, 1, '2026-05-01 09:00:00', 95000.00),
    (2, 2, 2, '2026-05-01 10:30:00', 105000.00),
    (3, 3, 1, '2026-05-01 13:15:00', 85000.00),
    (4, 4, 2, '2026-05-01 18:45:00', 120000.00),
    (5, 2, 1, '2026-05-02 20:00:00', 110000.00);

INSERT INTO bookings (id, showtime_id, customer_name, phone, booking_date) VALUES
    (1, 1, 'Nguyen Minh Anh', '0901000001', '2026-04-30 08:10:00'),
    (2, 2, 'Tran Quoc Bao', '0901000002', '2026-04-30 08:20:00'),
    (3, 3, 'Le Hoang Chau', '0901000003', '2026-04-30 08:45:00'),
    (4, 4, 'Pham Gia Dat', '0901000004', '2026-04-30 09:00:00'),
    (5, 5, 'Vo Thu Ha', '0901000005', '2026-04-30 09:15:00'),
    (6, 1, 'Bui Khanh Linh', '0901000006', '2026-04-30 09:30:00'),
    (7, 2, 'Do Tuan Kiet', '0901000007', '2026-04-30 10:05:00'),
    (8, 3, 'Nguyen Bao Ngoc', '0901000008', '2026-04-30 10:20:00'),
    (9, 4, 'Tran Thanh Nam', '0901000009', '2026-04-30 10:40:00'),
    (10, 5, 'Le My Duyen', '0901000010', '2026-04-30 11:00:00');

START TRANSACTION;

-- Phòng 1 điều hòa hỏng -> đang bảo trì
UPDATE rooms SET status = 'maintenance' WHERE id = 1;

-- Chuyển mọi lịch chiếu từ phòng 1 sang phòng 2
UPDATE showtimes SET room_id = 2 WHERE room_id = 1;

-- Hủy toàn bộ vé của khách có SĐT 0987654321
DELETE FROM bookings WHERE phone = '0987654321';

-- Gỡ hoàn toàn phim id = 3: xóa vé thuộc suất của phim 3 -> xóa suất -> xóa phim
DELETE b FROM bookings b
INNER JOIN showtimes s ON b.showtime_id = s.id
WHERE s.movie_id = 3;

DELETE FROM showtimes WHERE movie_id = 3;

DELETE FROM movies WHERE id = 3;

COMMIT;
