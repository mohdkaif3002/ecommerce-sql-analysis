# 🛒 E-Commerce SQL Analysis — Olist Brazil

## 📌 Project Overview
Analysis of 100,000+ real e-commerce orders from Olist, Brazil's largest 
department store marketplace. This project demonstrates SQL skills including 
joins, aggregations, CTEs, and window functions.

## 🗃️ Dataset
- **Source:** [Kaggle — Brazilian E-Commerce by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size:** 100K+ orders | 9 tables | 2016–2018

## 🛠️ Tools Used
- SQL (SQLite)
- DB Browser for SQLite
- Python (data loading)

## 📊 Key Findings

### Sales & Revenue
- Revenue grew **20x** from R$46K (Oct 2016) to R$1.1M+ (2018)
- **November 2017** was peak month — R$1.15M (Black Friday effect)
- Top categories: Bed & Bath, Health & Beauty, Computers & Accessories

### Customer Behaviour
- **96.88%** of customers are one-time buyers — retention challenge
- **São Paulo** dominates in volume (39K customers, R$5.77M)
- **Bahia** has highest revenue per customer at R$187

### Delivery & Operations
- Average actual delivery: **12.6 days** vs estimated **23.7 days**
- Olist delivers **11.2 days earlier** than promised on average
- Some sellers have late delivery rates exceeding **35%**

### Advanced Analysis
- Used **LAG()** window function for month-over-month growth
- Used **RANK() OVER PARTITION** to rank sellers within categories
- **Office Furniture** top seller generated R$468K alone

## 📁 Project Structure
```
ecommerce-sql-analysis/
├── data/                  # Raw CSV files
├── sql/
│   ├── 01_exploratory.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_delivery_analysis.sql
│   └── 05_advanced_analysis.sql
├── outputs/               # Key findings
└── README.md
```

## 🚀 How to Run
1. Download dataset from Kaggle
2. Run `load_data.py` to load CSVs into SQLite
3. Open `olist_ecommerce.db` in DB Browser for SQLite
4. Run queries from the `sql/` folder