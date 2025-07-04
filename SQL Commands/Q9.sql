-- Group the orders by date and calculate the average number of pizzas ordered per day.

with cte as (select  o.order_date as order_date , sum(od.quantity)  as avg_no_of_pizza
from orders_details as od
join orders as o on o.order_id=od.order_id
group  by o.order_date
order by o.order_date)

select round(avg(avg_no_of_pizza),0) as avg_no_of_pizza
from cte