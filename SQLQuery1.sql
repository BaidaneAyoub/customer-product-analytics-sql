/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages,gender and transaction details.
	2. Segments customers into categories (VIP, Regular, New) .
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
		- average order value
		- average monthly spend
===============================================================================
*/
-- =============================================================================
CREATE VIEW gold.report_customers AS
WITH base_query AS (
    SELECT
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales_amount,
        f.quantity,
        c.customer_key,
        c.customer_number,
        c.marital_status,
        c.gender,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(year, c.birthdate, GETDATE()) AS age
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON c.customer_key = f.customer_key
    WHERE f.order_date IS NOT NULL
),
customer_aggregation AS (
    SELECT
        customer_key,
        customer_name,
        age,
        gender,
        marital_status,
        customer_number,
        SUM(quantity) AS total_quantity,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT order_number) AS total_orders,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM base_query 
    GROUP BY 
        customer_key,
        customer_number,
        customer_name,
        age,
        gender,
        marital_status
)
SELECT 
    customer_key,
    gender,
    marital_status,
    customer_number,
    customer_name,
    age,
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    total_orders,
    total_sales,
    total_quantity,
    lifespan,
    -- Compute average order value (AOV)
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    -- Compute average monthly spend
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend
FROM customer_aggregation
;
