DROP DATABASE IF EXISTS SmartClinicDB;
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

CREATE TABLE Bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    BillDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    TreatmentID INT NOT NULL UNIQUE,
    CONSTRAINT fk_bill_treatment
        FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);


CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Method VARCHAR(30) NOT NULL,
    BillID INT NOT NULL,
    CONSTRAINT fk_payment_bill
        FOREIGN KEY (BillID) REFERENCES Bill(BillID)
);


INSERT INTO Person
    (PersonID, FirstName, LastName, Phone, Address)
VALUES
    (1, 'Ahmed', 'Ali', '0532847195', 'Riyadh'),
    (2, 'Sara', 'Mohammed', '0559182634', 'Jeddah'),
    (3, 'Omar', 'Hassan', '0504762819', 'Dammam'),
    (4, 'Lina', 'Khalid', '0573926158', 'Makkah'),
    (5, 'Yousef', 'Saad', '0541873026', 'Madinah'),
    (6, 'Fahad', 'Saleh', '0569238147', 'Riyadh'),
    (7, 'Nora', 'Ahmed', '0584719263', 'Jeddah'),
    (8, 'Majed', 'Omar', '0593827146', 'Taif'),
    (9, 'Reem', 'Salem', '0516473829', 'Abha'),
    (10, 'Hassan', 'Ali', '0529183746', 'Tabuk');

INSERT INTO Department
    (DepartmentID, DepartmentName)
VALUES
    (1, 'Cardiology'),
    (2, 'Dentistry'),
    (3, 'Dermatology'),
    (4, 'Neurology'),
    (5, 'Pediatrics');

INSERT INTO Patient
    (PatientID, PersonID, Gender, DOB)
VALUES
    (1, 1, 'Male', '1998-05-10'),
    (2, 2, 'Female', '2000-08-15'),
    (3, 3, 'Male', '1995-11-20'),
    (4, 6, 'Male', '1997-03-12'),
    (5, 7, 'Female', '1999-09-25');

INSERT INTO Doctor
    (DoctorID, PersonID, Specialization, DepartmentID)
VALUES
    (1, 4, 'Cardiologist', 1),
    (2, 5, 'Pediatrician', 5),
    (3, 8, 'Dentist', 2),
    (4, 9, 'Dermatologist', 3),
    (5, 10, 'Neurologist', 4);


INSERT INTO Appointment
    (AppointmentID, AppointmentDate, Status, PatientID, DoctorID)
VALUES
    (1, '2025-05-01 09:00:00', 'Completed', 1, 1),
    (2, '2025-05-02 10:00:00', 'Completed', 2, 2),
    (3, '2025-05-03 11:00:00', 'Completed', 3, 3),
    (4, '2025-05-04 13:00:00', 'Completed', 4, 4),
    (5, '2025-05-05 14:00:00', 'Completed', 5, 5);

INSERT INTO Treatment
    (TreatmentID, Diagnosis, Description, AppointmentID)
VALUES
    (1, 'Flu', 'Medication and rest', 1),
    (2, 'Tooth Pain', 'Dental filling', 2),
    (3, 'Skin Allergy', 'Allergy treatment', 3),
    (4, 'Migraine', 'Pain relief therapy', 4),
    (5, 'Fever', 'Paracetamol prescribed', 5);


INSERT INTO Medicine
    (MedicineID, MedicineName, Price)
VALUES
    (1, 'Paracetamol', 15.00),
    (2, 'Amoxicillin', 35.00),
    (3, 'Ibuprofen', 20.00),
    (4, 'Cetirizine', 18.00),
    (5, 'Vitamin C', 25.00);


INSERT INTO Prescription
    (PrescriptionID, TreatmentID, MedicineID, Dosage, Duration)
VALUES
    (1, 1, 1, '500 mg', '5 Days'),
    (2, 2, 2, '250 mg', '7 Days'),
    (3, 3, 4, '10 mg', '10 Days'),
    (4, 4, 3, '400 mg', '5 Days'),
    (5, 5, 5, '1000 mg', '14 Days');


INSERT INTO Bill
    (BillID, BillDate, TotalAmount, TreatmentID)
VALUES
    (1, '2025-05-01', 150.00, 1),
    (2, '2025-05-02', 300.00, 2),
    (3, '2025-05-03', 220.00, 3),
    (4, '2025-05-04', 180.00, 4),
    (5, '2025-05-05', 120.00, 5);


INSERT INTO Payment
    (PaymentID, PaymentDate, Amount, Method, BillID)
VALUES
    (1, '2025-05-01', 150.00, 'Cash', 1),
    (2, '2025-05-02', 300.00, 'Credit Card', 2),
    (3, '2025-05-03', 220.00, 'Cash', 3),
    (4, '2025-05-04', 180.00, 'Debit Card', 4),
    (5, '2025-05-05', 120.00, 'Cash', 5);