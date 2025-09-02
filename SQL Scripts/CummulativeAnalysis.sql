-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_year,
	yearly_total_sales,
	SUM(yearly_total_sales) OVER (ORDER BY order_year) AS running_total_sales,
	AVG(yearly_avg_price) OVER (ORDER BY order_year) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_year,
        SUM(sales_amount) AS yearly_total_sales,
        AVG(price) AS yearly_avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) temp_data;