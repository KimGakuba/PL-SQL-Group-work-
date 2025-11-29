-- PATIENTS TABLE
CREATE TABLE patientss (
    patient_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name           VARCHAR2(100),
    age            NUMBER,
    gender         VARCHAR2(10),
    admitted       VARCHAR2(3) DEFAULT 'NO'   -- values: YES/NO
);

-- DOCTORS TABLE
CREATE TABLE doctorss (
    doctor_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(100),
    specialty     VARCHAR2(100)
);

CREATE OR REPLACE PACKAGE hospital_mgmt AS

    -- Collection type for bulk loading patients
    TYPE patient_rec IS RECORD(
        name     VARCHAR2(100),
        age      NUMBER,
        gender   VARCHAR2(10)
    );

    TYPE patient_table IS TABLE OF patient_rec;

    -- Procedures & functions
    PROCEDURE bulk_load_patients(p_list patient_table);
    FUNCTION show_all_patients RETURN SYS_REFCURSOR;
    FUNCTION count_admitted RETURN NUMBER;
    PROCEDURE admit_patient(p_id NUMBER);

END hospital_mgmt;
/

CREATE OR REPLACE PACKAGE BODY hospital_mgmt AS

    -------------------------------------------------------------------
    -- 1. BULK INSERT PATIENTS
    -------------------------------------------------------------------
    PROCEDURE bulk_load_patients(p_list patient_table) IS
    BEGIN
        FORALL i IN p_list.FIRST .. p_list.LAST
            INSERT INTO patientss(name, age, gender)
            VALUES (p_list(i).name, p_list(i).age, p_list(i).gender);

        COMMIT;
    END bulk_load_patients;

    -------------------------------------------------------------------
    -- 2. SHOW ALL PATIENTS
    -------------------------------------------------------------------
    FUNCTION show_all_patients RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR
            SELECT * FROM patientss ORDER BY patient_id;
        RETURN rc;
    END show_all_patients;

    -------------------------------------------------------------------
    -- 3. COUNT ADMITTED PATIENTS
    -------------------------------------------------------------------
    FUNCTION count_admitted RETURN NUMBER IS
        total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO total FROM patientss WHERE admitted = 'YES';
        RETURN total;
    END count_admitted;

    -------------------------------------------------------------------
    -- 4. ADMIT A PATIENT
    -------------------------------------------------------------------
    PROCEDURE admit_patient(p_id NUMBER) IS
    BEGIN
        UPDATE patientss
        SET admitted = 'YES'
        WHERE patient_id = p_id;

        COMMIT;
    END admit_patient;

END hospital_mgmt;
/


DECLARE
    p_list hospital_mgmt.patient_table := hospital_mgmt.patient_table();
BEGIN
    p_list.EXTEND(3);

    p_list(1).name := 'Anna';
    p_list(1).age := 30;
    p_list(1).gender := 'Female';

    p_list(2).name := 'John';
    p_list(2).age := 45;
    p_list(2).gender := 'Male';

    p_list(3).name := 'Maria';
    p_list(3).age := 22;
    p_list(3).gender := 'Female';

    hospital_mgmt.bulk_load_patients(p_list);
END;
/


VARIABLE rc REFCURSOR
EXEC :rc := hospital_mgmt.show_all_patients;
PRINT rc;


EXEC hospital_mgmt.admit_patient(2);


SELECT hospital_mgmt.count_admitted FROM dual;

