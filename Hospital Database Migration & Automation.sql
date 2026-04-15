CREATE DATABASE EHIAS;
USE EHIAS;

-- CREATING DEPARTMENT TABLE
create table departments
(
  departmentID int auto_increment primary key,
  name varchar(50) not null
);

-- CREATING TABLE DOCTORS
create table doctors
(
  doctorid int auto_increment primary key,
  name varchar(50),
  specialization varchar(100),
  role varchar(50),
  departmentid int,
  foreign key (departmentid) references departments(departmentid)
);

-- CREATE PATIENTS
CREATE TABLE PATIENTS
(
  Patientid int auto_increment primary key,
  name varchar(50),
  DateofBirth date,
  Gender varchar(1),
  phone varchar(15),
  check (gender in('m', 'f','o'))
);

-- CREATE APPOINTMENT
CREATE TABLE APPOINTMENTS
(
 appointmentid int auto_increment primary key,
 patientid int ,
 doctorid int,
 appointmenttime datetime,
 status  varchar(50),
 foreign key (patientid) references patients(patientid),
 foreign key (doctorid) references doctors(doctorid),
 check (status in ('Scheduled','Completed','Cancelled'))
);

-- PRESCRIPTION TABLE
CREATE TABLE PRESCRIPTIONS
( 
PRECRIPTIONID INT auto_increment primary key,
APPOINTMENTID INT,
MEDICATION VARCHAR(100),
DOSAGE VARCHAR(100),
FOREIGN KEY  (APPOINTMENTID) REFERENCES APPOINTMENTS(appointmentid)
);

-- BILLS TABLE
CREATE TABLE BILLS
( 
 BILLID INT auto_increment primary key,
 APPOINTMENTID INT,
 AMOUNT DECIMAL(10,2),
 PAID TINYINT(1),
 BILLDATE DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY  (APPOINTMENTID) REFERENCES APPOINTMENTS(appointmentid)
);

-- LABREPORT TABLES
CREATE TABLE LABREPORTS
( 
 REPORTID INT auto_increment primary key,
 APPOINTMENTID INT,
 REPORTDATA TEXT,
 CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY  (APPOINTMENTID) REFERENCES APPOINTMENTS(appointmentid)
);


-- INSERTION IN DATABASE

SELECT * FROM hospital_data;

-- INSERTING VALUES INTO DEPARTMENT TABLE

SELECT `Departments.DepartmentID` FROM HOSPITAL_DATA;

SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'HOSPITAL_DATA'
  AND COLUMN_NAME LIKE 'Departments.%';

INSERT INTO departments (departmentID, name)
SELECT 
    `Departments.DepartmentID`,
    `Departments.Name`
FROM hospital_data
WHERE `Departments.DepartmentID` <> '';

select * from departments;

-- INSERTING VALUES INTO DOCTORS TABLE
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'HOSPITAL_DATA'
  AND COLUMN_NAME LIKE 'Doctors.%';
  
INSERT INTO DOCTORS (DepartmentID, DoctorID, Name, Role, Specialization)
SELECT 
    `Doctors.DepartmentID`,
    `Doctors.DoctorID`,
    `Doctors.Name`,
    `Doctors.Role`,
    `Doctors.Specialization`
FROM hospital_data
WHERE `Doctors.DepartmentID` IS NOT NULL
  AND `Doctors.DepartmentID` <> '';

SELECT * FROM DOCTORS;

-- INSERTING VALUES INTO PATIENT TABLE
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'HOSPITAL_DATA'
  AND COLUMN_NAME LIKE 'Patients.%';
  
INSERT INTO PATIENTS (PatientID, Name, DateOfBirth, Gender, Phone)
SELECT 
    `Patients.PatientID`,
    `Patients.Name`,
    STR_TO_DATE(`Patients.DateOfBirth`, '%d-%m-%Y'),
    `Patients.Gender`,
    `Patients.Phone`
FROM hospital_data
WHERE `Patients.PatientID` IS NOT NULL
  AND `Patients.PatientID` <> '';
  
SELECT * FROM PATIENTS;

-- INSERT VALUES INTO APPOINTMENT TABLES
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'Appointments.%';
  
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppointmentTime, Status)
SELECT
    `Appointments.AppointmentID`,
    `Appointments.PatientID`,
    `Appointments.DoctorID`,
    STR_TO_DATE(`Appointments.AppointmentTime`, '%d-%m-%Y %H:%i'),
    `Appointments.Status`
FROM hospital_data
WHERE `Appointments.AppointmentID` IS NOT NULL
  AND `Appointments.AppointmentID` <> '';


select * from appointments;


-- INSERTING VALUE INTO PRESCRIPTIONS
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'Prescriptions.%';

INSERT INTO PRESCRIPTIONS (PRECRIPTIONID, AppointmentID, Medication, Dosage)
SELECT
    `Prescriptions.PrescriptionID`,
    `Prescriptions.AppointmentID`,
    `Prescriptions.Medication`,
    `Prescriptions.Dosage`
FROM hospital_data
WHERE `Prescriptions.PrescriptionID` IS NOT NULL
  AND `Prescriptions.PrescriptionID` <> '';
  
SELECT * FROM PRESCRIPTIONS;


--  INSERT DATA INTO LABREPORTS
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'LabReports.%';
  
INSERT INTO LABREPORTS (ReportID, AppointmentID, ReportData, CreatedAt)
SELECT
    `LabReports.ReportID`,
    `LabReports.AppointmentID`,
    `LabReports.ReportData`,
    STR_TO_DATE(NULLIF(`LabReports.CreatedAt`, ''), '%Y-%m-%d %H:%i:%s')
FROM hospital_data
WHERE `LabReports.ReportID` IS NOT NULL
  AND `LabReports.ReportID` <> '';
  
SELECT * FROM LABREPORTS;



-- INSERT DATAI INTO BILLS
SELECT CONCAT(
    'SELECT ',
    GROUP_CONCAT(CONCAT('`', COLUMN_NAME, '`')),
    ' FROM hospital_data'
)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'EHIAS'
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'Bills.%';
  
  
INSERT INTO BILLS (BillID, AppointmentID, Amount, Paid, BillDate)
SELECT
    `Bills.BillID`,
    `Bills.AppointmentID`,
    `Bills.Amount`,
    `Bills.Paid`,
    NULLIF(`Bills.BillDate`, '')
FROM hospital_data
WHERE `Bills.BillID` IS NOT NULL
  AND `Bills.BillID` <> '';
  
SELECT * FROM BILLS

-- POINT 4
drop trigger CHECK_NEW_APPOINMENT

DELIMITER $$
CREATE TRIGGER CHECK_NEW_APPOINMENT
BEFORE INSERT ON APPOINTMENTS
FOR EACH ROW
BEGIN 
   IF NEW.APPOINTMENTTIME< NOW() THEN 
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: Appointment cannot be  in the past.';
   END IF ;
   
   IF  EXISTS
    (
      SELECT * FROM APPOINTMENTS
      WHERE DOCTORID= NEW.DOCTORID AND 
      APPOINTMENTTIME= NEW.APPOINTMENTTIME
      AND STATUS IN ('SCHEDULED')
	) THEN 
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT= 'Error: Doctor Already has an appointment  at this time';
   END IF ;
END $$
DELIMITER ;

INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10000,1,1,'2026-04-25 10:00:00','Scheduled') ;

INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10001,1,1,'2026-04-25 10:00:00','Scheduled') ;


INSERT INTO APPOINTMENTS (appointmentid,patientid,doctorid,appointmenttime,status)
VALUES(10002,1,1,'2025-05-25 10:00:00','Scheduled') ;


-- POINT 5

DELIMITER $$
CREATE PROCEDURE  VIEW_DOCTOR_DATA(IN INPUT_USERNAME VARCHAR(100), IN INPUT_PASSWORD VARCHAR(100))
BEGIN 
  DECLARE DOC_ROLE VARCHAR(100);
  DECLARE DOC_DEPT INT;
  DECLARE DOC_ID INT;
  
  -- CHECK CREDENTIALS OF THE DOCTOR
  SELECT DOCTOR_ID INTO DOC_ID
  FROM  DOCTOR_CREDENTIALS 
  WHERE USER_NAME=INPUT_USERNAME AND PASSWORD=INPUT_PASSWORD;
  
  -- GET ROLE AND DEPARTMENT  FROM DOCTORS TABLE
  SELECT ROLE , DEPARTMENTID
  INTO DOC_ROLE, DOC_DEPT
  FROM DOCTORS WHERE DOCTORID= DOC_ID;
  
  -- SHOW APPROPRIATE PATIENTS DATA.
  IF DOC_ROLE='senior' THEN
     SELECT D.DOCTORID,P.Patientid, P.name, P.Gender, 
	 A.appointmenttime, PR.MEDICATION,LR.REPORTDATA
	 FROM PATIENTS AS P INNER JOIN
	 APPOINTMENTS AS A ON A.PATIENTID=P.PATIENTID
     JOIN DOCTORS  D ON D.DOCTORID= A.DOCTORID
	 LEFT JOIN prescriptions AS PR ON A.APPOINTMENTID = PR.APPOINTMENTID
	 LEFT JOIN LABREPORTS AS LR ON A.APPOINTMENTID = LR.APPOINTMENTID
     WHERE D.DEPARTMENTID= DOC_DEPT;
  ELSE
    SELECT A.DOCTORID,P.Patientid, P.name, P.Gender, 
	 A.appointmenttime, PR.MEDICATION,LR.REPORTDATA
	 FROM PATIENTS AS P INNER JOIN
	 APPOINTMENTS AS A ON A.PATIENTID=P.PATIENTID
	 LEFT JOIN prescriptions AS PR ON A.APPOINTMENTID = PR.APPOINTMENTID
	 LEFT JOIN LABREPORTS AS LR ON A.APPOINTMENTID = LR.APPOINTMENTID
     WHERE A.DOCTORID=DOC_ID;
   END IF;
END$$
DELIMITER ;

CALL VIEW_DOCTOR_DATA('doctor1','W3jzIANG') ;
CALL VIEW_DOCTOR_DATA('doctor4','ic0pFSn0');

-- POINT 6

DELIMITER //
CREATE PROCEDURE SP_MONTHLYREVENUE(IN P_YEAR INT , IN P_MONTH INT)
BEGIN
 SELECT D1.NAME AS DEPARTMENT,
	SUM(B.AMOUNT) AS TOTAL_REVENUE 
	FROM BILLS AS B 
	INNER JOIN APPOINTMENTS AS A ON A.APPOINTMENTID=B.APPOINTMENTID
	INNER JOIN DOCTORS AS D ON A.DOCTORID=D.DOCTORID
	INNER JOIN DEPARTMENTS AS D1 ON D1.DEPARTMENTID=D.DOCTORID
	WHERE  MONTH(B.BILLDATE)=P_MONTH AND YEAR(B.BILLDATE)=P_YEAR
GROUP BY D1.NAME;
END//
DELIMITER ;

CALL SP_MONTHLYREVENUE(2025,5)