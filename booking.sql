-- Create database
CREATE DATABASE train_booking_system;
USE train_booking_system;

-- Create tables
CREATE TABLE STATION (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
);

CREATE TABLE TRAIN (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    train_type VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE ROUTE (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (origin_station_id) REFERENCES STATION(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES STATION(station_id)
);

CREATE TABLE SCHEDULE (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    train_id INT NOT NULL,
    travel_date DATE NOT NULL,
    is_cancelled BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (route_id) REFERENCES ROUTE(route_id),
    FOREIGN KEY (train_id) REFERENCES TRAIN(train_id)
);

CREATE TABLE PASSENGER (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL
);

CREATE TABLE BOOKING (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    schedule_id INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES PASSENGER(passenger_id),
    FOREIGN KEY (schedule_id) REFERENCES SCHEDULE(schedule_id)
);

CREATE TABLE SEAT (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_class VARCHAR(20) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
);

-- Insert sample data
INSERT INTO STATION (station_name, city, state, country, latitude, longitude) VALUES
('Central Station', 'New York', 'NY', 'USA', 40.752726, -73.977229),
('Union Station', 'Chicago', 'IL', 'USA', 41.878744, -87.640457),
('Penn Station', 'Philadelphia', 'PA', 'USA', 39.954244, -75.163276),
('South Station', 'Boston', 'MA', 'USA', 42.352271, -71.055242);

INSERT INTO TRAIN (train_name, train_type, total_seats, is_active) VALUES
('Eagle Express', 'High Speed', 300, true),
('Coastal Cruiser', 'Regular', 250, true),
('Mountain View', 'Scenic', 200, true),
('Night Owl', 'Sleeper', 150, true);

INSERT INTO ROUTE (origin_station_id, destination_station_id, departure_time, arrival_time, base_price) VALUES
(1, 2, '08:00:00', '12:00:00', 150.00),
(2, 3, '13:00:00', '16:00:00', 100.00),
(3, 4, '09:00:00', '11:30:00', 80.00),
(4, 1, '14:00:00', '18:00:00', 150.00);

INSERT INTO SCHEDULE (route_id, train_id, travel_date) VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-01-10'),
(3, 3, '2025-01-10'),
(4, 4, '2025-01-10');

INSERT INTO PASSENGER (first_name, last_name, email, phone, date_of_birth) VALUES
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '1985-05-15'),
('Jane', 'Smith', 'jane.smith@email.com', '234-567-8901', '1990-08-22'),
('Robert', 'Johnson', 'robert.j@email.com', '345-678-9012', '1978-12-03'),
('Maria', 'Garcia', 'maria.g@email.com', '456-789-0123', '1995-03-30');

INSERT INTO BOOKING (passenger_id, schedule_id, booking_status, total_amount) VALUES
(1, 1, 'CONFIRMED', 180.00),
(2, 2, 'CONFIRMED', 120.00),
(3, 3, 'CONFIRMED', 95.00),
(4, 4, 'CONFIRMED', 180.00);

INSERT INTO SEAT (booking_id, seat_number, seat_class, price) VALUES
(1, 'A1', 'FIRST', 180.00),
(2, 'B3', 'BUSINESS', 120.00),
(3, 'C5', 'ECONOMY', 95.00),
(4, 'A4', 'FIRST', 180.00);