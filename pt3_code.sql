-- 1
SELECT *, (SELECT o.customer_id FROM orders AS o WHERE o.id = od.order_id) AS customer_id FROM order_details AS od;

-- 2
SELECT * FROM order_details od WHERE od.order_id IN (SELECT o.id FROM orders o WHERE o.shipper_id = 3); 

-- 3
SELECT order_id, AVG(quantity) AS avg_quantity FROM (SELECT * FROM order_details WHERE quantity > 10) AS temp_table GROUP BY order_id;

-- 4
WITH TemporalTable AS (
    SELECT * 
    FROM order_details 
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity FROM TemporalTable GROUP BY order_id;

-- 5
DROP FUNCTION IF EXISTS DivideFloats;

DELIMITER //

CREATE FUNCTION DivideFloats(p_first FLOAT, p_second FLOAT)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
    RETURN p_first / p_second;
END //

DELIMITER ;

SELECT *, DivideFloats(quantity, 2) AS div_quantity FROM order_details;