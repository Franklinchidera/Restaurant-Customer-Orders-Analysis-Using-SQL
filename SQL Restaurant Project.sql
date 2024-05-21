select * from menu_items;

-- View the menu_items table and write a query to find the number of items on the menu 
select count(item_name) from menu_items;

-- What are the least and most expensive items on the menu?
select *, 'Least Price' as Cost from menu_items
where price = (select min(price) from menu_items) 
Union 
select *, 'Expensive Price' as Cost from menu_items
where price = (select max(price) from menu_items);

-- How many Italian dishes are on the menu? 
select count(*) from menu_items
where category = 'italian';

-- What are the least and most expensive Italian dishes on the menu? ----------------------------------------------------------------
select *, 'Least Price' as Cost from menu_items
where price = (select min(price) from menu_items) and category = italian
Union 
select *, 'Expensive Price' as Cost from menu_items
where price = (select max(price) from menu_items) and category = italian; 

-- How many dishes are in each category? 
select category, count(item_name) as num_of_dishes from menu_items 
group by category;

-- What is the average dish price within each category?
select category, round(avg(price),2) as avg_dish_price from menu_items
group by category; 

-- View the order_details table. What is the date range of the table?
select * from order_details; ------------------------------
select min(order_date) as MIN_DATE, max(order_date) as MAX_DATE from order_details;

-- How many orders were made within this date range? How many items were ordered within this date range? 
select count(distinct(order_id)) as num_of_orders from order_details;
select count(item_id) as items_ordered from order_details;

-- Which orders had the most number of items? -----------------------------------------------------------------------------------
select order_id, count(order_id) as num_of_orders from order_details
group by order_id
order by num_of_orders desc
limit 8; 

-- How many orders had more than 12 items? -----------------------------------------------------------------------------------------
select order_id, count(order_id) as number_of_items from order_details
group by order_id
having count(order_id) > 12;

-- Combine the menu_items and order_details tables into a single table 
select * from order_details
 JOIN 	menu_items on order_details.item_id = menu_items.menu_item_id; 
 
-- What are the most ordered items? What categories were they in?
 select item_name, category, count(item_name) as most_ordered_item from order_details 
JOIN menu_items on order_details.item_id = menu_items.menu_item_id
group by item_name, category
ORDER by most_ordered_item desc
limit 1;

-- Least Ordered and Category  
select item_name, category, count(item_name) as least_ordered_item from order_details 
JOIN menu_items on order_details.item_id = menu_items.menu_item_id
group by item_name, category
ORDER by least_ordered_item asc
limit 1;

-- What were the top 5 orders that spent the most money?
select order_id, sum(price) as most_money from order_details
 JOIN 	menu_items on order_details.item_id = menu_items.menu_item_id
 group by order_ID
 order by most_money desc
 limit 5; 
 
 -- View the details of the highest spend order. Which specific items were purchased? 
 select order_id, item_name, sum(price)  as highest_spend_order from order_details
 JOIN 	menu_items on order_details.item_id = menu_items.menu_item_id
 group by order_id, item_name
 order by highest_spend_order desc
 limit 3;
 
 --  View the details of the top 5 highest spend orders 
select order_id, sum(price)  as highest_spend_order from order_details
 JOIN 	menu_items on order_details.item_id = menu_items.menu_item_id
 group by order_id
 order by highest_spend_order desc
 limit 5;
 
 -- How much was the most expensive order in the dataset? 
 select order_id, sum(price)  as highest_spend_order from order_details
 JOIN 	menu_items on order_details.item_id = menu_items.menu_item_id
 group by order_id
 order by highest_spend_order desc
 limit 1;


