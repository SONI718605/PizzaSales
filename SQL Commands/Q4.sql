-- Identify the most common pizza size ordered.

select p.size as size,count(od.quantity) as order_count
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
group by p.size
order by sum(od.quantity) desc
limit 1;