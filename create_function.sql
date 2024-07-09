
USE bookrestaurant_db;

CREATE FUNCTION CalculateAveragePriceByGenre(genre_name VARCHAR(50))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avg_price DECIMAL(10, 2);
    SELECT AVG(price) INTO avg_price
    FROM books
    WHERE genre = genre_name;
    RETURN avg_price;
END

SELECT CalculateAveragePriceByGenre('Non-Fiction');
