
USE bookrestaurant_db;

-- CREATE USER 1

CREATE USER 'customer_reader'@'localhost' IDENTIFIED BY 'customerread1!';

GRANT SELECT ON bookrestaurant_db.customers TO 'customer_reader'@'localhost';

SHOW GRANTS FOR 'customer_reader'@'localhost';

-- CREATE USER 2

CREATE USER 'employee_inserter'@'localhost' IDENTIFIED BY 'employeeinsert1!';

GRANT INSERT ON bookrestaurant_db.employees TO 'employee_inserter'@'localhost';

SHOW GRANTS FOR 'employee_inserter'@'localhost';

-- CREATE USER 3

CREATE USER 'salary_deleter'@'localhost' IDENTIFIED BY 'salarydelete1!';

GRANT DELETE ON bookrestaurant_db.salary TO 'salary_deleter'@'localhost';

SHOW GRANTS FOR 'salary_deleter'@'localhost';
