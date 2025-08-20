HEAD

# sql-customer-product-reports

=======

# Customer & Product Reports (SQL Views)

## Overview

This project contains **SQL Server views** to generate analytical reports for:

- **Customers**: segmentation, KPIs, and purchasing behavior.
- **Products**: performance metrics, segmentation, and sales insights.

---

## Reports

### 1. Customer Report (`SQLQuery1.sql`)

- Consolidates key customer information (age, gender, marital status).
- Segments customers into **VIP, Regular, New**.
- Calculates KPIs:
  - Total Orders
  - Total Sales
  - Total Products
  - Lifespan (in months)
  - Average Order Value
  - Average Monthly Spend

### 2. Product Report (`SQLQuery2.sql`)

- Gathers product details (name, category, subcategory, cost).
- Segments products into **High-Performer, Mid-Range, Low-Performer**.
- Calculates KPIs:
  - Total Orders
  - Total Sales
  - Total Customers
  - Recency (months since last sale)
  - Average Order Revenue (AOR)
  - Average Monthly Revenue
  - Average Selling Price

---

## Tech Stack

- **SQL Server (T-SQL)**
- Data model based on:
  - `fact_sales`
  - `dim_customers`
  - `dim_products`

---

## How to Use

1. Run the SQL scripts inside **SQL Server Management Studio (SSMS)**.
2. Make sure you already have the following tables:
   - `gold.fact_sales`
   - `gold.dim_customers`
   - `gold.dim_products`
3. The views will be created:
   - `gold.report_customers`
   - `gold.report_products`
4. Tables in 00_init_database.sql file Make sure to change the location of the files

---

## Example Use Cases

- Customer segmentation for marketing.
- Product performance analysis.
- Sales KPIs dashboard.

---

## Author

Created by **Ayoub Baidane**
