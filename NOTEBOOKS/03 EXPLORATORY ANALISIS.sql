--=============================
--EXPLORATORY ANALYSIS
--=============================

--TOTAL SALES

SELECT
ROUND(SUM(sales),2) total_sales
FROM retail_sales_clean;

--TOTAL_PROFIT

SELECT
ROUND(SUM(profit),2) total_profit
FROM retail_sales_clean;

--AVERAGE TICKET

SELECT
ROUND(AVG(sales),2) average_order
FROM retail_sales_clean;

--TOTAL SALES BY REGION

SELECT region, ROUND(SUM(sales),2) total_sales
FROM retail_sales_clean
GROUP BY region
ORDER BY total_sales DESC;

--SALES BY CATEGORY

SELECT category, ROUND(SUM (sales),2) total_sales
FROM retail_sales_clean
GROUP BY category
ORDER BY total_sales DESC;


--TOP 10 PRODUCTS

SELECT product_name, ROUND(SUM(profit),2) total_profit
FROM retail_sales_clean
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;


--PRODUCTS WITH LOSSES

SELECT product_name, ROUND(SUM(profit),2) total_profit
FROM retail_sales_clean
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;


--SALES BY MONTH

WITH monthly_sales AS (
SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) total_sales
FROM retail_sales_clean
GROUP BY 1
)
SELECT *
FROM monthly_sales
ORDER BY month;

--PERCENTAGE GROWTH

WITH monthly_sales AS (
SELECT
EXTRACT(YEAR FROM order_date) AS year,
EXTRACT (MONTH FROM order_date) AS month,
SUM (sales) AS total_sales
FROM retail_sales_clean
GROUP BY 1,2
)
SELECT 
year, 
month,
ROUND(total_sales::numeric,2) AS total_sales,
ROUND(LAG(total_sales,12)OVER (ORDER BY year, month)::numeric,2) AS previous_year_sales,
ROUND(
(
(total_sales-LAG(total_sales,12)OVER (ORDER BY year, month))
/
LAG(total_sales,12)OVER(ORDER BY year, month)
)::numeric*100,
2 
) AS grow_pct
FROM monthly_sales
ORDER BY year,month;


--RANKING DE CLIENTES

SELECT
customer_name, 
SUM(sales) total_sales,
RANK() OVER(ORDER BY SUM(sales) DESC) customer_rank
FROM retail_sales_clean
GROUP BY customer_name;

--TOP CLIENTE POR REGION

WITH customer_sales AS (
SELECT 
region,
customer_name,
SUM(sales) total_sales
FROM retail_sales_clean
GROUP BY region, customer_name
)
SELECT * 
FROM(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY region 
ORDER BY total_sales DESC
) rn
FROM customer_sales
) t
WHERE rn = 1;