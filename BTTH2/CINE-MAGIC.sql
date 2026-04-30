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
