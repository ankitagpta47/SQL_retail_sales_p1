# sql retail sale analysis
CREATE DATABASE project1;
USE project1;

CREATE TABLE retail_sales (
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time	TIME,
    customer_id INT,
	gender VARCHAR(15),
	age	INT,
    category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale float
)



SElECT*
from retail_sales;

select count(*)
from retail_sales;


select * 
from retail_sales
where 
transactions_id is null
or
	sale_date is null
    or
	sale_time	is null
    or
    customer_id is null
    or
	gender is null
    or
	age	is null
    or
    category is null
    or
	quantiy is null
    or
	price_per_unit is null
    or
	cogs is null
    or
	total_sale is null;

# data exploration

#how many sales we have?

select count(*)as total_sales
from retail_sales;

#how many unique cutomer  we have?

SELECT   count(distinct customer_id)
from retail_sales;


-- display all the categories

SELECT distinct category 
From retail_sales;

-- data analysis and business key problem.

-- 1. write a SQL query to retrive all the columns for sales made on 2022-01-15.


SELECT *
FROM retail_sales
WHERE sale_date = '2022-01-15';

-- write a single query to retrive all transaction where the category is clothing and the quantity sold is more than 4 in the month og nov- 2022


SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy >= 4;

-- Write the SQL query to calculate the total sales for each cateory.

SELECT  category, sum( total_sale) as net_sale
from retail_sales
group by category;

-- write a SQL query to find the avg age of customers who purchased item from the beauty category.

SELECT round (avg (age),2),category
from retail_sales
group by category
having category = 'Beauty';

-- write a SQL query to find all transactions where the total sale is greater then 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- write a SQL query to find the total number of transaction made by ecah gender in each category.

SELECT category, gender, count(transactions_id)
FROM retail_sales
group by category, gender
order by category, gender;


-- write a SQL query to calculate the avg sale of each month. find out best selling month in each year.

SELECT 
    year,
    month,
    avg_monthly_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_monthly_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) ranked
WHERE rnk = 1;


-- write a SQL query to find the top 5 customers based on the highest total_sale.

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Write a Sql query to find the number of unique customers who purchased items from each category. 

SELECT count( distinct customer_id), category
FROM retail_sales
group by category;


-- Write a Sql query to craete each swift and number of order.

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_order
FROM retail_sales
GROUP BY shift
ORDER BY total_order DESC;

-- End of project;
