use pizza_db;

SELECT * FROM pizza_db.pizza_sales;

-- Total revenue --

select sum(total_price) as Total_Revenue from pizza_sales;

-- Average Order Value -- 

select sum(total_price) / count(distinct order_id) as Avg_order_value from pizza_sales;

-- Total Pizza sold --

select sum(quantity) as Total_Pizza_sold from pizza_sales;

-- Total orders --

select count(distinct order_id) as Total_orders from pizza_sales;

-- Average Pizzas Per Order --

select cast(cast(sum(quantity) as decimal (10,2)) / 
cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2))
as Avg_pizzas_per_order from pizza_sales;

-- Daily trend for orders -- 

SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%W') AS day_name, 
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
group by DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%W')
order by total_orders desc;

-- Monthly trend orders --

SELECT MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name, 
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
Group by MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
order by total_orders desc;

-- percentage of sales by pizza category --

select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales)as PCT
from pizza_sales
group by pizza_category;

-- percentage of sales by pizza size --

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Top 5 best sellers by revenue, Total quality and Total orders --

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
limit 5;


-- Bottom 5 best sellers by revenue, Total quality and Total orders --

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
limit 5;

-- Top 5 pizzas by quantity --

SELECT pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity desc
limit 5;

-- Bottom 5 pizzas by quantity --

SELECT pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity Asc
limit 5;

-- Top 5 pizzas by total orders --

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5;

-- Bottom 5 pizzas by total orders --

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders Asc
limit 5;
