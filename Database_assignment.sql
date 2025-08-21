use pwskills;

#################################################################################################################################################################################
/* 
Ques 1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints. */

create table employees(emp_id integer not null primary key,
emp_name varchar(30) not null,
age integer check (age >=18),
email varchar(40) unique,
salary decimal default (30000.00));

desc employees;

#################################################################################################################################################################################
/* 
Ques 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.

cconstraints are rules that is set to our datasets/columns to make sure data is correct and clean and as oer the requirement, it should not be garbage value.
Constraints doesn't stops mistakes instead  it keeps our data correct by applying rules on them like id should be unique and not null etc.

Some Common constraints are :
Unique => Ensures all the values entered in a column are unique
Not Null => ensures none of the rows goes without data, something should be there 
Primary Key => it combines the functionality of both unique key and not null values, the data should be unique and at the same time it should not be null.
check => it ensures that only values which satisfies the given conditon will get saved as row data
Default => it ensures that the row should not be empty even if user is not providing any value, it put by default values on those rows.



#################################################################################################################################################################################

Ques 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

We apply not null constraint to make sure that the field is never left empty, something should be there.it make sures tha the important information shpuld aways be there 
example employee id.
no, primary key can never be null, its the combination of unique key and not null which means the field can not be null 

#################################################################################################################################################################################




Ques 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.
*/
## Adding Constraint
create table test(sid varchar(10),sname varchar(30),s_email varchar(30));

alter table test add constraint sid primary key(sid);
alter table test modify s_email varchar(30) not null;
alter table test add constraint sname check(char_length(sname)>=5);

desc test;

## Removing Constraint

alter table test drop primary key;
alter table test modify s_email varchar(30);
alter table test drop check sname;

# command to find constraints in a table

SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'test';



#################################################################################################################################################################################

/*
Ques 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.

*/
select * from employees;

# violating Primary key 
insert into employees values(101,'Rohit',27,'rk909560@gmail.com',50000);
insert into employees values(101,'RK',27,'rk489547@gmail.com',10000);

# error : Error Code: 1062. Duplicate entry '101' for key 'employees.PRIMARY'

# Violating Not Null

INSERT INTO employees (emp_id, emp_name, age, email) VALUES (102, NULL, 28, 'nullname@gmail.com');

# error : Error Code: 1048. Column 'emp_name' cannot be null

# violating CHECK

insert into employees values(102,'Shreya',17,'abc@gmail.com',50000);

# error : Error Code: 3819. Check constraint 'employees_chk_1' is violated.

# violating Unique

insert into employees values(103,'Shyam',19,'rk909560@gmail.com',60000);
# error : Error Code: 1062. Duplicate entry 'rk909560@gmail.com' for key 'employees.email'

#################################################################################################################################################################################




# Ques 6: You created a products table without constraints as follows:

CREATE TABLE products (product_id INT,product_name VARCHAR(50),price DECIMAL(10, 2));show tables;
select * from products;

# Now, you realise that? The product_id should be a primary keyQ  The price should have a default value of 50.00

alter table products add constraint product_id primary key(product_id);
alter table products modify price DECIMAL(10, 2) default(50.00);



#################################################################################################################################################################################

# Ques 7:You have two tables: students, classes, Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

create table students(student_id int,student_name varchar(30), class_id int);
create table classes(class_id int,class_name varchar(10));

insert into students values(1,'Alice',101),(2,'Bob',102),(3,'Charlie',101);
insert into classes values(101,'math'),(102,'science'),(103,'History');

# Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
select student_name,class_name from students s inner join classes c on s.class_id=c.class_id;

#################################################################################################################################################################################

# Ques 8. Consider the following three tables: orders, customers, Products , 
# Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order 

CREATE TABLE Orders (order_id INT,order_date DATE,customer_id INT);
INSERT INTO Orders VALUES (1, '2024-01-01', 101),(2, '2024-01-03', 102);

CREATE TABLE Customers (customer_id INT,customer_name VARCHAR(50));
INSERT INTO Customers VALUES (101, 'Alice'),(102, 'Bob');

drop table products; # because already exists
CREATE TABLE Products (product_id INT,product_name VARCHAR(50),order_id INT);
INSERT INTO Products VALUES(1, 'Laptop', 1),(2, 'Phone', NULL);


select * from orders;
select * from Customers;
select * from products;

select o.order_id,customer_name,product_name from products p left join orders o on p.order_id=o.order_id left join customers c on o.customer_id=c.customer_id;

#################################################################################################################################################################################

# Ques 9 Given the following tables:
# Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

CREATE TABLE Products (product_id INT,product_name VARCHAR(50));

INSERT INTO Products VALUES(101, 'Laptop'),(102, 'Phone');

CREATE TABLE Sales (sale_id INT,product_id INT,amount INT);

INSERT INTO Sales VALUES(1, 101, 500),(2, 102, 300),(3, 101, 700);

select product_name,sum(amount)Total_Sale from products p inner join sales s on p.product_id=s.product_id group by product_name;


#################################################################################################################################################################################


#Ques 10. You are given three tables:
# Write a query to display the order_id, customer_name, and the quantity of products ordered by each
# customer using an INNER JOIN between all three tables.

CREATE TABLE Orders (order_id INT, order_date DATE, customer_id INT); 
INSERT INTO Orders VALUES (1, '2024-01-02', 1), (2, '2024-01-05', 2); 

CREATE TABLE Customers (customer_id INT, customer_name VARCHAR(50)); 
INSERT INTO Customers VALUES (1, 'Alice'), (2, 'Bob'); 

CREATE TABLE Order_Details (order_id INT, product_id INT, quantity INT); 
INSERT INTO Order_Details VALUES (1, 101, 2), (1, 102, 1), (2, 101, 3);


select o.order_id,customer_name, sum(quantity) from orders o inner join customers c on o.customer_id=c.customer_id 
inner join Order_Details ord on o.order_id=ord.order_id group by customer_name;


#################################################################################################################################################################################

# SQL Commands
/*
Ques 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
*/

-- There are 26 tables in maven movies and soo many primary key and foreign keys are present.
/* actor_id,actor_award_id,address_id,advisor_id,category_id,city_id and many more

Not sure why this question is here, what i'll achive just with finding the primary keys, first,tell the educator to atleast teach these topics, who is having
# half knowledge of subject and skipped all the content like, all the key, views, joins explanation , clarity on window functions and many more, just a formality course 


-- Ques 2- List all details of actors */
select * from actor;

-- Ques 3 -List all customer information from DB.
select * from customer;

-- Ques 4 -List different countries.
select distinct(country) from country;


-- Ques 5 -Display all active customers.
select * from customer where active=1;


-- Ques 6 -List of all rental IDs for customer with ID 1.

select rental_id,customer_id from rental where customer_id=1;

-- Ques 7 - Display all the films whose rental duration is greater than 5 .
select title from film where rental_duration>5;

-- Ques 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
select count(film_id) from film where replacement_cost > 15 and replacement_cost<20;

-- Ques 9 - Display the count of unique first names of actors.
select count(distinct(first_name))Unique_count from actor;

-- Ques 10- Display the first 10 records from the customer table .
select * from customer limit 10;

-- Ques 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer where first_name like 'b%' limit 3;

-- Ques 12 -Display the names of the first 5 movies which are rated as ‘G’.
select title from film where rating='G' limit 5;

select * from film;

-- Ques 13-Find all customers whose first name starts with "a".
select * from customer where first_name like 'a%';

-- Ques 14- Find all customers whose first name ends with "a".
select * from customer where first_name like '%a';

-- Ques 15- Display the list of first 4 cities which start and end with ‘a’ .
select * from city where city like 'a%a' limit 4;

select * from city;

-- Ques 16- Find all customers whose first name have "NI" in any position.
select * from customer where first_name like '%NI%';

-- Ques 17- Find all customers whose first name have "r" in the second position .
select * from customer where first_name like '_r%';


-- Ques 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select * from customer where first_name like 'a____%';

-- Ques 19- Find all customers whose first name starts with "a" and ends with "o".
select * from customer where first_name like 'a%o';


-- Ques 20 - Get the films with pg and pg-13 rating using IN operator.
select * from film where rating in ('pg','pg-13');


-- Ques 21 - Get the films with length between 50 to 100 using between operator.
select * from film where length between 50 and 100;

-- Ques 22 - Get the top 50 actors using limit operator.
select * from actor limit 50;

-- Ques 23 - Get the distinct film ids from inventory table.
select distinct(film_id) from inventory;


##############################################################################################################################################
-- Functions
-- Basic Aggregate Functions:

#Question 1: Retrieve the total number of rentals made in the Sakila database.
select count(rental_id) as 'Number of Rentals' from rental;

#Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
select datediff(return_date,rental_date)as 'Rental duration' from rental;


#Question 3: Display the first name and last name of customers in uppercase.
select UPPER(first_name),upper(last_name) from customer;

select upper(concat(first_name, ' ' ,last_name)) from customer;

#Question 4: Extract the month from the rental date and display it alongside the rental ID.
select month(rental_date)Month,rental_id from rental;


#Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select customer_id,count(rental_id)as 'count of rentals' from rental group by customer_id;



#Question 6: Find the total revenue generated by each store.
select store,total_sales as 'Total_Revenue' from sales_by_store;


#Question 7: Determine the total number of rentals for each category of movies.

select name,count(rental_id) from rental r inner join inventory i on r.inventory_id=i.inventory_id join film_category fc on i.film_id=fc.film_id
join category c on fc.category_id=c.category_id group by name;



#Question 8: Find the average rental rate of movies in each language.

select l.name,coalesce(avg(rental_rate),0) from language l left join film f on f.language_id=l.language_id group by l.name;

# except english all languages are zero bcoz in the MavenMovies database, almost all films are in English, and the language table has 6 entries, but film.language_id is only linked to English (ID = 1) 
#for all records in the default dataset.



#Joins
#Questions 9 -Display the title of the movie, customer s first name, and last name who rented it.

select title,first_name,last_name from film f join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id join customer c on r.customer_id
=c.customer_id;



#Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
select concat(first_name," ",last_name)Name,title from actor a join film_actor fa on a.actor_id=fa.actor_id join film f on 
fa.film_id=f.film_id where f.title ='Gone with the Wind';
## no movie name found like Gone with the Wind.



#Question 11: Retrieve the customer names along with the total amount they have spent on rentals.
select concat(first_name,' ',last_name)'Name',sum(amount)'Total_Amount_spent' from customer c join payment p on c.customer_id=p.customer_id join rental r on p.rental_id=r.rental_id
group by c.customer_id order by Total_Amount_spent;



#Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
select concat(c.first_name,' ',c.last_name)Name,title,city from film f join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id join customer c on 
r.customer_id=c.customer_id join address a on c.address_id=a.address_id join city ci on a.city_id=ci.city_id where city='London' ;




#Question 13: Display the top 5 rented movies along with the number of times they have been rented.

select title,count(rental_id)Rental_Count from film f join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id group by title
order by Rental_count desc limit 5;




#Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

select concat(first_name,' ',last_name)'Name',count( distinct s.store_id)distinct_store from customer c join rental r on c.customer_id=r.customer_id join inventory i
on r.inventory_id =i.inventory_id join store s on i.store_id=s.store_id group by c.customer_id,Name having count(distinct s.store_id)=2;

#################################################################################################################################################################################

#Windows Function:

#Ques 1. Rank the customers based on the total amount they've spent on rentals.

select c.customer_id,first_name,sum(amount)Total_amount,rank() OVER (ORDER BY SUM(amount) DESC) as "rank" from customer c join 
payment p on c.customer_id=p.customer_id group by c.customer_id,first_name order by Total_amount desc;


#Ques 2. Calculate the cumulative revenue generated by each film over time.

select title,sum(amount) over(partition by title ORDER BY p.payment_date asc)'cumulative_revenue' from film f join 
inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id join 
payment p on r.rental_id = p.rental_id;


#Ques 3. Determine the average rental duration for each film, considering films with similar lengths.
select title,avg(rental_duration)  over(partition by length)as'AVG_Duration' from film;



#Ques 4. Identify the top 3 films in each category based on their rental counts.

select title,name,rental_count from (
select title,cg.name,count(rental_id)rental_count,row_number() over(partition by cg.name order by count(rental_id))'row_numbers' 
from film f join film_category fc on f.film_id=fc.film_id join category cg on fc.category_id=cg.category_id join inventory i 
on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id GROUP BY cg.name, f.title)as rn where row_numbers<=3
order by title,name,rental_count;



#Ques 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

SELECT customer_id,COUNT(rental_id) AS total_rentals,COUNT(rental_id) - AVG(COUNT(rental_id)) OVER () AS difference_from_avg 
FROM rental
GROUP BY customer_id;


#Ques 6. Find the monthly revenue trend for the entire rental store over time.
select month(payment_date)as months,sum(amount) as Total_Revenue from payment group by months order by months;  


#Ques 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
#select * from(
#select customer_id,sum(amount)as total_spending from payment group by customer_id)as t order by total_spending desc;

select * from
(select customer_id,sum(amount)as total_spending,ntile(5) over(order by sum(amount) desc)as spending_group from payment group by customer_id) as t
where spending_group=1 order by total_spending desc;



#Ques 8. Calculate the running total of rentals per category, ordered by rental count.
select *,sum(rental_count) over(order by rental_count desc )as running_total from(
select c.name as category,count(r.rental_id)as rental_count from category c join film_category fc on c.category_id=fc.category_id join inventory i on fc.film_id=i.film_id join rental r on
i.inventory_id=r.inventory_id group by category) t order by rental_count desc ;


#Ques 9. Find the films that have been rented less than the average rental count for their respective categories.

select title,count(rental_id) as no_of_times_rented from film f join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id
group by title;



#Ques 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
select month(payment_date) as months,sum(amount) as Total_revenue from payment group by months order by Total_revenue desc limit 5;

####################################################################################################################################################



-- Normalisation & CTE

-- Ques 1. First Normal Form (1NF):
-- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
select * from actor_award;

/*
1	12	KARL	BERRY	Emmy, Oscar, Tony 	2006-02-15 04:34:33
2	21	KIRSTEN	PALTROW	Emmy, Oscar, Tony 	2006-02-15 04:34:33 
actor_award is the column which is voilation one 1Nf. if we see the column awards, there are more than one values seperated by comma 
which is wrong as per 1 NF.

We can normalize is by sperating awards and putting each award into a new and seperate row.

actor_award_id	actor_id	first_name	last_name	award
1					12			KARL	BERRY		Emmy
2					12			KARL	BERRY		Oscar
3					12 			KARL	BERRY		Tony
*/


-- Ques 2. Second Normal Form (2NF):

 #a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.If it violates 2NF, explain the steps to normalize it.
/* 
table film actor is a good candidate for 2nf.
A table is in 2nf is it is already in 1 Nf i.e all values are atomic, no non key column depends on only part of a composite primary key 

column last_update depends on both actor_id and film_id
in this table there is no column which only depends on film_id or actor _id so no partial dependencies

*/
select * from film_actor;

##########################
/*
Ques 3. Third Normal Form (3NF):

 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.

The film table is a example that can violate 3NF.
language_id & language.name the film’s language name depends on language_id, not directly on film_id.


Ques 4. Normalization Process:

 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 

 unnormalized form up to at least 2NF. */
###############################

-- Ques 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from 
#	  the actor and film_actor tables.

# using CTE
with distinct_list as(
select concat(first_name," ",last_name)as Name,count(film_id) as count  from actor a join film_actor fa on a.actor_id=fa.actor_id 
group by Name) select distinct * from distinct_list;

# Using Derive Table

select * from(
select concat(first_name," ",last_name)as Name,count(film_id) as count  from actor a join film_actor fa on a.actor_id=fa.actor_id 
group by Name)t;


#Ques 6. CTE with Joins:
# a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.

with film_language as(
select title as film_title,l.name as language_name,rental_rate from film f join language l on 
f.language_id=l.language_id)select * from film_language;



#Ques 7. CTE for Aggregation:
# a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
with total_revenue as(
select c.customer_id,sum(amount) as Total_Payments from customer c join payment p on c.customer_id=p.customer_id group by customer_id)
select * from total_revenue;


#Ques 8. CTE with Window Functions:
#a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
with ranking_film as(
select title as name,rental_duration as Duration,rank() over(order by rental_duration) as Ranks from film) select * from ranking_film;


#Ques 9 CTE and Filtering:
#a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the  customer table to 
#   retrieve additional customer details.


WITH frequent_customers AS (
    SELECT customer_id, COUNT(rental_id) as rental_count from rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)SELECT c.customer_id, c.first_name, c.last_name, fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id;

#Ques 10. CTE for Date Calculations:
# a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table

with rentals_made as(
select month(rental_date) as Month_s,count(rental_id) as Rental_made_each_Month from rental group by Month_s)select * from rentals_made
order by Month_s;

#Ques 11. CTE and Self-Join:
#a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
with pair_of_actors as(
select fa1.actor_id as actor_id_1,fa2.actor_id as actor_id_2 from film_actor fa1 join film_actor fa2 on fa1.film_id=fa2.film_id and fa1.actor_id<fa2.actor_id)select * 
from pair_of_actors;

# those who have worled in the same film_id means they have acted together and we will get their actor_id
# showing actors name too


with pair_of_actors as(
select fa1.actor_id as actor_id_1,fa2.actor_id as actor_id_2 from film_actor fa1 join film_actor fa2 on fa1.film_id=fa2.film_id and 
fa1.actor_id<fa2.actor_id GROUP BY fa1.actor_id, fa2.actor_id
)select 
concat(a1.first_name," ",a1.last_name) as Actor_1,
concat(a2.first_name," ",a2.last_name) as Actor_2,actor_id_1,actor_id_2
from pair_of_actors poa join actor a1 on poa.actor_id_1=a1.actor_id
join actor a2 on poa.actor_id_2=a2.actor_id;



#Ques 12. CTE for Recursive Search:
#a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column

WITH RECURSIVE staff_hierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1   -- change to your manager's staff_id

    UNION ALL
    
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    INNER JOIN staff_hierarchy sh
        ON s.reports_to = sh.staff_id
)
SELECT * 
FROM staff_hierarchy;


#in mavenmovies database in staff table there is no reports_to column, though writing just the query.
