CREATE DATABASE SmartClinicDB;
USE SmartClinicDB;

CREATE TABLE Person (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Address VARCHAR(100) NOT NULL
);

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    DOB DATE NOT NULL,
    CONSTRAINT fk_patient_person
        FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    CONSTRAINT fk_doctor_person
        FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    CONSTRAINT fk_doctor_department
        FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(30) NOT NULL,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    Diagnosis VARCHAR(200) NOT NULL,
    Description VARCHAR(255),
    AppointmentID INT NOT NULL UNIQUE,
    CONSTRAINT fk_treatment_appointment
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    Price DECIMAL(8,2) NOT NULL
);

CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    TreatmentID INT NOT NULL,
    MedicineID INT NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    CONSTRAINT fk_prescription_treatment
        FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
    CONSTRAINT fk_prescription_medicine
        FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);