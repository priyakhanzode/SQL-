####### PART 2 ###############

#-- Question 1: - We need to find out the total visits to all restaurants under all alcohol categories available.
select count(u.userid) visits, g.alcohol, g.name from userprofile u join rating_final r on u.userID=r.userID join geoplaces2 g on r.placeID=g.placeID  
 group by  g.alcohol, g.name order by visits ;
 
 
-- Question 2: -Let's find out the average rating according to alcohol and price so that we can understand the 
--              rating in respective price categories as well.
select avg(r.rating),g.alcohol,g.price
from rating_final r
join geoplaces2 g
on r.placeid = g.placeid
group by g.alcohol,g.price;



-- Question 3:  Let’s write a query to quantify that what are the parking availability as well 
--                 in different alcohol categories along with the total number of restaurants.
select count(g.name),g.alcohol,c.parking_lot
from geoplaces2 g join chefmozparking c
on g.placeid = c.placeid
where c.parking_lot = 'yes' group by g.alcohol;



-- Question 4: -Also take out the percentage of different cuisine in each alcohol type.
select (count(c.rcuisine)/(count(c.rcuisine)))/100 as Percentage,g.alcohol
from chefmozcuisine c join
geoplaces2 g
on c.placeid = g.placeid 
group by g.alcohol;

WITH total AS
(
      SELECT SUM(rcuisine) AS total
    FROM chefmozcuisine
)
SELECT alcohol,
    rcuisine * 100 / rcuisine AS 'Percentage(%)'
FROM chefmozcuisine
CROSS JOIN geoplaces2;



#Questions 5: - let’s take out the average rating of each state.
select avg(rating),state
from rating_final rf join geoplaces2 g
using(placeid)
group by state;

#Questions 6: -' Tamaulipas' Is the lowest average rated state. 
#Quantify the reason why it is the lowest rated by providing the summary on the basis of State, alcohol, and Cuisine.

select avg(rating),state,alcohol,Rcuisine
from rating_final rf join geoplaces2 g
using(placeid)
join chefmozcuisine c using(placeid)
where state ='Tamaulipas'
group by state,alcohol,Rcuisine;


 #Question 7:  - Find the average weight, food rating, and service rating of the customers who have visited 
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
(select uc.rcuisine
from userprofile  
where budget = 'low')));

########### question ##########

#1. write a query to find userid where payment done using 'debit card'
#2. write a query to find our latitude, longitude, state, country where no alcohol is severed in 'mexico'
#3. find out places where food rating is greater than 1 and service rating is less than 2