-- =================================================================
-- ------------------- SUPER STORE SALES ANALYSIS ------------------
-- =================================================================

-- -----------------------------------------------------------------
-- 1. OVERALL DATASET & SUMMARY AGGREGATIONS
-- -----------------------------------------------------------------

-- View the raw data
select * from store_sales;

-- High-level business totals
select count(*) as Total_Records from store_sales;
select sum(sales) as Total_Revenue from store_sales;
select Avg(sales) as Average_Transaction_Value from store_sales;


-- -----------------------------------------------------------------
-- 2. TIME-BASED TRENDS (WHEN)
-- -----------------------------------------------------------------

-- Monthly performance summary
select Month_number, Month, round(sum(sales)) as Total_Sales 
from store_sales
group by Month_number, Month
order by Month_number;

-- Yearly performance summary
select Year, round(sum(sales)) as Total_Sales 
from store_sales
group by Year
order by Year;


-- -----------------------------------------------------------------
-- 3. PRODUCT & CATEGORY HIERARCHY (WHAT)
-- -----------------------------------------------------------------

-- Product Depth: Number of unique Sub_Categories per Category
select Category, count(distinct Sub_Category) as Sub_Cat_Count
from store_sales
group by Category
order by Sub_Cat_Count desc;

-- Revenue Contribution: Identifying "breadwinner" Sub_Categories
select Category, Sub_Category, round(sum(Sales)) as Total_Sales
from store_sales
group by Category, Sub_Category
order by Category, Total_Sales desc;

-- Regional Product Analysis: Best-selling Sub_Categories per Region
select Region, Sub_Category, round(sum(Sales)) as Sub_Cat_Revenue 
from store_sales
group by Region, Sub_Category
order by Region, Sub_Cat_Revenue desc;


-- -----------------------------------------------------------------
-- 4. GEOGRAPHY & CUSTOMER CONCENTRATION (WHERE & WHO)
-- -----------------------------------------------------------------

-- State-Wise Breakdown: Highest performing states
select State, round(sum(Sales)) as Total_State_Sales 
from store_sales
group by State
order by Total_State_Sales desc;

-- City-Wise Performance: Top 10 cities by revenue
select City, State, round(sum(Sales)) as City_Sales 
from store_sales
group by City, State
order by City_Sales desc
limit 10;

-- Customer Concentration: Cities with the most unique customers
select City, count(distinct Customer_ID) as Unique_Customers 
from store_sales
group by City
order by Unique_Customers desc
limit 10;

-- Zip Code Analysis: Top 5 postal codes by sales volume
select Postal_Code, City, round(sum(Sales)) as Zip_Sales 
from store_sales
group by Postal_Code, City
order by Zip_Sales desc
limit 5;


-- -----------------------------------------------------------------
-- 5. LOGISTICS & SEGMENTATION (HOW)
-- -----------------------------------------------------------------

-- Segment Order Count: Volume per customer type
select Segment, count(`Order ID`) as Total_Orders 
from store_sales
group by Segment;

-- Shipping Popularity: Most frequently used shipping methods
select Ship_Mode, count(Order_ID) as Total_Orders 
from store_sales
group by Ship_Mode
order by Total_Orders desc;

-- Shipping Efficiency: Average sales value per shipping mode
select Ship_Mode, round(avg(Sales), 2) as Avg_Order_Value 
from store_sales
group by Ship_Mode
order by Avg_Order_Value desc;