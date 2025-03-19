-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- (sale_id, year) is the primary key (combination of columns with unique values) of this table.
-- product_id is a foreign key (reference column) to Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.
 

-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) of this table.
-- Each row of this table indicates the product name of each product.
 

-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

-- Return the resulting table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+
-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+
-- Output: 
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+


-- Solution

-- This solution will get the wrong answer

SELECT product_id, MIN(year) AS first_year, quantity, price
FROM Sales
GROUP BY product_id

-- Yes, it will get the data from minimum year. But only from one row
-- This query will choose row arbitrarily with first year value
-- But we need the each row which is from first year

SELECT s.product_id, s.year AS first_year, s.quantity, s.price
FROM Sales AS s
WHERE s.year = (SELECT MIN(year) FROM Sales WHERE product_id = s.product_id);

-- It's correct ans but it will get tle



-- Correct Solution

SELECT s.product_id, s.year as first_year, s.quantity, s.price
FROM Sales AS s
JOIN (
    SELECT product_id, MIN(year) as first_year
    FROM Sales
    GROUP BY product_id
) as f ON s.product_id = f.product_id AND s.year = f.first_year

-- This will create a table with product_id with corresponding minimum year
-- As it is grouped by product_id
-- Then join will create a table only with the product_id and rest of the data for minimum year



