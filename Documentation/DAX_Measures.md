# 📊 Superstore Sales Analytics — DAX Measures Reference Guide

This document catalogs the verified DAX calculations used in the **Superstore Sales Dashboard** (`Superstore_Sales_Dashboard.pbix`).

---

## 📐 Measure Catalog

### 1. Total Sales
* **DAX Formula:**
  ```dax
  Total Sales = SUM('Sample - Superstore'[Sales])
  ```
* **Business Definition:** Cumulative gross retail sales revenue generated across all shipped orders.
* **Calculation Logic:** Sum of the `Sales` column in the primary Superstore table.
* **Interpretation:** Total revenue across the 4-year period (2014-2017) is **$2,297,201** (**$2.30M**).
* **Use Case:** Top-level executive scorecard, monthly revenue trends, and regional benchmarking.

---

### 2. Total Profit
* **DAX Formula:**
  ```dax
  Total Profit = SUM('Sample - Superstore'[Profit])
  ```
* **Business Definition:** Cumulative bottom-line net profit realized after cost of goods sold and applied discounts.
* **Calculation Logic:** Sum of `Profit` in the Superstore table.
* **Interpretation:** Cumulative platform net profit is **$286,397** (**$286.40K**).
* **Use Case:** Bottom-line health monitoring and margin erosion audits.

---

### 3. Profit Margin %
* **DAX Formula:**
  ```dax
  Profit Margin = DIVIDE([Total Profit], [Total Sales], 0)
  ```
* **Business Definition:** Percentage of gross sales converted into net operational profit.
* **Calculation Logic:** Total Profit divided by Total Sales with zero-division safety.
* **Interpretation:** Overall enterprise profit margin is **12.47%** (~12.5%).
* **Use Case:** Departmental profitability rankings, category pricing decisions, and discount guardrails.

---

### 4. Total Orders
* **DAX Formula:**
  ```dax
  Total Orders = DISTINCTCOUNT('Sample - Superstore'[Order ID])
  ```
* **Business Definition:** Count of unique customer order invoices processed.
* **Calculation Logic:** Distinct count of `Order ID`.
* **Interpretation:** Fulfillment volume comprises **5,009 distinct customer orders**.
* **Use Case:** Order fulfillment capacity, logistics planning, and customer order frequency.

---

### 5. Average Order Value (AOV)
* **DAX Formula:**
  ```dax
  Average Order Value = DIVIDE([Total Sales], [Total Orders], 0)
  ```
* **Business Definition:** Mean revenue generated per processed customer order.
* **Calculation Logic:** Total Sales divided by Total distinct Orders.
* **Interpretation:** Average customer transaction is **$458.55**.
* **Use Case:** B2B vs Consumer customer segmentation and basket building promotions.
