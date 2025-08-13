--
-- File: clinic_booking_system.sql
--
-- This script creates a database schema for a simple Clinic Booking System.
-- It includes tables for patients, doctors, appointments, and specializations.
--

-- Create the database
CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

-- -----------------------------------------------------
-- Table: specializations
-- Description: A lookup table for different medical specializations.
-- -----------------------------------------------------
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(255) NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- Table: doctors
-- Description: Stores information about the doctors.
-- A foreign key links each doctor to their specialization.
-- -----------------------------------------------------
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    specialization_id INT NOT NULL,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE RESTRICT
);

-- -----------------------------------------------------
-- Table: patients
-- Description: Stores information about the patients.
-- -----------------------------------------------------
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE
);

-- -----------------------------------------------------
-- Table: appointments
-- Description: Stores details about each appointment.
-- This table links patients to doctors and includes appointment details.
-- -----------------------------------------------------
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    UNIQUE KEY unique_appointment (doctor_id, appointment_date, appointment_time)
);

-- Example data to demonstrate the relationships
-- Insert some specializations
INSERT INTO specializations (specialization_name) VALUES
('Cardiology'),
('Dermatology'),
('Pediatrics');

-- Insert some doctors
INSERT INTO doctors (first_name, last_name, phone_number, specialization_id) VALUES
('Dr. Alice', 'Smith', '555-1234', 1),
('Dr. Bob', 'Johnson', '555-5678', 2),
('Dr. Carol', 'Williams', '555-8765', 3);

-- Insert some patients
INSERT INTO patients (first_name, last_name, date_of_birth, phone_number, email) VALUES
('John', 'Doe', '1990-05-15', '555-0001', 'john.doe@email.com'),
('Jane', 'Smith', '1985-11-20', '555-0002', 'jane.smith@email.com');

-- Record some appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2025-08-14', '10:00:00', 'Scheduled'),
(2, 2, '2025-08-14', '11:30:00', 'Completed');