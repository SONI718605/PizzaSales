-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

with cte as(select pt.category as category ,pt.name as name,sum(od.quantity*p.price) as re ,
rank() over (partition by pt.category order by sum(od.quantity*p.price) desc)as ranknum
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.category,pt.name
order by pt.category, re desc)

select category,name,round(re,2) as revenue 
from cte
where ranknum<4