-- CREATE TABLE retail_sales
-- (
--     transactions_id INT PRIMARY KEY,
--     sale_date DATE,
--     sale_time TIME,
--     customer_id INT,
--     gender VARCHAR(15),
--     age INT,
--     category VARCHAR(15),
--     quantiy INT,
--     price_per_unit FLOAT,
--     cogs FLOAT,
--     total_sale FLOAT
-- );
-- SELECT * FROM retail_sales LIMIT 100; -- to see only 100 data
-- SELECT COUNT(*) FROM retail_sales; to count the number


-- To see if there are any null values

-- SELECT * FROM retail_sales
-- WHERE transactions_id IS NULL;

-- SELECT * FROM retail_sales
-- WHERE sale_date IS NULL;

-- SELECT * FROM retail_sales
-- WHERE sale_time IS NULL;

-- DATA CLEANING BY REMOVING NULL

-- SELECT * FROM retail_sales
-- WHERE
-- 	transactions_id IS NULL
--     OR
--     sale_date IS NULL
--     OR
--     sale_time IS NULL
--     OR
--     customer_id IS NULL
--     OR
--     gender IS NULL
--     OR
--     age IS NULL
--     OR
--     category IS NULL
--     OR
--     quantiy IS NULL
--     OR
--     price_per_unit IS NULL
--     OR
--     cogs IS NULL
--     OR
--     total_sale IS NULL;
--     
-- DELETE FROM retail_sales
-- WHERE
-- 	transactions_id IS NULL
--     OR
--     sale_date IS NULL
--     OR
--     sale_time IS NULL
--     OR
--     customer_id IS NULL
--     OR
--     gender IS NULL
--     OR
--     age IS NULL
--     OR
--     category IS NULL
--     OR
--     quantiy IS NULL
--     OR
--     price_per_unit IS NULL
--     OR
--     cogs IS NULL
--     OR
--     total_sale IS NULL;
-- SELECT * FROM retail_sales;

-- DATA EXPLORATION
-- TOTAL SALES

-- SELECT COUNT(*) as total_sale FROM retail_sales;

-- TOTAL UNIQUE CUSTOMER
-- SELECT COUNT(customer_id) as total_customers FROM retail_sales;

-- SELECT * FROM retail_sales WHERE customer_id>150;
-- SELECT * FROM retail_sales WHERE gender = 'Female' AND customer_id > 154;

-- SELECT COUNT(DISTINCT customer_id) as total_customer FROM retail_sales;
-- SELECT DISTINCT category FROM retail_sales;


-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND SOLUTIONS

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- ans 1
-- SELECT * 
-- FROM retail_sales 
-- WHERE sale_date = '2022-11-05';

-- ans 2
-- SELECT
-- 	* FROM retail_sales
--     WHERE 
--     category = 'Clothing'
--     AND 
--     DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
--     AND
--     quantiy >= 4;
   
-- ans 3
-- SELECT 
-- 	category,
--     SUM(total_sale) as net_sale,
--     COUNT(*) as total_orders
-- FROM retail_sales
-- GROUP BY 1

-- ans 4
-- SELECT 
-- 	ROUND(AVG(age),2) as avg_age
-- FROM retail_sales
-- WHERE category = 'beauty'

-- ans 5
-- SELECT * FROM retail_sales
-- WHERE total_sale > 1000;

-- ans 6
-- SELECT 
-- 	category,
--     gender,
--     COUNT(*) as total_trans
-- FROM retail_sales
-- GROUP BY
-- 	category,
--     gender
-- ORDER BY 1

-- ans 7
-- SELECT 
-- 	year,
-- 	month,
-- 	avg_sale 
-- FROM
-- (
	-- SELECT 
-- 		YEAR(sale_date) as year,
-- 		MONTH(sale_date) as month,
-- 		AVG(total_sale) as avg_sale,
-- 		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as rank_val
-- 	FROM retail_sales
-- 	GROUP BY 1, 2
-- ) as t1
-- WHERE rank_val = 1

-- ans 8
-- SELECT 
-- 	customer_id,
--     SUM(total_sale) as total_sales
-- FROM retail_sales
-- GROUP BY 1
-- ORDER BY 2 DESC
-- LIMIT 5

-- ans 9
-- SELECT
-- 	category,
--     COUNT(DISTINCT customer_id) as cnt_unique_cs
-- FROM retail_sales
-- GROUP BY category

-- ans 10
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
	END as shift
FROM retail_sales
)
SELECT 
	shift,
    COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

-- END OF PROJECT





    








	