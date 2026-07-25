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