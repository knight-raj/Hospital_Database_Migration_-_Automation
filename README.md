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
