-- 6. Which item was purchased first by the customer after they became a member?
-- ans: sushi 
with ans6 as ( 
  select 
  	members.customer_id,
  	members.join_date,
  	menu.product_name
  from members
  join sales on members.customer_id = sales.customer_id
  join menu on sales.product_id = menu.product_id ) 
 
 select 
 	customer_id,
    MIN(join_date),
    product_name
 from ans6
 group by customer_id; 
 
 -- 7. Which item was purchased just before the customer became a member?
 -- ans: A and B  has ordered curry and sushi.
with purchase_member as ( 
  select 
  	members.customer_id, members.join_date, order_date, product_name, price
  from members
  join sales on members.customer_id = sales.customer_id
  join menu on sales.product_id = menu.product_id )

select customer_id, min(join_date) member_date, order_date , product_name  from purchase_member
group by  customer_id, order_date , product_name
HAVING order_date < member_date; 

--8. What is the total items and amount spent for each member before they became a member?
with purchase_member as ( 
  select 
  	members.customer_id, members.join_date, order_date, product_name, price
  from members
  join sales on members.customer_id = sales.customer_id
  join menu on sales.product_id = menu.product_id ),
  purchase_hist as (
  select 
   customer_id, order_date, product_name, price 
  from sales
  join menu on sales.product_id = menu.product_id )
  select customer_id , sum(price) net_spent_before from purchase_member
group by  customer_id
HAVING order_date < min(join_date)
UNION all 
  select customer_id, sum(price)
from purchase_hist 
where customer_id = 'C'; 

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- ans: A,B and C will have 86,94 and 36 points respectively.
with purchase_hist as (
  select 
   customer_id, order_date, product_name, price, price *1 point
  from sales
  join menu on sales.product_id = menu.product_id
  where product_name != 'sushi'
 union all 
  select 
   customer_id, order_date, product_name, price, price *2 point
  from sales
  join menu on sales.product_id = menu.product_id
  where product_name = 'sushi' )
 select customer_id, sum(point) from purchase_hist
 group by customer_id; 
 
 
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
with purchase_hist_member as (
select 
  	members.customer_id, members.join_date, order_date, product_name, price
  from members
  join sales on members.customer_id = sales.customer_id
  join menu on sales.product_id = menu.product_id
where order_date >= join_date and order_date <= '2021-01-31')

select customer_id, sum(point)
from (select customer_id, order_date, 
      case when order_date >= join_date and order_date <= date(join_date,'+7 Day') then price * 2 
      else price 
      end as point 
  from purchase_hist_member)
group by customer_id; 
