
USE bookrestaurant_db;

CREATE PROCEDURE AddEmployee(
    IN p_id VARCHAR(36),
    IN p_first_name VARCHAR(200),
    IN p_last_name VARCHAR(200),
    IN p_email VARCHAR(200),
    IN p_phone VARCHAR(50),
    IN p_birth_date DATE,
    IN p_position VARCHAR(200)
)
BEGIN
    INSERT INTO employees (id, first_name, last_name, email, phone, birth_date, position)
    VALUES (p_id, p_first_name, p_last_name, p_email, p_phone, p_birth_date, p_position);
END
