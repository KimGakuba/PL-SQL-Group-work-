CREATE TABLE login_auditt (
    audit_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username      VARCHAR2(100),
    attempt_time  DATE DEFAULT SYSDATE,
    status        VARCHAR2(20),      -- SUCCESS or FAILED
    ip_address    VARCHAR2(50)
);


CREATE TABLE security_alertss (
    alert_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username        VARCHAR2(100),
    failed_count    NUMBER,
    alert_time      DATE DEFAULT SYSDATE,
    alert_message   VARCHAR2(200),
    contact_email   VARCHAR2(150)
);

/*
CREATE OR REPLACE TRIGGER trg_login_monitor
AFTER INSERT ON login_auditt
FOR EACH ROW
DECLARE
    v_failed_count NUMBER;
BEGIN
    -- Only act on failed attempts
    IF :NEW.status = 'FAILED' THEN

        -- Count today's failed attempts by the same user
        SELECT COUNT(*)
        INTO v_failed_count
        FROM login_auditt
        WHERE username = :NEW.username
          AND status = 'FAILED'
          AND TRUNC(attempt_time) = TRUNC(SYSDATE);

        -- If failed attempts exceed 2 -> trigger alert
        IF v_failed_count > 2 THEN
            INSERT INTO security_alertss (
                username,
                failed_count,
                alert_message,
                contact_email
            ) VALUES (
                :NEW.username,
                v_failed_count,
                'Suspicious login behavior detected: more than two failed attempts.',
                :NEW.username || '@company.com'
            );
        END IF;

    END IF;
END;
*/




/*CREATE OR REPLACE PROCEDURE send_security_email (
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


CREATE OR REPLACE TRIGGER trg_login_monitor
AFTER INSERT ON login_auditt
FOR EACH ROW
DECLARE
    v_failed_count NUMBER;
BEGIN
    IF :NEW.status = 'FAILED' THEN

        -- Count today's failed attempts for this user
        SELECT COUNT(*)
        INTO v_failed_count
        FROM login_auditt
        WHERE username = :NEW.username
          AND status = 'FAILED'
          AND TRUNC(attempt_time) = TRUNC(SYSDATE);

        -- After more than 2 failed attempts, create an alert
        IF v_failed_count > 2 THEN
            INSERT INTO security_alertss (
                username,
                failed_count,
                alert_message,
                contact_email
            ) VALUES (
                :NEW.username,
                v_failed_count,
                'Suspicious login behavior detected: more than two failed attempts.',
                :NEW.username || '@kim.com'
            );
        END IF;

    END IF;

END;
/


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Kim', 'FAILED', '192.168.1.10');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Kim', 'FAILED', '192.168.1.10');

INSERT INTO login_audit(username, status, ip_address)
VALUES ('Kim', 'FAILED', '192.168.1.10');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Jessicah', 'FAILED', '192.168.1.11');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Jessicah', 'FAILED', '192.168.1.11');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Jessicah', 'FAILED', '192.168.1.11');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '192.168.1.12');

INSERT INTO login_audit(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '192.168.1.12');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Benjamin', 'FAILED', '192.168.1.12');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Kevin', 'FAILED', '192.168.1.14');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Aliane', 'FAILED', '192.168.1.15');


INSERT INTO login_audit(username, status, ip_address)
VALUES ('Aliane', 'FAILED', '192.168.1.15');


SELECT * FROM security_alertss;


SELECT * FROM login_auditt ORDER BY audit_id;

SELECT table_name FROM user_tables
WHERE table_name IN ('LOGIN_AUDITT', 'SECURITY_ALERTSS');

INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '1.1.1.1');

COMMIT;


*/

CREATE OR REPLACE TRIGGER trg_login_monitor
FOR INSERT ON login_auditt
COMPOUND TRIGGER

    -- Temporary collection to store failed login attempts from this statement
    TYPE t_user_list IS TABLE OF login_auditt.username%TYPE;
    failed_users t_user_list := t_user_list();

AFTER EACH ROW IS
BEGIN
    -- Only track FAILED attempts
    IF :NEW.status = 'FAILED' THEN
        failed_users.EXTEND;
        failed_users(failed_users.LAST) := :NEW.username;
    END IF;
END AFTER EACH ROW;

AFTER STATEMENT IS
    v_failed_count NUMBER;
BEGIN
    -- Loop over all failed users collected
    FOR i IN 1 .. failed_users.COUNT LOOP

        -- Count today's failed attempts for each affected user
        SELECT COUNT(*)
        INTO v_failed_count
        FROM login_auditt
        WHERE username = failed_users(i)
          AND status = 'FAILED'
          AND TRUNC(attempt_time) = TRUNC(SYSDATE);

        -- Insert alert only if more than 2 failed attempts
        IF v_failed_count > 2 THEN
            INSERT INTO security_alertss(
                username,
                failed_count,
                alert_message,
                contact_email
            ) VALUES (
                failed_users(i),
                v_failed_count,
                'Suspicious login behavior detected: more than two failed attempts.',
                failed_users(i) || '@company.com'
            );
        END IF;

    END LOOP;

END AFTER STATEMENT;

END trg_login_monitor;
/


INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '1.1.1.1');

INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '1.1.1.1');

INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Leslie', 'FAILED', '1.1.1.1');

COMMIT;


SELECT * FROM login_auditt ORDER BY audit_id;


INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Kim', 'FAILED', '2.2.2.2');

INSERT INTO login_auditt(username, status, ip_address)
VALUES ('Kim', 'FAILED', '2.2.2.2');


SELECT * FROM security_alertss;

