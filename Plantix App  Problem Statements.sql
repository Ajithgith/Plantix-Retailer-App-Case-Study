use plantix;

select * from login_logs;
select * from sales_orders;
select * from sales_orders_items;

/*** 1. Number of orders which got shipped to the buyer. ***/

select count(order_id) from sales_orders where sales_order_status = "Shipped"; 
/** 5923 **/

/*** 2. Number of products sold in the year 2021 and 2022. ***/

select count(f.fk_product_id) from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2021';
/**3836**/

select count(f.fk_product_id) from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2022';
/**4976**/


/*** 3. Total amount generated in 2021 and 2022 ***/

select sum(f.rate) from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2021';
/** 21946637.523999963 **/

select sum(f.rate) from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2022';
/** 36220417.440000005

/*** 4. Number of users logged in 2021 and 2022 ***/

select count(user_id) from login_logs where year(login_time) = '2021';
/** 271240 **/

select count(user_id) from login_logs where year(login_time) = '2022';
/** 395117 **/


/*** 5. Total number of orders made in 2021 and 2022 ***/

select count(order_id) from sales_orders where year(creation_time) = '2021';
/** 6216 **/

select count(order_id) from sales_orders where year(creation_time) = '2022';
/** 7414 **/


/*** 6. Total number of orders rejected in 2021 and 2022 ***/

select count(order_id) from sales_orders where sales_order_status = "Rejected" and year(creation_time) = '2021';
/** 3764 **/

select count(order_id) from sales_orders where sales_order_status = "Rejected" and year(creation_time) = '2022';
/** 3899 **/


/*** 7. Total number of orders shipped in 2021 and 2022 ***/

select count(order_id) from sales_orders where sales_order_status = "Shipped" and year(creation_time) = '2021';
/** 2434 **/

select count(order_id) from sales_orders where sales_order_status = "Shipped" and year(creation_time) = '2022';
/** 3489 **/


/*** 8. Top selling products in 2021 and 2022 ***/

select f.fk_product_id, f.rate as total_amount_generated from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2021' group by f.fk_product_id order by total_amount_generated desc;

select f.fk_product_id, f.rate as total_amount_generated from sales_orders_items f inner join sales_orders s 
on f.fk_order_id = s.order_id 
where s.sales_order_status = "Shipped" and f.order_quantity_accepted>0 and year(s.creation_time) = '2022' group by f.fk_product_id order by total_amount_generated desc;


/*** 9. Total number of orders in Pending and Review state in 2021 and 2022 ***/

select count(order_id) from sales_orders where sales_order_status in ("Pending", "Review") and year(creation_time) = '2021';
/** 18 **/

select count(order_id) from sales_orders where sales_order_status in ("Pending", "Review") and year(creation_time) = '2022';
/** 26 **/