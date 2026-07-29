-- ============================================
-- CS350 - Smart Clinic Database Project
-- Task 3: SQL Operations
-- ============================================

USE SmartClinicDB;

-- ============================================
-- 1. SELECT
-- Purpose: Retrieves the name, gender, and date of birth for every registered patient.
-- ============================================
SELECT p.FirstName, p.LastName, pt.Gender, pt.DOB
FROM person p
JOIN patient pt ON p.PersonID = pt.PersonID;


-- ============================================
-- 2. JOIN
-- Purpose: Shows which patient saw which doctor and on what date, joining across 5 tables.
-- ============================================
SELECT a.AppointmentID, a.AppointmentDate, 
       CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName,
       CONCAT(dp.FirstName, ' ', dp.LastName) AS DoctorName
FROM appointment a
JOIN patient pt ON a.PatientID = pt.PatientID
JOIN person pp ON pt.PersonID = pp.PersonID
JOIN doctor d ON a.DoctorID = d.DoctorID
JOIN person dp ON d.PersonID = dp.PersonID;


-- ============================================
-- 3. NESTED QUERY (SUBQUERY)
-- Purpose: Finds medicines priced above the clinic's average medicine price.
-- ============================================
SELECT MedicineName, Price
FROM medicine
WHERE Price > (SELECT AVG(Price) FROM medicine);


-- ============================================
-- 4. AGGREGATE FUNCTION + GROUP BY
-- Purpose: Counts how many appointments each doctor has handled.
-- ============================================
SELECT d.DoctorID, dp.FirstName, dp.LastName, COUNT(a.AppointmentID) AS TotalAppointments
FROM doctor d
JOIN person dp ON d.PersonID = dp.PersonID
JOIN appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, dp.FirstName, dp.LastName;


-- ============================================
-- 5. UPDATE AND DELETE
-- Purpose (UPDATE): Updates an appointment's status to demonstrate data modification.
-- Purpose (DELETE): Removes a specific payment record to demonstrate deletion.
-- ============================================

-- Before UPDATE
SELECT * FROM appointment WHERE AppointmentID = 3;

-- UPDATE
UPDATE appointment SET Status = 'Rescheduled' WHERE AppointmentID = 3;

-- After UPDATE
SELECT * FROM appointment WHERE AppointmentID = 3;

-- Before DELETE
SELECT * FROM payment WHERE PaymentID = 4;

-- DELETE
DELETE FROM payment WHERE PaymentID = 4;

-- After DELETE
SELECT * FROM payment WHERE PaymentID = 4;

-- ============================================
-- 6. VIEW
-- Purpose: Creates a reusable view summarizing each bill with the associated patient's name.
-- ============================================
CREATE VIEW BillSummary AS
SELECT b.BillID, CONCAT(pp.FirstName, ' ', pp.LastName) AS PatientName, 
       b.TotalAmount, b.BillDate
FROM bill b
JOIN treatment t ON b.TreatmentID = t.TreatmentID
JOIN appointment a ON t.AppointmentID = a.AppointmentID
JOIN patient pt ON a.PatientID = pt.PatientID
JOIN person pp ON pt.PersonID = pp.PersonID;

-- View the output
SELECT * FROM BillSummary;



-- ============================================
-- 7. TRIGGER
-- Purpose: Automatically updates an appointment's status to "Completed" the moment
-- a treatment is recorded for it.
-- ============================================
DELIMITER //
CREATE TRIGGER after_treatment_insert
AFTER INSERT ON treatment
FOR EACH ROW
       
BEGIN
  UPDATE appointment
  SET Status = 'Completed'
  WHERE AppointmentID = NEW.AppointmentID;
END//
DELIMITER ;
