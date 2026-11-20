-- ==============================================================================
-- SUPERSTORE SALES ANALYTICS DATABASE QUERIES
-- Database Dialect: ANSI SQL / PostgreSQL / MySQL / SQL Server
-- Dataset: Sample - Superstore Retail Dataset (9,994 rows, 21 columns)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. TABLE DEFINITION (DDL)
-- ------------------------------------------------------------------------------

CREATE TABLE sample_superstore (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),                 -- 'Standard Class', 'Second Class', 'First Class', 'Same Day'
    customer_id VARCHAR(30),
    customer_name VARCHAR(150),
    segment VARCHAR(50),                   -- 'Consumer', 'Corporate', 'Home Office'
    country VARCHAR(50),                   -- 'United States'
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),                    -- 'West', 'East', 'Central', 'South'
    product_id VARCHAR(50),
    category VARCHAR(100),                 -- 'Technology', 'Furniture', 'Office Supplies'
    subcategory VARCHAR(100),              -- 'Chairs', 'Tables', 'Phones', 'Binders', etc.
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),                 -- e.g. 0.20 for 20%
    profit DECIMAL(10,2)
);

-- ------------------------------------------------------------------------------
-- 2. EXECUTIVE PERFORMANCE KPIS
-- ------------------------------------------------------------------------------

-- Total Sales, Total Profit, Overall Profit Margin %, Total Orders, Average Order Value
SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS overall_profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS average_order_value,
    ROUND(AVG(discount) * 100.0, 1) AS avg_discount_given_pct
FROM sample_superstore;

-- ------------------------------------------------------------------------------
-- 3. REGIONAL & GEOGRAPHIC PROFITABILITY
-- ------------------------------------------------------------------------------

-- Sales, Profit, and Margins by Region
SELECT 
    region,
    COUNT(DISTINCT order_id) AS orders_count,
    ROUND(SUM(sales), 2) AS region_sales,
    ROUND(SUM(profit), 2) AS region_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin_pct,
    ROUND(AVG(discount) * 100.0, 1) AS avg_discount_pct
FROM sample_superstore
GROUP BY region
ORDER BY region_profit DESC;

-- Top 10 States by Sales & Profitability
SELECT 
    state,
    region,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS state_sales,
    ROUND(SUM(profit), 2) AS state_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS state_margin_pct
FROM sample_superstore
GROUP BY state, region
ORDER BY state_sales DESC
LIMIT 10;

-- Bottom 5 Loss-Making States
SELECT 
    state,
    region,
    ROUND(SUM(sales), 2) AS state_sales,
    ROUND(SUM(profit), 2) AS net_loss,
    ROUND(AVG(discount) * 100.0, 1) AS avg_discount_pct
FROM sample_superstore
GROUP BY state, region
HAVING SUM(profit) < 0
ORDER BY net_loss ASC;

-- ------------------------------------------------------------------------------
-- 4. CATEGORY & SUBCATEGORY PROFITABILITY MATRIX
-- ------------------------------------------------------------------------------

-- Profitability Across Main Product Categories
SELECT 
    category,
    ROUND(SUM(sales), 2) AS category_sales,
    ROUND(SUM(profit), 2) AS category_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS category_margin_pct,
    SUM(quantity) AS units_sold
FROM sample_superstore
GROUP BY category
ORDER BY category_sales DESC;

-- Deep-Dive Subcategory Analysis (Identifying Loss Leaders & Margin Killers)
SELECT 
    category,
    subcategory,
    ROUND(SUM(sales), 2) AS subcategory_sales,
    ROUND(SUM(profit), 2) AS subcategory_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS subcategory_margin_pct,
    ROUND(AVG(discount) * 100.0, 1) AS avg_discount_pct,
    CASE 
        WHEN SUM(profit) < 0 THEN '🔴 Severe Margin Bleed'
        WHEN (SUM(profit) * 100.0 / SUM(sales)) < 10 THEN '🟡 Low Margin'
        ELSE '🟢 Healthy Margin'
    END AS profitability_health
FROM sample_superstore
GROUP BY category, subcategory
ORDER BY subcategory_profit ASC;

-- ------------------------------------------------------------------------------
-- 5. DISCOUNT SENSITIVITY & SHIPPING ANALYSIS
-- ------------------------------------------------------------------------------

-- Discount Level vs Profitability Correlation
SELECT 
    CASE 
        WHEN discount = 0 THEN '0% (No Discount)'
        WHEN discount <= 0.20 THEN '1% - 20% (Moderate)'
        WHEN discount <= 0.40 THEN '21% - 40% (Aggressive)'
        ELSE '> 40% (Deep Clearance)'
    END AS discount_bracket,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS net_profit,
    ROUND(SUM(profit) * 100.0 / NULLIF(SUM(sales), 0), 2) AS margin_pct
FROM sample_superstore
GROUP BY 
    CASE 
        WHEN discount = 0 THEN '0% (No Discount)'
        WHEN discount <= 0.20 THEN '1% - 20% (Moderate)'
        WHEN discount <= 0.40 THEN '21% - 40% (Aggressive)'
        ELSE '> 40% (Deep Clearance)'
    END
ORDER BY MIN(discount) ASC;

-- Shipping Mode Performance & Order Share
SELECT 
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(DATEDIFF(day, order_date, ship_date)), 1) AS avg_shipping_days
FROM sample_superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;
