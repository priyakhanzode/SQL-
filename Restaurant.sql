create database Restaurant;

use restaurant;





select * from chefmozaccepts;
select * from chefmozcuisine;
select * from chefmozhours4;
select * from chefmozparking;
select * from geoplaces2;
select * from rating_final;
select * from usercuisine;
select * from userpayment;
select * from userprofile;



#####Part - 2 #####

-- Question 1: - We need to find out the total visits to all restaurants under all alcohol categories available.
select count()
from ;
(select distinct(alcohol) 
from geoplaces2);
select distinct(alcohol) from geoplaces2;

-- Question 2: -Let's find out the average rating according to alcohol and price so that we can understand the 
--              rating in respective price categories as well.
select avg(r.rating),g.alcohol,g.price
from rating_final r
join geoplaces2 g
on r.placeid = g.placeid
group by g.alcohol,g.price;

-- Question 3:  Let’s write a query to quantify that what are the parking availability as well 
--                 in different alcohol categories along with the total number of restaurants.
select count(gp.name),gp.alcohol,cp.parking_lot
from geoplaces2 gp join chefmozparking cp
on gp.placeid = cp.placeid
where cp.parking_lot = 'yes' group by gp.alcohol;

-- Question 4: -Also take out the percentage of different cuisine in each alcohol type.
select (count(cc.rcuisine)/sum(count(cc.rcuisine)))*100 as Percentage,gp.alcohol
from chefmozcuisine cc join
geoplaces2 gp
on cc.placeid = gp.placeid 
group by gp.alcohol;


-- Questions 5: - let’s take out the average rating of each state.
-- select rating

-- Questions 6: -' Tamaulipas' Is the lowest average rated state. Quantify the reason why it is the lowest rated by 
-- 					providing the summary on the basis of State, alcohol, and Cuisine.

-- Question 7:  - Find the average weight, food rating, and service rating of the customers who have visited 
--                KFC and tried Mexican or Italian types of cuisine, and also their budget level is low.
--                We encourage you to give it a try by not using joins.
#select avg(weight),food_rating,service_rating,name,rcuisine,budget;
select rf.food_rating,rf.service_rating
from rating_final rf
where rf.placeid in
(select rf.placeid,gp.name from geoplaces2 gp
where gp.name = 'kfc' =
(select gp.name,uc.rcuisine from usercuisine uc
where uc.rcuisine in ('Mexican','Italian') =
(select uc.rcuisine,budget 
from userprofile  
where budget = 'low')));


#1. write a query to find userid where payment done using 'debit card'
select * from userpayment;
select userID,Upayment from userpayment where Upayment like '%debit_cards';


#2. write a query to find our latitude, longitude, state, country where no alcohol is severed in 'mexico'
select * from geoplaces2;
select latitude, longitude, state, country, alcohol from geoplaces2 where alcohol like 'No_Alcohol%' and country ='Mexico';


#2. write a query to find our latitude, longitude, state, country where no alcohol is severed in 'mexico'
select * from geoplaces2;
select latitude, longitude, state, country, alcohol from geoplaces2 where alcohol like 'No_Alcohol%' and country ='Mexico';





#2write a query to find our latitude, longitude, state, country where no alcohol is severed in 'mexico'
select rf.food_rating,rf.service_rating,rf.placeID,g.city,g.name from rating_final rf join geoplaces2 g where food_rating>1 and service_rating<2 ;
