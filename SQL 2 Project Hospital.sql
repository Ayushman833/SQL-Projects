DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(30),
    disease VARCHAR(50),
    admission_date DATE,
    discharge_date DATE
);

DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    experience INT
);

DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id),
    appointment_date DATE,
    fees DECIMAL(10,2)
);

INSERT INTO patients 
VALUES
(1,'Rahul',25,'Male','Raipur','Fever','2026-07-01','2026-07-04'),
(2,'Priya',30,'Female','Bilaspur','Covid','2026-07-02','2026-07-10'),
(3,'Aman',40,'Male','Raipur','Diabetes','2026-07-05','2026-07-08'),
(4,'Neha',35,'Female','Durg','Fever','2026-07-03','2026-07-05'),
(5,'Rohit',28,'Male','Raigarh','Malaria','2026-07-06','2026-07-12');

INSERT INTO doctors 
VALUES
(101,'Dr. Sharma','Physician',12),
(102,'Dr. Mehta','Cardiologist',15),
(103,'Dr. Singh','Neurologist',10);

INSERT INTO appointments 
VALUES
(1001,1,101,'2026-07-01',500),
(1002,2,101,'2026-07-02',600),
(1003,3,102,'2026-07-05',1000),
(1004,4,101,'2026-07-03',500),
(1005,5,103,'2026-07-06',800);

SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;

--Basic (1–8) :

--Display all patient records.
SELECT * FROM patients;

--Show only patient names and ages.
SELECT patient_name, age FROM patients;

--Find patients whose age is greater than 30.
SELECT * FROM patients
WHERE age>30;

--Show all female patients.
SELECT * FROM patients
WHERE gender='Female';

-- patients suffering from Fever.
SELECT * FROM patients
WHERE disease='Fever';

--Display patients from Raipur.
SELECT * FROM patients
WHERE city='Raipur';

--Count the total number of patients.
SELECT COUNT(*) AS Total_Patients
FROM patients;

--Find the average age of patients.
SELECT AVG(age) AS Avg_Age
FROM patients;

--Intermediate (9–14) :

--Find the oldest patient.
SELECT * FROM patients
ORDER BY age DESC LIMIT 1;

--Find the youngest patient.
SELECT * FROM patients
ORDER BY age ASC LIMIT 1;

--Display patients sorted by age (highest to lowest).
SELECT * FROM patients
ORDER BY age DESC;

--Count patients city-wise.
SELECT city, COUNT(*) AS Total_patient
FROM patients
GROUP BY city;

--Count patients disease-wise.
SELECT disease, COUNT(*) AS Total_Patient
FROM patients
GROUP BY disease;

--Show patients admitted after 2026-07-03.
SELECT * FROM patients
WHERE admission_date>'2026-07-03';

--JOIN Practice (15–20):

--Display patient name and doctor name.
SELECT p.patient_name, d.doctor_name
FROM appointments a
JOIN patients p on a.patient_id=p.patient_id
JOIN doctors d on a.doctor_id=d.doctor_id;

--Show patient name, doctor name, and appointment date.
SELECT p.patient_name,
       d.doctor_name,
       a.appointment_date
FROM appointments a
JOIN patients p
ON a.patient_id = p.patient_id
JOIN doctors d
ON a.doctor_id = d.doctor_id;

--Find the total fees collected.
SELECT SUM(fees) AS total_fees
FROM appointments;

--Find total fees collected by each doctor.
SELECT d.doctor_name, SUM(a.fees) AS total_fees
FROM appointments a
JOIN doctors d ON a.doctor_id=d.doctor_id
GROUP BY d.doctor_name;

--Count how many patients each doctor treated.
SELECT d.doctor_name,
       COUNT(a.patient_id) AS total_patients
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name;

--Find the doctor who treated the maximum number of patients.
SELECT d.doctor_name,
       COUNT(a.patient_id) AS total_patients
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY total_patients DESC
LIMIT 1;