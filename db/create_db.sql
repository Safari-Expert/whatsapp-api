-- Use the newly created database
CREATE DATABASE IF NOT EXISTS template_db;

-- Use the newly created database
USE template_db;

-- Drop tables in the correct order to avoid foreign key constraint issues
DROP TABLE IF EXISTS lead_master;
DROP TABLE IF EXISTS contact_ref;
DROP TABLE IF EXISTS stage_ref;
DROP TABLE IF EXISTS agoda_data;
DROP TABLE IF EXISTS user_ref;

-- Create agoda_data table
CREATE TABLE IF NOT EXISTS agoda_data (
    proposal_detail_id INT PRIMARY KEY,
    proposal_id VARCHAR(255) NOT NULL,
    day_count INT NOT NULL,
    agoda_hotel_location_id VARCHAR(255),
    agoda_location_name VARCHAR(255),
    start_dt DATETIME NOT NULL,
    end_dt DATETIME NOT NULL,
    number_of_rooms INT NOT NULL,
    number_of_adults INT NOT NULL,
    number_of_children INT NOT NULL,
    child_ages_pipe_delimited VARCHAR(50),
    agoda_hotel_id INT,
    agoda_hotel_name VARCHAR(255),
    agoda_hotel_stars FLOAT,
    agoda_hotel_rating FLOAT,
    agoda_hotel_ratings_count INT,
    agoda_hotel_pics_pipe_delimited TEXT,
    agoda_room_pics_pipe_delimited TEXT,
    sleeps_count INT NOT NULL,
    room_price_per_night DECIMAL(10,2),
    risk_free_booking_binary TINYINT,
    cancelation_deadline_dt DATETIME,
    includes_breakfast_binary TINYINT,
    includes_lunch_binary TINYINT,
    includes_dinner_binary TINYINT,
    bed_type VARCHAR(255),
    size_sqm VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    active_flg INT DEFAULT 1,
    INDEX idx_deleted_at (deleted_at)
);

-- Create user_ref table
CREATE TABLE IF NOT EXISTS user_ref (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    second_name VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_role VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    active_flg INT DEFAULT 1
);

-- Create contact_ref table
CREATE TABLE IF NOT EXISTS contact_ref (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NULL,
    co_phone_cd VARCHAR(10),
    mobile VARCHAR(20),
    whatsapp_active TINYINT DEFAULT 0 NULL,
    email VARCHAR(255) NULL,
    agree_contact INT DEFAULT 1 NULL,
    agree_promo INT DEFAULT 1 NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP NULL,
    active_flg INT DEFAULT 1
);

-- Create stage_ref table
CREATE TABLE IF NOT EXISTS stage_ref (
    stage_id INT AUTO_INCREMENT PRIMARY KEY,
    stage_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP NULL,
    active_flg INT DEFAULT 1
);

-- Create lead_master table
CREATE TABLE IF NOT EXISTS lead_master (
    lead_id INT AUTO_INCREMENT PRIMARY KEY,
    contact_id INT NOT NULL,
    stage_id INT NOT NULL DEFAULT 1,
    FOREIGN KEY (contact_id) REFERENCES contact_ref(contact_id),
    FOREIGN KEY (stage_id) REFERENCES stage_ref(stage_id)
);

-- Insert users Alex, Micha, Dev1, Dev2, Agent1, and Booking1
INSERT INTO user_ref (first_name, second_name, username, password, user_role, active_flg)
VALUES 
('Alex', 'Admin', 'alex', 'useralex', 'admin', 1),
('Micha', 'Admin', 'Micha', 'usermicha', 'admin', 1),
('Dev1', 'Dev1', 'dev1', 'userdev1', 'admin', 1),
('Dev2', 'Dev2', 'dev2', 'userdev2', 'admin', 1),
('Agent1', 'Agent1', 'agent1', 'useragent1', 'agent', 1),
('booking1', 'Booking1', 'booking1', 'userbooking1', 'booking', 1);

-- Insert dummy data into contact_ref table
INSERT INTO contact_ref (name, surname, co_phone_cd, mobile, whatsapp_active, email, agree_contact, agree_promo, active_flg) VALUES
('John', 'Doe', '001', '1234567890', 1, 'john.doe@example.com', 1, 1, 1),
('Jane', 'Smith', '002', '0987654321', 0, 'jane.smith@example.com', 1, 1, 1),
('Alice', 'Johnson', '001', '1112223333', 1, 'alice.johnson@example.com', 1, 1, 1),
('Bob', 'Brown', '003', '4445556666', 0, 'bob.brown@example.com', 1, 1, 1),
('Charlie', 'Davis', '004', '7778889999', 1, 'charlie.davis@example.com', 1, 1, 1);

-- Insert dummy data into stage_ref table
INSERT INTO stage_ref (stage_name, active_flg) VALUES
('New', 1),
('Contacted', 1),
('Qualified', 1),
('Proposed', 1),
('Closed', 1);

-- Insert dummy data into lead_master table
INSERT INTO lead_master (contact_id, stage_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
