-- Create the Specializations table
CREATE TABLE Specializations (
    SpecializationID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Doctors table with a foreign key to Specializations
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    SpecializationID INT,
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID)
);

-- Create the Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    DateOfBirth DATE NOT NULL
);

-- Create the Appointments table with foreign keys to Patients and Doctors
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentDate DATETIME NOT NULL,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create the Prescriptions table with a foreign key to Appointments
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT NOT NULL,
    MedicationName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Duration VARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Insert sample data into Specializations
INSERT INTO Specializations (Name) VALUES ('Cardiology'), ('Dermatology'), ('Pediatrics');

-- Insert sample data into Doctors
INSERT INTO Doctors (FirstName, LastName, Email, Phone, SpecializationID) 
VALUES 
('John', 'Doe', 'john.doe@clinic.com', '555-1234', 1),
('Jane', 'Smith', 'jane.smith@clinic.com', '555-5678', 2);

-- Insert sample data into Patients
INSERT INTO Patients (FirstName, LastName, Email, Phone, DateOfBirth) 
VALUES 
('Alice', 'Johnson', 'alice.johnson@patient.com', '555-8765', '1985-02-15'),
('Bob', 'Williams', 'bob.williams@patient.com', '555-4321', '1990-11-25');

-- Insert sample data into Appointments
INSERT INTO Appointments (AppointmentDate, PatientID, DoctorID, Reason) 
VALUES 
('2025-05-15 09:00:00', 1, 1, 'Routine checkup'), 
('2025-05-16 11:00:00', 2, 2, 'Skin rash');

-- Insert sample data into Prescriptions
INSERT INTO Prescriptions (AppointmentID, MedicationName, Dosage, Duration) 
VALUES 
(1, 'Aspirin', '500mg', '7 days'),
(2, 'Hydrocortisone', '1% cream', '14 days');

-- Sample query: Get all appointments for a specific patient (e.g., Alice)
SELECT * 
FROM Appointments
WHERE PatientID = (SELECT PatientID FROM Patients WHERE FirstName = 'Alice' AND LastName = 'Johnson');

-- Sample query: Get all doctors of a specific specialization (e.g., Dermatology)
SELECT * 
FROM Doctors
WHERE SpecializationID = (SELECT SpecializationID FROM Specializations WHERE Name = 'Dermatology');

-- Sample query: Get all prescriptions for a specific appointment
SELECT * 
FROM Prescriptions
WHERE AppointmentID = 1;
