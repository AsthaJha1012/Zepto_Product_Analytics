DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);

select count(*) from zepto;

select * from zepto 
limit 10;

--Data Exploration

--Null Values
select * from zepto 
where sku_id is null 
or
category is null
or
name is null
or
mrp is null
or
discountpercent is null
or
availablequantity is null
or
discountedsellingprice is null
or
weightingms is null
or
outofstock is null
or
quantity is null;

--different product categories
select distinct category 
from zepto 
order by category;

--product in stock vs out of stock
select outofstock, count(sku_id)
from zepto
group by outofstock;

--product name present multiple times 
select name,count(sku_id) as "Number of SKUs"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc;

--Data Cleaning

--product with price=0
select category,discountedsellingprice
from zepto 
where mrp=0 or discountedsellingprice=0;

delete from zepto 
where mrp=0;

--convert paise to rupees
update zepto 
set mrp=mrp/100.0,
discountedsellingprice=discountedsellingprice/100.0;

select mrp,discountedsellingprice from zepto;

-- Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name, mrp, discountpercent
from zepto 
order by discountpercent desc
limit 10;
-- Q2. What are the products with high MRP but out of stock?
select distinct name, mrp
from zepto
where outofstock='True' and mrp>300
order by mrp desc;
-- Q3. Calculate estimated revenue for each category.
select category,
sum(discountedsellingprice*availablequantity) as revenue
from zepto 
group by category 
order by revenue;
-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select * from zepto;
select distinct name,mrp,discountpercent
from zepto
where mrp>500 and discountpercent<10;
-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category,round(avg(discountpercent),2) as highest_avg_discpercent
from zepto
group by category
order by highest_avg_discpercent desc
limit 5;
-- Q6. Find the price per gram for products above 100g and sort by best value.
select distinct name, weightingms, discountedsellingprice,
round(discountedsellingprice/weightingms,2) as price_per_gram
from zepto
where weightingms>=100
order by price_per_gram;
-- Q7. Group the products into categories like Low, Medium, Bulk.
select distinct name,weightingms,
case when weightingms<1000 then 'low'
when weightingms<5000 then 'medium'
else 'bulk'
end as weight_category
from zepto;
-- Q8. What is the total inventory weight per category?
select category,
sum(weightingms * availablequantity) as total_weight
from zepto
group by category
order by total_weight;
