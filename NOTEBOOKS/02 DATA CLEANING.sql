--===================================
--DATA CLEANING
--===================================

--RECORD COUNT

SELECT COUNT(*)
FROM retail_sales;


--QUICK VIEW

SELECT *
FROM retail_sales
LIMIT 10;

--FIND NULL VALUES

SELECT
COUNT(*) FILTER(WHERE sales IS NULL) sales_null,
COUNT(*) FILTER(WHERE profit IS NULL) profit_null,
COUNT(*) FILTER(WHERE discount IS NULL) discount_null

FROM retail_sales;

--FIND EMPTY VALUES

SELECT 
COUNT(*) FILTER (WHERE TRIM(sales)= '') sales_empty,
COUNT(*) FILTER (WHERE TRIM(profit)='') profit_empty,
COUNT(*) FILTER (WHERE TRIM(discount)='') discount_empty

FROM retail_sales;

--CREATE CLEAN TABLE

CREATE TABLE retail_sales_clean AS

SELECT

row_id :: INTEGER AS row_id,
order_id,
TO_DATE(order_date, 'MM/DD/YYYY') AS order_date,
TO_DATE(ship_date, 'MM/DD/YYYY') AS ship_date,
ship_mode,
customer_id,
customer_name,
segment,
country,
city,
state,
postal_code,
region,
product_id,
category,
sub_category,
product_name,
sales::NUMERIC(10,2) AS sales,
quantity::INTEGER AS quantity,
discount::NUMERIC(4,2) AS discount,
profit::NUMERIC(10,2) AS profit
FROM retail_sales;

--VALIDATE

SELECT *
FROM retail_sales_clean
LIMIT 10;

--VALIDATE STRUCTURE

SELECT
column_name,
data_type

FROM information_schema.columns

WHERE table_name= 'retail_sales_clean'

--DUPLICATES

SELECT 
order_id,
product_id,
COUNT(*)
FROM retail_sales_clean

GROUP BY 
order_id,
product_id
HAVING COUNT(*)>1;

--DUPLICATES INSPECTION

SELECT
order_id,
product_id,
sales,
quantity,
discount,
profit
FROM retail_sales_clean
WHERE (order_id, product_id) IN (

     SELECT 
          order_id,
          product_id
     FROM retail_sales_clean

     GROUP BY order_id, product_id
     HAVING COUNT(*)>1

)
ORDER BY order_id, product_id;


--BACK UP COPY

CREATE TABLE retail_sales_backup AS
SELECT *
FROM retail_sales_clean;

--ELIMINATE DUPLICATES

DELETE FROM retail_sales_clean
WHERE ctid NOT IN (
SELECT MIN(ctid)
FROM retail_sales_clean
GROUP BY
       order_id,
	   product_id,
	   sales,
	   quantity,
	   discount,
	   profit
	   
);

--CHECKING
SELECT 
order_id,
product_id,
COUNT(*)
FROM retail_sales_clean

GROUP BY 
order_id,
product_id
HAVING COUNT(*)>1;


SELECT COUNT(*)
FROM retail_sales_clean

