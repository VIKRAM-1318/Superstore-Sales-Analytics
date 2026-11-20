# 📊 Superstore Sales Analytics — Dataset Guide & Architecture

## 1. Dataset Overview
This project is built upon the classic **Sample - Superstore Retail Dataset**, widely regarded as the industry standard benchmark dataset for commercial business intelligence and executive sales dashboarding.

* **Source:** [Tableau Public - Sample Superstore](https://community.tableau.com/s/question/0D54T00000CWeX8SAL/sample-superstore-sales-excelxls)
* **Kaggle Mirror:** [Kaggle - Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
* **Row Count:** 9,994 transaction rows.
* **Columns:** 21 attributes spanning orders, customers, geography, and products.
* **Time Horizon:** 4 Years (02/01/2014 – 30/12/2017).

---

## 2. Data Dictionary

| Column Name | Data Type | Analytical Role | Description |
|:---|:---:|:---:|:---|
| `Row ID` | Integer | Metadata | Unique sequence row index |
| `Order ID` | String | Dimension | Unique purchase transaction code (e.g. `CA-2016-152156`) |
| `Order Date` | Date | Dimension | Calendar date when customer placed order |
| `Ship Date` | Date | Dimension | Calendar date when goods were dispatched |
| `Ship Mode` | String | Dimension | Fulfillment class: `Standard Class`, `Second Class`, `First Class`, `Same Day` |
| `Customer ID` | String | Dimension | Unique customer code (e.g. `CG-12520`) |
| `Customer Name`| String | Dimension | Name of individual purchaser |
| `Segment` | String | Dimension | Target market: `Consumer`, `Corporate`, `Home Office` |
| `Country` | String | Dimension | Country of transaction (`United States`) |
| `City` | String | Dimension | US municipal city name |
| `State` | String | Dimension | US state name |
| `Postal Code` | String | Dimension | 5-digit US ZIP code |
| `Region` | String | Dimension | Macro territory: `West`, `East`, `Central`, `South` |
| `Product ID` | String | Dimension | SKU code (e.g. `FUR-BO-10001798`) |
| `Category` | String | Dimension | High-level division: `Technology`, `Furniture`, `Office Supplies` |
| `Sub-Category` | String | Dimension | Granular division: `Chairs`, `Tables`, `Binders`, `Phones`, etc. |
| `Product Name` | String | Dimension | Full commercial item description |
| `Sales` | Decimal | Fact | Transaction gross revenue in USD ($) |
| `Quantity` | Integer | Fact | Units purchased in order line |
| `Discount` | Decimal | Fact | Ratio of price reduction (0.00 to 0.80) |
| `Profit` | Decimal | Fact | Net contribution profit in USD ($) |

---

## 3. Data Integration in Power BI
The dataset is loaded directly into [Superstore_Sales_Dashboard.pbix](Superstore_Sales_Dashboard.pbix) and modeled with calculated measures in the `_Measures (2)` measure group.
