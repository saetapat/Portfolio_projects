--  1. What is the total amount each customer spent at the restaurant?
-- A spent on product 76 dollar 
-- B spent on product 74 dollar 
-- C spent on product 36 dollar
select 
	s.customer_id,
    sum(s.product_id) amount,
    sum(menu.price) spent
from sales s 
left join menu on s.product_id = menu.product_id
group by s.customer_id ; 

--2. How many days has each customer visited the restaurant?
-- answer: A and B has been visited 6 days, C has been visited just 3 days.
select 
	customer_id,
	count(order_date)
from sales
group by customer_id; 


--3. What was the first item from the menu purchased by each customer?
-- ans customer A has ordered sushi (2021-01-01) / B has orderd curry / C has ordered ramen
with ans as(
select 
	s.customer_id,
  s.order_date,
    s.product_id,
    menu.product_name
from sales s 
join menu on s.product_id = menu.product_id) 
select * from ans where customer_id = 'C' limit 1;

--4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- ans: ramen is the most purchased menu at 8 times.

with ans4 as(
  select 
  	s.product_id,
  	menu.product_name
  from sales s 
  join menu on s.product_id = menu.product_id) 

select 
	product_name,
	count(product_id) product_amount
from ans4
group by product_name
order by product_amount desc;

--5. Which item was the most popular for each customer?
-- ans: ramen is the most popular dish among A and C,  B is perfer curry
 with ans4 as(
  select 
  s.customer_id,
  	s.product_id,
  	menu.product_name
  from sales s 
  join menu on s.product_id = menu.product_id) 

select 
	customer_id,
	product_name,
	count(product_id) product_amount
from ans4
group by customer_id,product_name
order by product_amount DESC; 

