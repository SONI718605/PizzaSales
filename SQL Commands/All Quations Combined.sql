-- Retrieve the total number of orders placed-- 

select count(*) as Total_Orders
from orders;

-- Calculate the total revenue generated from pizza sales.--

select round(sum(p.price*od.quantity),2) as Total_Revanue
from orders_details as od
join pizzas as p on  od.pizza_id=p.pizza_id;

-- Identify the highest-priced pizza.

select pt.name as pizza,p.price as price
from pizza_types as pt
join pizzas as p on p.pizza_type_id=pt.pizza_type_id
order by p.price desc
limit 1;

-- Identify the most common pizza size ordered.

select p.size as size,count(od.quantity) as order_count
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
group by p.size
order by sum(od.quantity) desc
limit 1;

-- List the top 5 most ordered pizza types along with their quantities.

select pt.name as name,sum(od.quantity) as quantity
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.name
order by sum(od.quantity) desc;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pt.category as category,sum(od.quantity) as total_quantity
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.category;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour , count(order_id)
from orders 
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.

select category,count(name)
from pizza_types 
group by category
order by count(name) desc;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

with cte as (select  o.order_date as order_date , sum(od.quantity)  as avg_no_of_pizza
from orders_details as od
join orders as o on o.order_id=od.order_id
group  by o.order_date
order by o.order_date)

select round(avg(avg_no_of_pizza),0) as avg_no_of_pizza
from cte;

-- Determine the top 3 most ordered pizza types based on revenue.

with cte as(select pt.name as name,od.quantity*p.price as re
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id)

select name,sum(re) as Revanue
from cte
group by name
order by   Revanue desc
limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

with cte as(select pt.category as name,sum(od.quantity*p.price) as re
from orders_details as od
join pizzas as p on p.pizza_id=od.pizza_id
join pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
group by pt.category)

select c1.name as category,round(c1.re*100.0/c2.sre,2) as percentage
from cte as c1
cross join (select sum(re) sre from cte ) as c2;

-- Analyze the cumulative revenue generated over time.

with cte as(select o.order_date as mon,sum(od.quantity*p.price) as sre
from orders_details as od
join orders as o on o.order_id=od.order_id 
join pizzas as p on p.pizza_id=od.pizza_id
group by o.order_date)

select mon,round(sum(sre) over(order by mon),2) as cumultive_revenue
from cte;

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
where ranknum<4;


