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

## *📌 2. How I Solved It*
✔ Step 1 — I created two tables:
patientss
doctorss

--- 

✔ Step 2 — I created the package specification:

This defines:
A record type for a patient
A table type (collection) for bulk processing
Procedures & functions required by the question


![compiled package](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/creating%20package.png)

---

![compiled procedure](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/tesfting%20the%20procedure.png)


---

✔ Step 3 — I created the package body:
Implemented:
bulk_load_patients using FORALL
show_all_patients returning SYS_REFCURSOR
count_admitted returning a number
admit_patient updating admitted status
All operations use COMMIT for database consistency.

![compiled body package](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/package%20body%20compolied.png)

---

![displaying patients](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/display%20patients.png)

---

✔ Step 4 — I wrote test scripts:
Insert multiple patients at once
Display them
Admit selected patients
Verify admitted count
![admitting pateint](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/admitting%20a%20patient.png)

---

![count admitted](https://github.com/KimGakuba/PL-SQL-Group-work-tackling-scenarios/blob/main/screenshots/Q4/count%20admitted.png)


🚀 Final Outcome

Bulk patient insertion is working using collections + FORALL

Patient listing works using REF CURSOR

Admission update works correctly

Admitted count function returns accurate results

Test scripts run successfully in SQL Developer / Oracle Live SQL
