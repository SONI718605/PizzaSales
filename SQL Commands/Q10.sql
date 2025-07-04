-- Determine the top 3 most ordered pizza types based on revenue.

with cte as(select pt.name as name,od.quantity*p.price as re
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id)

select name,sum(re) as Revanue
from cte
group by name
order by   Revanue desc
limit 3