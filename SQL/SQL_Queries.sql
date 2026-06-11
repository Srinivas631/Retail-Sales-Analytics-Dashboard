# 1.Top 10 Products by Profit
select Product_Name,round(sum(profit),2) as Total_Profit from amazon_orders_clean
group by Product_Name
order by Total_Profit desc
limit 10;

# 2.Profit by State
select	trim(substring_index(geography, ',',-1)) as State ,
		round(sum(profit),2) as Total_Profit from amazon_orders_clean
group by State
order by Total_Profit desc;

# 3. Monthly Sales Trend
select date_format(order_date,'%Y-%m') as Month,round(sum(Sales),2) as Total_Sales from amazon_orders_clean
group by Month 
order by Month;

# 4.Top 10 Customers 
select EmailID,round(sum(Sales),2) as Total_Sales from amazon_orders_clean
group by EmailID
order by Total_Sales desc
limit 10;

#5.Shipping Performance
select Shipping_Days,count(*) as Total_Orders from amazon_orders_clean
group by Shipping_Days
order by Shipping_Days;


# 6.Profit vs Shipping Time
select Shipping_Days,round(sum(profit),2) as Total_Profit from amazon_orders_clean
group by Shipping_Days
order by Shipping_Days;

# 7.Category-wise Profit Margin
select	Category,
		round(sum(sales),2) as Sales,
		round(sum(profit),2) as Profit,
        round((sum(profit)/sum(sales))*100,2) as  Profit_Margin
        from amazon_orders_clean
group by Category
order by Profit_Margin desc;

# 8.Most Profitable Customers
select EmailID,round(sum(profit),2) as Profit from amazon_orders_clean
group by EmailID
order by Profit desc
limit 10;

# 9.Repeat Customers
select EmailId ,count(distinct Order_ID) as Orders_Count from amazon_orders_clean
group by EmailID
having  count(distinct Order_ID) > 1 
order by Orders_Count desc;


# 10.Sales vs Profit by State
select	trim(substring_index(geography, ',',-1)) as State,
		round(sum(sales),2) as Sales,
		round(sum(profit),2) as Profit from amazon_orders_clean
group by State 
order by sales desc;

# 11.Rank Products by Profit
WITH product_profit AS
(
    SELECT Product_Name,
           ROUND(SUM(profit),2) AS Total_Profit
    FROM amazon_orders_clean
    GROUP BY Product_Name
)
SELECT *,
       RANK() OVER(ORDER BY Total_Profit DESC) AS Product_Rank
FROM product_profit;

# 12.Revenue Contribution %
select	Category,round(sum(sales),2)as Revenue,
		round(sum(sales) *100/(select sum(sales) from amazon_orders_clean),2) as Revenue_Percentage
from amazon_orders_clean
group by Category
order by Revenue desc;