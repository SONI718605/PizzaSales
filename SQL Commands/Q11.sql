-- Calculate the percentage contribution of each pizza type to total revenue.

with cte as(select pt.category as name,sum(od.quantity*p.price) as re
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.category)

select c1.name as category,round(c1.re*100.0/c2.sre,2) as percentage
from cte as c1
cross join (select sum(re) sre from cte ) as c2