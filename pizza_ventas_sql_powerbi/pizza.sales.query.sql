-- Visualizar todos los datos de la tabla principal
SELECT * 
FROM pizza_sales;


-- Cálculo del ingreso total generado por todas las ventas
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;


-- Valor promedio por pedido (ingreso total dividido entre cantidad de pedidos únicos)
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM pizza_sales;


-- Total de pizzas vendidas (suma de la columna 'quantity')
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales;


-- Total de pedidos únicos realizados
SELECT COUNT(DISTINCT order_id) AS order_count
FROM pizza_sales;


-- Promedio de pizzas por pedido
SELECT ROUND(CAST(SUM(quantity) AS FLOAT) / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;


-- Tendencia diaria de pedidos (cuántos pedidos se hacen cada día de la semana)
SELECT DATENAME(WEEKDAY, order_date) AS day_name, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date);


-- Tendencia mensual de pedidos (cantidad de pedidos por nombre del mes)
SELECT DATENAME(MONTH, order_date) AS month_name, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC;


-- Porcentaje de ventas por categoría de pizza
SELECT pizza_category, 
       SUM(total_price) AS total_sales,
       ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS pct_category
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pct_category DESC;


-- Porcentaje de ventas por tamaño de pizza
WITH pct_size AS (
    SELECT pizza_size, 
           SUM(total_price) AS total
    FROM pizza_sales
    GROUP BY pizza_size
)
SELECT *, 
       ROUND(total * 100.0 / SUM(total) OVER (), 2) AS pct_size
FROM pct_size;


-- Top 5 pizzas más vendidas por ingresos generados
SELECT TOP 5 pizza_name, 
             SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;


-- Top 5 pizzas más vendidas por cantidad de unidades vendidas
SELECT TOP 5 pizza_name, 
             SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC;


-- Top 5 pizzas más vendidas por cantidad de pedidos únicos
SELECT TOP 5 pizza_name, 
             COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;
