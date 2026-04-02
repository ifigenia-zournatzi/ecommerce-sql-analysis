-- ==============================================================
-- E-COMMERCE PROFITABILITY & DISCOUNT STRATEGY PROJECT
-- ==============================================================

-- ==============================================================
-- 0. Data Exploration & Quality Checks
-- ==============================================================

-- 0.1 Check if all data is imported correctly
SELECT COUNT(*) AS total_rows 
FROM SampleSuperstore;

-- 0.2 Find all unique product categories available
SELECT DISTINCT Category 
FROM SampleSuperstore;

-- 0.3 Find all unique shipping modes
SELECT DISTINCT "Ship Mode" 
FROM SampleSuperstore;


-- ==============================================================
-- Business Questions & Strategic Insights
-- ==============================================================

-- 1. What is the overall Profitability and Sales volume by Category?
SELECT 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM SampleSuperstore
GROUP BY Category
ORDER BY Total_Profit DESC;

-- 2. Identify the top 5 "Bleeding" Sub-Categories (Biggest Losses)
SELECT 
    "Sub-Category", 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM SampleSuperstore
GROUP BY "Sub-Category"
ORDER BY Total_Profit ASC
LIMIT 5;

-- 3. How do Discounts impact the Average Profit per order?
SELECT 
    Discount, 
    COUNT(*) AS Total_Orders, 
    AVG(Profit) AS Average_Profit 
FROM SampleSuperstore 
GROUP BY Discount 
ORDER BY Discount ASC;

-- 4. Which are the top 5 Cities with the highest number of transactions?
SELECT 
    City, 
    COUNT(*) AS total_transactions
FROM SampleSuperstore
GROUP BY City
ORDER BY total_transactions DESC
LIMIT 5;

-- 5. Identify the "VIP" Regions (States with over $50,000 in Sales)
WITH State_Totals AS (
    SELECT 
        State, 
        SUM(Sales) AS Total_Spent,
        SUM(Profit) AS Total_Profit
    FROM SampleSuperstore
    GROUP BY State
)
SELECT 
    State, 
    Total_Spent, 
    Total_Profit
FROM State_Totals
WHERE Total_Spent > 50000
ORDER BY Total_Spent DESC;

-- 6. Categorize the company's Discount Strategy and its overall impact on Profit
SELECT 
    CASE 
        WHEN Discount >= 0.3 THEN 'High Discount (30%+)'
        WHEN Discount > 0 THEN 'Low Discount (1-29%)'
        ELSE 'No Discount'
    END AS Discount_Strategy,
    COUNT(*) AS Total_Transactions,
    SUM(Profit) AS Total_Profit
FROM SampleSuperstore
GROUP BY Discount_Strategy
ORDER BY Total_Profit DESC;