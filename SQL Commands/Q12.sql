-- Analyze the cumulative revenue generated over time.

with cte as(select o.order_date as mon,sum(od.quantity*p.price) as sre
from orders_details as od
join orders as o on o.order_id=od.order_id 
join pizzas as p on p.pizza_id=od.pizza_id
group by o.order_date)

select mon,round(sum(sre) over(order by mon),2) as cumultive_revenue
from cte