
USE bookrestaurant_db;

CREATE OR REPLACE VIEW BookOrdersView AS
SELECT
    bo.id AS order_id,
    bo.order_date AS order_date,
    bo.status AS order_status,
    b.title AS book_title,
    b.genre AS book_genre,
    b.price AS book_price,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    c.email AS customer_email,
    c.phone AS customer_phone,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    e.email AS employee_email,
    e.position AS employee_position
FROM book_orders bo
JOIN books b ON bo.book_id = b.id
JOIN customers c ON bo.customer_id = c.id
JOIN employees e ON bo.handled_by = e.id;


SELECT * FROM BookOrdersView;
