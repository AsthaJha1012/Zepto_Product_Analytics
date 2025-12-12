# Zepto Product Analytics  
### End-to-End Data Cleaning, EDA & SQL Insights Using PostgreSQL

This project demonstrates a complete data analytics workflow using PostgreSQL.  
It covers data cleaning, exploratory data analysis (EDA), and solving real business questions through SQL.  

---

##Project Features

### 1. Data Cleaning
- Removed rows with zero MRP or invalid prices  
- Checked and handled null values  
- Identified duplicate product names  
- Converted **paise → rupees** for correct price calculations  

### 2. Exploratory Data Analysis (EDA)
- Count of in-stock vs out-of-stock products  
- Unique product categories  
- Duplicate SKUs  
- Price and quantity distributions  

### 3. Business Questions Answered
Using SQL, this project solves 8 real business queries:

1. Top 10 best-value products** based on discount percentage  
2. Products with high MRP but out of stock* 
3. Estimated revenue per category
4. Products with MRP > ₹500 and discount < 10%
5. Top 5 categories with highest average discount  
6. Price per gram for products above 100g  
7. Weight-based grouping into Low / Medium / Bulk
8. Total inventory weight per category

---

## Tools & Technologies
- postgreSQL
- pgAdmin 4
- Excel / CSV
- SQL (Data Cleaning + Analysis)

---

##  Dataset
The dataset contains product information including:
- Category  
- Name  
- MRP  
- Discount %  
- Selling price  
- Weight in grams  
- Stock availability  
- Quantity  

Uploaded and analyzed via PostgreSQL.

---

## SQL Workflow Summary

###  Table Creation  
Defined product schema with fields for price, weight, stock, and discount.

###  Data Cleaning  
```sql
DELETE FROM zepto WHERE mrp = 0;

UPDATE zepto
SET mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;


