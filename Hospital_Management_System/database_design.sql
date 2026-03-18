-- ==========================================================
-- PROJECT: Enterprise Hospital Management & Patient Analytics
-- FILE: database_design.sql
-- ==========================================================

-- 1. Departments Table
CREATE TABLE Departments (
    dept_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    building_floor INTEGER,
    head_doctor_id INTEGER
);

-- 2. Doctors Table (Linked to Departments)
CREATE TABLE Doctors (
    doctor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    experience_years INTEGER,
    dept_id INTEGER,
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- 3. Patients Table (With Insurance Info)
CREATE TABLE Patients (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age > 0),
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    insurance_provider VARCHAR(100),
    emergency_contact VARCHAR(15)
);

-- 4. Appointments Table (The Transactional Heart)
CREATE TABLE Appointments (
    app_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER,
    doctor_id INTEGER,
    app_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    reason_for_visit TEXT,
    status VARCHAR(20) DEFAULT 'Scheduled', -- 'Scheduled', 'Completed', 'Cancelled', 'No-Show'
    fee DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 5. Medical_Records (The "Big Data" Table)
CREATE TABLE Medical_Records (
    record_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER,
    doctor_id INTEGER,
    diagnosis TEXT,
    prescription TEXT,
    lab_results TEXT,
    record_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 6. INSERTING HEAVY MOCK DATA
INSERT INTO Departments (dept_name, building_floor) VALUES 
('Cardiology', 1), ('Neurology', 2), ('Pediatrics', 3), ('Orthopedics', 1), ('Emergency', 0);

INSERT INTO Doctors (name, specialization, experience_years, dept_id, salary) VALUES 
('Dr. Sharma', 'Cardiology', 15, 1, 120000),
('Dr. Priya', 'Neurology', 8, 2, 95000),
('Dr. Vikram', 'Pediatrics', 12, 3, 110000),
('Dr. Anjali', 'Orthopedics', 5, 4, 80000),
('Dr. Amit', 'Cardiology', 20, 1, 150000);

INSERT INTO Patients (name, age, gender, blood_type, insurance_provider) VALUES 
('Rahul Singh', 28, 'Male', 'O+', 'Aetna'),
('Sneha Kapoor', 45, 'Female', 'A-', 'BlueCross'),
('Amit Verma', 67, 'Male', 'B+', 'Medicare'),
('Pooja Das', 12, 'Female', 'O+', 'Cigna'),
('Karan Johar', 35, 'Male', 'AB+', 'None');

INSERT INTO Appointments (patient_id, doctor_id, app_date, status, fee) VALUES 
(1, 1, '2026-03-10 10:00:00', 'Completed', 500),
(2, 2, '2026-03-10 11:30:00', 'Completed', 800),
(3, 5, '2026-03-11 09:00:00', 'Completed', 1200),
(4, 3, '2026-03-11 14:00:00', 'Scheduled', 400),
(5, 4, '2026-03-12 16:00:00', 'Cancelled', 600),
(1, 5, '2026-03-15 10:00:00', 'Completed', 1500);