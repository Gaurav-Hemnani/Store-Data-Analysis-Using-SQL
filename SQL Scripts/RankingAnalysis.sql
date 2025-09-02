-- Which 5 products Generating the Highest Revenue?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p 
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Which 5 products Generating the Highest Revenue Using RANK() Function?
SELECT *
FROM (
    SELECT 
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS products_rank
    FROM gold.fact_sales f 
    LEFT JOIN gold.dim_products p 
        ON f.product_key = p.product_key
    GROUP BY p.product_name 
) AS ranked_products
WHERE products_rank <= 5;

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p 
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders;