create database miniproject;
use miniproject;


select * from cust_dimen;
select * from market_fact;
select * from orders_dimen;
select * from prod_dimen;
select * from shipping_dimen;


##Part-1##

#Question 1: Find the top 3 customers who have the maximum number of orders

select Customer_Name, cust.cust_id , mf.cust_id,Order_Quantity
from cust_dimen cust
join market_fact mf
on cust.cust_id = mf.cust_id
order by Order_Quantity desc limit 3;





#Question 2: Create a new column DaysTakenForDelivery that contains the date difference between Order_Date and Ship_Date.

select (DATEDIFF(STR_TO_DATE(sd.Ship_Date , "%d-%m-%Y"),STR_TO_DATE(mf.Order_Date , "%d-%m-%Y"))) as DaysTakenForDelivery 
from   Orders_Dimen mf join Shipping_Dimen sd;





#Question 3: Find the customer whose order took the maximum time to get delivered.
select sd.order_id, max(sd.ship_date - od.order_date)
from shipping_dimen sd
join orders_dimen od 
on sd.order_id = od.order_id;



#Question 4: Retrieve total sales made by each product from the data (use Windows function)

select distinct pd.prod_id,
round(sum(mf.sales) over(partition by pd.prod_id ),2) as total_sales 
from Prod_Dimen pd join Market_Fact mf;



#Question 5: Retrieve the total profit made from each product from the data (use windows function)

select distinct pd.prod_id,
round(sum(mf.profit) over(partition by pd.prod_id ),2)  as total_profit 
from Prod_Dimen pd join Market_Fact mf;




#Question 6: Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011

select distinct year(od.order_date) year ,month(od.order_date) month, count(mf.cust_id)
over(partition by month(od.order_date) order by month(od.order_date)) as unique_customers
from Orders_Dimen od join Market_Fact mf where year(od.order_date)=2011 and month(od.order_date)=1;