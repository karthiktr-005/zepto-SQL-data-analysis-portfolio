create schema zepto_data_analysis;

drop table if exists zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(200),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8 , 2 ),
    discountpercent NUMERIC(5 , 2 ),
    availableQuantity INT,
    discountedSellingPrice NUMERIC(8 , 2 ),
    weightInGms INT,
    outOfStock VARCHAR(10),
    quantity INT
);

-- Data Exploration-- 

SELECT 
    COUNT(sku_id)
FROM
    zepto;


SELECT 
    *
FROM
    zepto
LIMIT 10;

SELECT 
    *
FROM
    zepto
WHERE
    category IS NULL OR name IS NULL
        OR mrp IS NULL
        OR discountpercent IS NULL
        OR availableQuantity IS NULL
        OR discountedSellingPrice IS NULL
        OR weightInGms IS NULL
        OR outOfStock IS NULL
        OR quantity IS NULL;
        
        
SELECT 
    category, name
FROM
    zepto;
    
    
SELECT 
    *
FROM
    zepto;

 SELECT DISTINCT
    (name)
FROM
    zepto;


-- Data cleaning

SELECT 
    *
FROM
    zepto
WHERE
    mrp = 0;

DELETE FROM zepto 
WHERE
    sku_id = 3603;
    

UPDATE zepto 
SET 
    mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT 
    mrp, discountedsellingprice
FROM
    zepto;


-- Q1. find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT
    name, mrp, discountpercent
FROM
    zepto
ORDER BY discountpercent DESC
LIMIT 10;

-- Q2. what are the products with high mrp but out of stock.

SELECT DISTINCT
    name, mrp
FROM
    zepto
WHERE
    outOfStock = 'True' AND mrp > 300
ORDER BY mrp DESC;

-- Q3. calculate Estimated revenue for each category.

SELECT 
    category,
    SUM(discountpercent * availablequantity) AS Total_revenue
FROM
    zepto
GROUP BY category
ORDER BY Total_revenue;

-- Q4. find all products where mrp is greater than rs.500 and discount is less than 10%.

SELECT 
    name, mrp, discountpercent
FROM
    zepto
WHERE
    mrp > 500 AND discountpercent < 10
ORDER BY discountpercent DESC , mrp DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT 
    category,
    ROUND(AVG(discountpercent), 2) AS High_Avg_Percentage
FROM
    zepto
GROUP BY category
ORDER BY High_Avg_Percentage DESC
LIMIT 5;

-- Q6. find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT
    name,
    weightingms,
    discountedsellingprice,
    ROUND(discountedsellingprice / weightingms, 2) AS Price_per_gram
FROM
    zepto
WHERE
    weightingms >= 100
ORDER BY price_per_gram;

-- Q7. Group the products into categories like low,medium,bulk. 

SELECT DISTINCT
    name,
    weightingms,
    CASE
        WHEN weightingms < 1000 THEN 'Low'
        WHEN weightingms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM
    zepto;
    
-- Q8. what is the total inventory weight per category.

SELECT 
    category,
    SUM(weightingms * availablequantity) AS Total_Weight
FROM
    zepto
GROUP BY category
ORDER BY Total_Weight;

