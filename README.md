# 📊 Olist E-commerce Sales Analytics

End-to-end **SQL + Tableau** analytics project based on the **Brazilian Olist E-commerce Dataset**.

The project transforms raw transactional data into business insights through SQL analysis and interactive Tableau dashboards, helping stakeholders understand sales performance, product trends, customer behavior, and regional differences.

---

![Dashboard Preview](images/preview.png)

---

# 📌 Project Overview

This project explores one of Brazil's largest public e-commerce datasets to answer real business questions about sales performance.

The workflow includes:

- Data quality validation
- Business analysis using SQL
- KPI calculation
- Interactive dashboard development in Tableau
- Data storytelling through visualizations

---

# 🎯 Business Questions

The analysis answers the following business questions:

### Sales Performance

- How has revenue changed over time?
- How many completed orders are processed each month?
- Which states generate the highest revenue?

### Product Analysis

- Which product categories generate the highest revenue?
- Which product categories have the highest Average Selling Price (ASP)?

### Customer & Payments

- Which payment methods are most frequently used?
- Which sellers generate the highest revenue?

---

# 🛠 Tech Stack

| Tool | Purpose |
|-------|---------|
| SQL | Data validation & business analysis |
| Tableau | Dashboard development |
| Git & GitHub | Version control |
| CSV | Source dataset |

---

# 🗂 SQL Analysis

The project contains two SQL scripts covering the complete analytical workflow.

## 📄 01_data_quality.sql

Performs initial dataset validation before analysis.

### Includes

- Missing value checks
- Duplicate detection
- Basic data exploration
- Dataset validation
- Table overview

---

## 📄 02_sales_analysis.sql

Business analysis queries used to build the Tableau dashboards.

### Includes

- Total Revenue
- Completed Orders
- Monthly Revenue Trend
- Revenue by State
- Top Product Categories
- Average Selling Price (ASP)
- Payment Method Distribution
- Top Sellers by Revenue
- Average Delivery Time

---

# 💻 SQL Skills Demonstrated

- INNER JOIN
- LEFT JOIN
- GROUP BY
- ORDER BY
- Aggregate Functions
- SUM()
- AVG()
- COUNT()
- CASE WHEN
- Date Functions
- Business KPI Calculations

---

# 📈 Dashboard 1 — Executive Sales Overview

### Purpose

Provides a high-level overview of overall business performance.

### Includes

- 📈 Total Revenue KPI
- 📦 Completed Orders KPI
- 📅 Monthly Revenue Trend
- 📊 Monthly Completed Orders
- 🗺 Revenue by State

### Preview

![Executive Dashboard](images/executive_sales_overview.png)

---

# 📦 Dashboard 2 — Product Performance

### Purpose

Analyzes product performance and purchasing behavior.

### Includes

- 🏆 Top Product Categories by Revenue
- 💰 Average Selling Price (ASP)
- 💳 Completed Orders by Payment Method

### Preview

![Product Dashboard](images/product_performance.png)

---

# 💡 Key Business Insights

- Revenue experienced strong growth throughout **2017**, followed by stabilization in **2018**.
- **São Paulo (SP)** generated the highest revenue among all Brazilian states.
- **Health & Beauty** was the best-performing product category by revenue.
- **Computers** had the highest Average Selling Price (ASP).
- **Credit Card** accounted for the majority of completed orders.
- Sales are concentrated within a small number of high-performing categories.

---

# 📁 Repository Structure

olist-ecommerce-analysis/
│
├── data/
│   ├── customers.csv
│   ├── geolocation.csv
│   ├── order_items.csv
│   ├── order_payments.csv
│   ├── order_reviews.csv
│   ├── orders.csv
│   ├── product_category_name_translation.csv
│   ├── products.csv
│   └── sellers.csv
│
├── images/
│   ├── preview.png
│   ├── executive_sales_overview.png
│   └── product_performance.png
│
├── sql/
│   ├── 01_data_quality.sql
│   └── 02_sales_analysis.sql
│
├── tableau/
│   └── Olist-Ecommerce-Analytics.twb
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# 📊 Interactive Dashboard

Explore the interactive Tableau dashboards:

**👉 Tableau Public**

https://public.tableau.com/views/Olist-Ecommerce-Analytics/ProductPerformance?:language=en-US&:display_count=n&:origin=viz_share_link

---

# 📂 Dataset

**Brazilian E-Commerce Public Dataset by Olist**

Source:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

# 🚀 Skills Demonstrated

### SQL

- Data Cleaning
- Data Validation
- Business Analysis
- KPI Development
- Aggregations
- Multi-table JOINs

### Tableau

- Dashboard Design
- KPI Cards
- Geographic Analysis
- Time Series Analysis
- Interactive Filtering
- Business Storytelling

### Analytics

- Revenue Analysis
- Product Performance
- Sales Trends
- Regional Analysis
- Payment Behavior

---

# 👤 Author

**Oleksandr Rudenko**

📧 **Email**  
rudenko.alexandr93@gmail.com

💼 **LinkedIn**  
https://www.linkedin.com/in/da-rudenko-alexandr

🐙 **GitHub**  
https://github.com/rudenkoalexandr93-png