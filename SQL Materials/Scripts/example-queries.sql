SELECT * FROM sql_store.customers;


-- selects the customers whose has points above 3000
select * from customers where points > 3000;

-- selects the customers who had born after 1999
select * from customers where birth_date > '1990-01-01';

-- birthdate after 1999 and points above 3000
-- and operator has higher priority over or operator
select * from customers where birth_date > '1990-01-01' and points > 3000;

-- either born after 1999 or have points above 3000
select * from customers where birth_date > '1990-01-01' or points > 3000;

-- the below both are same
select * from customers where not (birth_date > '1990-01-01' or points > 3000); 
select * from customers where  (birth_date <= '1990-01-01' and points <= 3000); 

-- in is used to combine all the or conditions
select * from customers where state = 'VA' or state = 'MA' or state = 'FL';
select * from customers where state in ('VA', 'MA', 'FL');

-- selects the customers who are not in the below states
select * from customers where state not in ('VA', 'MA', 'FL');


-- between is used to select the data between any range
select * from customers where points >= 1000 and points <=3000;
select * from customers where points between 1000 and 3000;
select * from customers where birth_date between '1980-01-01' and '1990-01-01';

-- selects the state starts with c
select * from customers where state like 'c%';
-- selects the states ends with a
select * from customers where state like '%a';
-- selects the customers whose name ends with y and has length 4
select * from customers where first_name like '___y';
-- selects the customers who has y in their lastname
select * from customers where last_name like '%y%';


-- selects the customers whose data is null in phone column
select * from customers where phone is null;
-- selects the customers whose data is not null in phone column
select * from customers where phone is not null;


-- arrange the table based on points from ascending to descending 
select * from customers order by points ;
-- vice versa of the above
select * from customers order by points desc;
select * from customers order by state, points desc;	

-- groups the cusotmers by state
select count(*), state from customers group by state;
-- select state which is exactly 2
select state from customers group by state having count(*) = 2;

-- having is used when we add any condition on aggregate functions
-- the column in the select should be used either in group by or in having or else it will throw error
-- select count(points), customer_id, state from customers group by state having count(points)>=2; throw error
select count(points),  state from customers group by state having count(points)>=2;



select all points from customers where points > 1000;

-- selects the first 5 records
-- limit should be at the end of the query
select * from customers limit 5;
-- selects the last 5 records
select * from customers order by customer_id desc limit 5 ;
select * from (
	select * from customers order by customer_id desc limit 5
    )  AS sub
    order by customer_id;



-- joining customer table and order table
select 
	c.customer_id,
	c.first_name as customer_name,
    o.order_date
from orders o 
join customers c
on o.customer_id = c.customer_id;

-- implicit join (syntax is much easier)
select 
	c.customer_id,
	c.first_name as customer_name,
    o.order_date 
from orders o, customers c
where o.customer_id = c.customer_id;

-- join table from 2 databases
select * from order_items o join sql_inventory.products i
	on o.product_id = i.product_id order by order_id ;
    
    
-- join colum in single table (self-join)
select 
	e.employee_id, 
	concat(e.first_name,' ',e.last_name) as emp_name, 
	m.employee_id as manager_id, m.first_name as manager_name 
from employees e 
join employees m 
on e.reports_to = m.employee_id;
    
    

-- left join - selects all data from product table and common data from both table   
select 
		p.product_id,
        p.name,
        o.quantity
from products p
left join order_items o
on p.product_id = o.order_id;



-- joining multiple tables
select 
	c.customer_id,
	c.first_name customer_name,
    o.order_date,
    os.name as order_status,
    p.name as product_name
from orders o 
join customers c
on o.customer_id = c.customer_id
join order_statuses os
on o.status = os.order_status_id
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id;
    
    
    
    
-- unions - combine the row and group them based on points    
select 
	customer_id,
    first_name,
    points,
    "Bronze" as type
from customers where points < 1000
union
select 
	customer_id,
    first_name,
    points,
    "Silver" as type
from customers where points between 1000 and 2000 
union
select 
	customer_id,
    first_name,
    points,
    "Gold" as type
from customers where points between 2001 and 3000;   
    
