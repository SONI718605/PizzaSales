-- Calculate the total revenue generated from pizza sales.--

select round(sum(p.price*od.quantity),2) as Total_Revanue
from orders_details as od
join pizzas as p on  od.pizza_id=p.pizza_id