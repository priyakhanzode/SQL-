create database Sales_and_Delivery;
use Sales_and_Delivery;




create table Cust_dimen(
Customer_name Varchar(50),
Province Varchar(40),
Region Varchar(40),
Customer_Segment Varchar(60),
Cust_id	Varchar(255) primary key);

create table Market_Fact(
Ord_id 	Varchar(255),
Prod_id	Varchar(255),
Ship_id	Varchar(255),
Cust_id	Varchar(255),
Sales Float,
Discount Float,
Order_Quantity Float,
Profit Float,
Shipping_cost Float,
Product_Base_Margin	Float);

create table Orders_Dimen(
Order_id integer,
Order_Date date,
Order_Priority	varchar(255),
Ord_id 	varchar(255) primary key);

create table Prod_Dimen(
Product_Category Varchar(60),
Product_Sub_category Varchar(80),
Prod_id	Varchar(255) primary key);

create table Shipping_Dimen(
Order_ID varchar(50),	
Ship_Mode varchar(60),	
Ship_Date varchar(70),
Ship_ID	Varchar(255) primary key);

#Question 1: Find the top 3 customers who have the maximum number of orders
select c.customer_name,m.Order_Quantity 
from Cust_dimen c join market_fact m
on c.cust_id=m.cust_id order by m.Order_Quantity desc limit 3;

#Question 2: Create a new column DaysTakenForDelivery that contains the date difference between 
#Order_Date and Ship_Date.
select (DATEDIFF(STR_TO_DATE(sd.Ship_Date , "%d-%m-%Y"),STR_TO_DATE(mf.Order_Date , "%d-%m-%Y"))) as DaysTakenForDelivery from   Orders_Dimen mf join Shipping_Dimen sd;

#Question 3: Find the customer whose order took the maximum time to get delivered.
select cd.Customer_Name,cd.Customer_Segment,mf.Order_Date,sd.Ship_Date,(DATEDIFF(STR_TO_DATE(sd.Ship_Date , "%d-%m-%Y"),STR_TO_DATE(mf.Order_Date , "%d-%m-%Y"))) as DaysTakenForDelivery from   Orders_Dimen mf join Shipping_Dimen sd join Cust_dimen cd 
group by cd.Customer_Name,cd.Customer_Segment,mf.Order_Date,sd.Ship_Date having max(DaysTakenForDelivery);

#Question 4: Retrieve total sales made by each product from the data (use Windows function)
select pd.prod_id ,pd.Product_Category,Product_Sub_Category,
round(sum(mf.sales) over(partition by pd.prod_id),2) as total_sales
from Prod_Dimen pd join Market_Fact mf
order by total_sales desc;

#Question 5: Retrieve the total profit made from each product from the data (use windows function)
select pd.prod_id ,pd.Product_Category,pd.Product_Sub_Category,
round(sum(mf.profit) over(partition by pd.prod_id),2) as total_profit
from Prod_Dimen pd join Market_Fact mf
order by total_profit desc;

#Question 6: Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
select distinct year(od.order_date) year ,month(od.order_date) month, count(mf.cust_id)
over(partition by month(od.order_date) order by month(od.order_date)) as unique_customers
from Orders_Dimen od join Market_Fact mf where year(od.order_date)=2011 and month(od.order_date)=1;

select customer_name,Order_Quantity from Cust_dimen c join market_fact m on c.cust_id=m.cust_id order by Order_Quantity 
 limit 3;

#write a query to obtain average of sale for Product_Category,Product_Sub_Category 
select * from Market_Fact;
select pd.Product_Category,pd.Product_Sub_category,avg(Sales)from Prod_Dimen pd 
join Market_Fact mf on pd.Prod_id=mf.Prod_id;
