# SQL-retail-sales-analytics
End-to-end SQL analytics project using PostgreSQL: data cleaning, EDA, customer segmentation, Pareto analysis, profitability, and sales trends.
####End-to-End Retail Sales Analytics Project using PostgreSQL

##Project Overview

This project demonstrates an end-to-end retail sales analysis workflow using PostgreSQL. The objective is to transform raw transactional data into meaningful business insights through data cleaning, exploratory data analysis (EDA), and advanced business analytics.

The analysis focuses on sales performance, profitability, customer behavior, product performance, regional trends, and revenue growth.

This project showcases SQL skills commonly used by Data Analysts, including data transformation, validation, aggregation, window functions, ranking, customer segmentation, and time-series analysis.


##Business Objectives

The project aims to answer key business questions such as:

* Which customers generate the majority of revenue?
* Which regions are the most profitable?
* Which product categories drive the highest profit margins?
* Which products generate losses despite producing sales?
* How much revenue comes from repeat customers?
* Who are the most valuable customers?
* How are sales evolving over time?


##Dataset

The dataset contains retail transaction records including:

* Orders
* Customers
* Products
* Categories
* Regions
* Sales
* Profit
* Discounts
* Order Dates
* Shipping Dates


##Project Workflow

1. Data Cleaning and Preparation

The raw dataset was inspected, validated, and transformed to ensure data quality before analysis.

Cleaning Tasks Performed

* Record count validation
* Data quality assessment
* Detection of NULL values
* Detection of empty values
* Duplicate identification and removal
* Data type conversion
* Date formatting
* Creation of a clean working table
* Backup table creation

Key transformations:

* Sales → Numeric
* Profit → Numeric
* Discount → Numeric
* Quantity → Integer
* Order Date → Date
* Ship Date → Date

2. Exploratory Data Analysis (EDA)

The exploratory phase focused on understanding overall business performance.

Sales Performance

* Total Sales
* Total Profit
* Average Order Value (AOV)
* Sales by Region
* Sales by Category

Product Analysis

* Top 10 Products by Revenue
* Top 10 Products by Profit
* Loss-Making Products

Customer Analysis

* Customer Revenue Ranking
* Top Customers by Region

Time Series Analysis

* Monthly Sales Trends
* Year-over-Year (YoY) Growth Analysis



3. Advanced Business Analysis

The business analysis section focuses on identifying growth opportunities and profitability drivers.

Customer Insights

Pareto Analysis (80/20 Rule)

Identified the customers responsible for approximately 80% of total revenue.

Revenue from New vs Repeat Customers

Measured the contribution of repeat customers to total revenue.

Average Order Value by Customer

Calculated spending patterns across customers.

Customer Segmentation

Customers were segmented into:

* VIP Customers
* Premium Customers
* Standard Customers

based on their total sales contribution.



Product Insights

* Best-Selling Products by Region
* Product Revenue Ranking
* Product Profit Ranking
* Product Performance Comparison



Profitability Analysis

* Profit Margin by Category
* Revenue by Region
* Profit by Region
* Regional Performance Comparison



Trend Analysis

Moving Average Analysis

Calculated a 3-Month Moving Average to smooth short-term fluctuations and identify long-term trends.

Growth Analysis

Performed Year-over-Year Growth calculations to evaluate business performance over time.



SQL Concepts Demonstrated

This project demonstrates practical use of:

* Data Cleaning
* Data Validation
* Data Transformation
* Aggregate Functions
* Common Table Expressions (CTEs)
* Window Functions
* Ranking Functions
* Running Totals
* Moving Averages
* Date Functions
* Customer Segmentation
* Pareto Analysis
* Growth Analysis

Key Insights

Examples of business insights generated from this analysis:

* Identified the customers responsible for the majority of revenue.
* Determined the most profitable regions.
* Detected products generating losses despite producing sales.
* Measured the contribution of repeat customers.
* Evaluated profit margins across categories.
* Analyzed sales growth trends over time.
* Ranked customers and products based on performance metrics.



Skills Demonstrated

Technical Skills

* PostgreSQL
* SQL
* Data Cleaning
* Data Transformation
* Exploratory Data Analysis
* Business Analysis
* Window Functions
* CTEs
* Ranking Functions
* Time Series Analysis

Business Skills

* Customer Analytics
* Revenue Analysis
* Profitability Analysis
* Product Performance Analysis
* Trend Analysis
* Business Reporting



Tools Used

* PostgreSQL
* SQL
* Git
* GitHub


Project Outcomes

This project demonstrates how SQL can be used beyond basic querying to support business decision-making through customer analysis, profitability evaluation, product performance assessment, and revenue growth analysis.

The workflow follows a real-world analytics process, starting from raw data preparation and ending with actionable business insights.


Author

Kenia Yadira Lazo Lemus

Junior Data Analyst

SQL | PostgreSQL | Python | Power BI
