## 👥 Group Members  
This project was completed by the following team members:  
- NGABONZIZA Kim Gakuba — Student ID: 27670  
- GATERA K Jessica — Student ID: 27630  
- Teta kevine — Student ID: 27973
- Umutoniwase Aliane— Student ID: 27771
- Akariza GASANA Leslie — Student ID: 27413
- Benjamin Niyongira — Student ID: 27883

---
# Hospital Management Package — PL/SQL Project

---

##  📌 What the Question Was About 

The task was to create a PL/SQL package for a simplified Hospital Management System.
The system should:
1. Store patients and doctors in database tables.
2. Allow bulk loading of multiple patients at once.
3. Allow displaying all patients using a function (REF CURSOR).
4. Allow admitting a patient individually.
5. Count how many patients are currently admitted.
6. Demonstrate bulk processing using FORALL, collections & records.

### This project is part of a PL/SQL assessment involving collections, records, procedures, functions, commits, and testing.

And as a group This project successfully demonstrates advanced PL/SQL programming using packages, triggers, collections, bulk operations, and database security concepts. The Hospital Management Package efficiently manages patient data, while the Security Monitoring System ensures safe access to the database through automated detection of suspicious login behavior. Together, they show the integration of performance, security, and data management in Oracle PL/SQL.

## *📌 2. How we Solved It*

✔ Step 1 — we created two tables:

patientss

doctorss

--- 

✔ Step 2 — we created the package specification:

This defines:

A record type for a patient

A table type (collection) for bulk processing

Procedures & functions required by the question


![compiled package](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/creating%20package.png)

---

![compiled procedure](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/tesfting%20the%20procedure.png)


---

✔ Step 3 — we created the package body:
Implemented:

bulk_load_patients using FORALL

show_all_patients returning SYS_REFCURSOR

count_admitted returning a number

admit_patient updating admitted status

All operations use COMMIT for database consistency.

![compiled body package](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/package%20body%20compolied.png)

---

![displaying patients](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/display%20patients.png)

---

✔ Step 4 — we wrote test scripts:

Insert multiple patients at once

Display them

Admit selected patients

Verify admitted count

![admitting pateint](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/admitting%20a%20patient.png)

---

![count admitted](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q4/count%20admitted.png)


🚀 Final Outcome

Bulk patient insertion is working using collections + FORALL

Patient listing works using REF CURSOR

Admission update works correctly

Admitted count function returns accurate results

Test scripts run successfully in SQL Developer / Oracle Live SQL








# 🔐 Database Security Monitoring System  
### (Suspicious Login Detection Using Oracle Triggers)

## 📌 Project Overview  
This project implements an automatic **security monitoring system** inside an Oracle database.  
The system tracks all login attempts and automatically raises alerts when a user repeatedly enters incorrect login credentials.

This project was created as part of a PL/SQL and Database Security assessment.

---

## 📘 **Problem Statement**
The organization introduced a new security policy:

> “If any user attempts to log in more than two times with incorrect credentials during the same day, the system must immediately record the event and trigger a security alert.”

### To implement this, the database must:
1. Store all login attempts  
2. Detect suspicious repeated failures  
3. Insert a security alert automatically  
4. (Optional) Trigger an email notification  

---

## 🧩 **How the Problem Was Solved**

### ✔ Step 1 — Login Audit Table  
A table to record every login attempt (success or failure).  
Used for monitoring and counting failed logins.

![creating login auditt table](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q3/Creating%20table%20of%20login.png)

### ✔ Step 2 — Security Alerts Table  
Stores alerts when a user fails login more than two times in a day.

![creating table for security alerts](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q3/creating%20table%20of%20security%20alerts.png)

---

### ✔ Step 3 — Compound Trigger (Mutating-safe)  
A normal row-level trigger caused:
```
ORA-04091: table is mutating
```
because it queried the same table during an insert.

**Solution:** A **compound trigger** that:  
- Collects all failed attempts in memory  
- After the statement completes, counts failures from the table  
- Inserts alerts only when needed  
- Avoids mutating-table errors

---
```
CREATE OR REPLACE PROCEDURE send_security_email (
    p_username  VARCHAR2,
    p_count     NUMBER
) AS
BEGIN
    UTL_MAIL.SEND(
        sender     => 'security@company.com',
        recipients => 'securityteam@company.com',
        subject    => 'Security Alert: Suspicious Login',
        message    => 'User ' || p_username ||
                      ' has failed login ' || p_count ||
                      ' times today.'
    );
END;
/
```
The code gave us this error
```
PLS-00201: identifier 'UTL_MAIL.SEND' must be declared
```
"This means your Oracle database does NOT have UTL_MAIL enabled, or you don’t have permission to use it."


📸 Screenshots

Add these after running the SQL commands in your Oracle SQL Developer

1. Screenshot: Check login attempts:

🖼️ ![checking login attempts](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q3/testing%20audit%20login.png)

2. Screenshot: Check security alerts:

🖼️ ![Checking security alerts](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q3/testing%20security%20alerts.png)

3. Screenshot: Compound Trigger to Detect Failed Attempts

🖼️ ![Compound Trigger to Detect Failed Attempts](https://github.com/KimGakuba/PL-SQL-Group-work-/blob/main/screenshots/Q3/compiling%20the%20monitor%20trigger.png)
