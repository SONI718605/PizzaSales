-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pt.category as category,sum(od.quantity) as total_quantity
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.category
