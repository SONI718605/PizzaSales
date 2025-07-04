-- List the top 5 most ordered pizza types along with their quantities.

select pt.name as name,sum(od.quantity) as quantity
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.name
order by sum(od.quantity) desc