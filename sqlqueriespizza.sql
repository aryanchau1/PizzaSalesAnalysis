SELECT * FROM pizza_sales

/* A- KPI's */

/* Total Revenue*/
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

/* Average Order Value */
SELECT SUM(total_price) / COUNT(DISTINCT order_id) FROM pizza_sales;

/* Total Pizzas Sold */
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

/* Total Orders */
SELECT COUNT(DISTINCT order_id) as Total_Orders FROM pizza_sales;

/* Average Pizzas Per Order */
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2) )/ CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;

/* B- DAILY TREND FOR ORDERS */
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS orders from pizza_sales
GROUP BY DATENAME(DW, order_date)

/* C- MONTHLY TREND FOR ORDERS */
SELECT DATENAME(MONTH, order_date) AS order_day, COUNT(DISTINCT order_id) AS orders from pizza_sales
GROUP BY DATENAME(MONTH, order_date)

/* D- % OF SALES BY PIZZA CATEGORY */
SELECT  pizza_category, SUM(quantity) as Total_Quantity_Sold,
CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT FROM pizza_sales
GROUP BY pizza_category 

/* E- % OF SALES BY PIZZA SIZE */
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

/* F- TOP 5 PIZZAS BY REVENUE */
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

/* G- BOTTOM 5 PIZZAS BY REVENUE */
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

/* H- TOP 5 PIZZAS BY QUANTITY */
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

/* I- BOTTOM 5 PIZZAS BY QUANTITY */
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

/* J- TOP 5 PIZZAS BY TOTAL ORDER */
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

/* K- BOTTOM 5 PIZZAS BY TOTAL ORDER */
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;