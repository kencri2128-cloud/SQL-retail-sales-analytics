--=================================
--BUSINESS PERFORMANCE ANALYSIS
--=================================

--PARETO ANALYSIS (80/20)
--Which Customers Account for 80% of Sales?

WITH customer_sales AS(
     SELECT
	       customer_name,
		   SUM(sales) AS total_sales
	 FROM retail_sales_clean
	 GROUP BY customer_name
	 ),
	 pareto AS (
 SELECT 
      customer_name,
	  total_sales,
	  ROUND(SUM(total_sales) OVER (
               ORDER BY total_sales DESC
	  )
	  /SUM(total_sales) OVER () *100,
	  2
	  ) cumulative_pct
FROM customer_sales
)
SELECT *
FROM pareto
WHERE cumulative_pct <= 80
ORDER BY total_sales DESC;

--PROFIT MARGIN BY CATEGORY

SELECT
     category,
	 ROUND(SUM(sales),2) total_sales,
	 ROUND(SUM(profit),2) total_profit,
	 ROUND(
          SUM(profit)/
		  SUM(sales)*100,
		  2
	 ) profit_margin_pct
	 FROM retail_sales_clean
	 GROUP BY category
	 ORDER BY profit_margin_pct DESC;


--TOP PRODUCTS BY REGION

WITH product_sales AS(
     SELECT 
	      region,
		  product_name,
		  SUM(sales)  total_sales
	 FROM retail_sales_clean
	 GROUP BY region, product_name
	 )
SELECT *
FROM (
   SELECT *,
     ROW_NUMBER() OVER(
         PARTITION BY region
		 ORDER BY total_sales DESC
	 ) rn
	 FROM product_sales
) t
WHERE rn<=5;



--REVENEW FROM NEW VS REPEAT CUSTOMERS


WITH customer_orders AS (
    SELECT
	    customer_name,
		COUNT (DISTINCT order_id) AS total_orders,
		SUM(sales) AS customer_sales
		FROM retail_sales_clean
		GROUP BY customer_name
		)

SELECT
    CASE
	   WHEN total_orders>1 then 'Repeat Customer' ELSE 'New Customer'
	 END AS customer_type,
	 ROUND(SUM(customer_sales),2) AS revenue,
	 ROUND(
           100.00 * SUM(customer_sales) /
		   SUM(SUM(customer_sales)) OVER(),2) AS revenue_pct
FROM customer_orders
GROUP BY customer_type;


--AVERAGE ORDER BY CUSTOMER

SELECT
     customer_name,
	 ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM retail_sales_clean
GROUP BY customer_name
ORDER BY avg_order_value DESC;

--CUSTOMER SEGMENTATION


WITH customer_sales AS(
    SELECT
	     customer_name,
		 SUM(sales) total_sales
	FROM retail_sales_clean
	GROUP BY customer_name
)
SELECT
    customer_name,
	total_sales,
	CASE
	   WHEN total_sales>=10000 THEN 'VIP'
	   WHEN total_sales>= 5000 THEN 'Premium'
	   ELSE 'Standard'
	 END customer_segment
FROM customer_sales
ORDER BY total_sales DESC;


--REVENUE BY REGION

SELECT
    region,
	ROUND(SUM(sales),2) total_sales,
	ROUND(SUM(profit),2) total_profit,
	ROUND(
          SUM(profit)/
		  SUM(sales) * 100,
		  2) margin_pct
FROM retail_sales_clean
GROUP BY region
ORDER BY margin_pct DESC;

--MOVING AVERAGE

WITH monthly_sales AS (
SELECT
     DATE_TRUNC('month',order_date) AS month_date,
	 SUM(sales) total_sales
FROM retail_sales_clean
GROUP BY 1	 
)
SELECT
     month_date,
	 total_sales,
	 ROUND(
         AVG(total_sales) OVER(
		 ORDER BY month_date
		 ROWS BETWEEN 2 PRECEDING
		 AND CURRENT ROW

		 ),2) moving_avg_3m
FROM monthly_sales;

--PRODUCTS WITH MORE REVENUE AND SALES

SELECT
     product_name, 
	 ROUND(SUM(sales),2) total_sales,
	 ROUND (SUM(profit),2) total_profit,
	 RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank,
	 RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM retail_sales_clean
GROUP BY product_name;

--YEAR OVER YEAR GROWTH BY CATEGORY

WITH yearly_sales AS (
SELECT
     EXTRACT(YEAR FROM order_date) year_date,
	 category,
	 SUM(sales) total_sales
FROM retail_sales_clean
GROUP BY 1,2
)
SELECT
     year_date,
	 category,
	 total_sales,
	 LAG(total_sales) OVER(
         PARTITION BY category
		 ORDER BY year_date) previous_year,
		 ROUND(
		    (total_sales-LAG(total_sales)OVER(
                 PARTITION BY category
				 ORDER BY year_date
			)
   )/
   LAG(total_sales) OVER(
       PARTITION BY category
	   ORDER BY year_date
   ) * 100, 2) growth_pct
   FROM yearly_sales;