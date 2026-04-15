# 🏥 Hospital Database Migration & Automation

## 📌 Project Overview
This project focuses on transforming a **hospital's Excel-based data system** into a **structured relational database (RDBMS)**.  
The goal was to improve **data integrity, scalability, security, and reporting capabilities**.

---

## 🚨 Problem Statement
The hospital was managing all data (patients, doctors, appointments, billing, etc.) in a **single Excel file**, which caused:

- ❌ No unique identifiers (data duplication risk)
- ❌ No relationships between entities
- ❌ Invalid and inconsistent data entries
- ❌ Doctor double-booking & past appointments
- ❌ No access control (data privacy issue)
- ❌ No reporting system for business insights

---

## 🎯 Objectives
- Design a **normalized relational database**
- Ensure **data integrity & consistency**
- Implement **business rules**
- Enable **secure data access**
- Generate **department-wise revenue reports**

---

## 🧠 Database Design

### 📊 Tables Created
- **Departments**
- **Doctors**
- **Patients**
- **Appointments**
- **Prescriptions**
- **Bills**
- **Lab Reports**

---

## 🔗 Entity Relationships

- **Department → Doctors** (1-to-Many)
- **Doctors → Appointments** (1-to-Many)
- **Patients → Appointments** (1-to-Many)
- **Appointments → Prescriptions/Bills/Lab Reports** (1-to-Many)

👉 The **Appointments table acts as a central hub** connecting all operational data.

---

## 🏗️ Database Schema (SQL)

### 🏥 Departments
```sql
CREATE TABLE departments (
  departmentID INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);
```

### 👨‍⚕️ Doctors
```sql
CREATE TABLE doctors (
  doctorid INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  specialization VARCHAR(100),
  role VARCHAR(50),
  departmentid INT,
  FOREIGN KEY (departmentid) REFERENCES departments(departmentid)
);
```

### 🧑 Patients
```sql
CREATE TABLE patients (
  patientid INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  dateofbirth DATE,
  gender VARCHAR(1),
  phone VARCHAR(15),
  CHECK (gender IN ('M','F','O'))
);
```

### 📅 Appointments
```sql
CREATE TABLE appointments (
  appointmentid INT AUTO_INCREMENT PRIMARY KEY,
  patientid INT,
  doctorid INT,
  appointmenttime DATETIME,
  status VARCHAR(50),
  FOREIGN KEY (patientid) REFERENCES patients(patientid),
  FOREIGN KEY (doctorid) REFERENCES doctors(doctorid),
  CHECK (status IN ('Scheduled','Completed','Cancelled'))
);
```

### 💊 Prescriptions
```sql
CREATE TABLE prescriptions (
  prescriptionid INT AUTO_INCREMENT PRIMARY KEY,
  appointmentid INT,
  medication VARCHAR(100),
  dosage VARCHAR(100),
  FOREIGN KEY (appointmentid) REFERENCES appointments(appointmentid)
);
```
### 💰 Bills
```sql
CREATE TABLE bills (
  billid INT AUTO_INCREMENT PRIMARY KEY,
  appointmentid INT,
  amount DECIMAL(10,2),
  paid TINYINT(1),
  billdate DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (appointmentid) REFERENCES appointments(appointmentid)
);
```

### 🧪 Lab Reports
```sql
CREATE TABLE labreports (
  reportid INT AUTO_INCREMENT PRIMARY KEY,
  appointmentid INT,
  reportdata TEXT,
  createdat DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (appointmentid) REFERENCES appointments(appointmentid)
);
```

## 🔄 Data Migration Strategy
--------------------------

*   Extracted data from Excel (hospital\_data)
    
*   Split into multiple normalized tables
    
*   Used:
    
    *   STR\_TO\_DATE() → convert date formats
        
    *   NULLIF() → handle empty values
        
*   Inserted clean data into structured tables


## ⚙️ Business Logic Implementation

### 🔴 Trigger: Prevent Invalid Appointments
```sql
CREATE TRIGGER check_new_appointment
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
   IF NEW.appointmenttime < NOW() THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Appointment cannot be in the past';
   END IF;

   IF EXISTS (
      SELECT 1 FROM appointments
      WHERE doctorid = NEW.doctorid
      AND appointmenttime = NEW.appointmenttime
      AND status = 'Scheduled'
   ) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Doctor already booked at this time';
   END IF;
END;
```

### 🔐 Stored Procedure: Role-Based Access Control
```sql
CREATE PROCEDURE view_doctor_data(IN username VARCHAR(100), IN password VARCHAR(100))
BEGIN
  -- Logic for role-based patient data access
END;
```

**👉 Features:**

- Senior doctors → Access all patients in department
- Junior doctors → Access only their patients

### 📊 Stored Procedure: Monthly Revenue Report
```sql
CREATE PROCEDURE sp_monthlyrevenue(IN p_year INT, IN p_month INT)
BEGIN
 SELECT d1.name AS department,
        SUM(b.amount) AS total_revenue
 FROM bills b
 JOIN appointments a ON a.appointmentid = b.appointmentid
 JOIN doctors d ON a.doctorid = d.doctorid
 JOIN departments d1 ON d1.departmentid = d.departmentid
 WHERE MONTH(b.billdate) = p_month
   AND YEAR(b.billdate) = p_year
 GROUP BY d1.name;
END;
```
-------------------------------------------
## 🧪 Key Features
- ✅ Data Normalization (Excel → RDBMS)
- ✅ Primary & Foreign Keys (Integrity)
- ✅ Data Validation (CHECK constraints)
- ✅ Automation (Triggers)
- ✅ Security (Role-based access)
- ✅ Reporting (Revenue insights)

 -------------------------------------------
## 🚀 Key Learnings
Designing real-world relational database systems
Implementing data integrity constraints
Writing advanced SQL queries
Using triggers & stored procedures
Handling data migration & cleaning
Applying business rules in databases

-----------------------------
### 📈 Future Improvements
- Add indexing for performance optimization
- Implement user authentication system
- Create dashboards using Power BI
- Add audit logs for tracking changes


-----------------------------------
## 👨‍💻 Author
**Ankit Raj**
