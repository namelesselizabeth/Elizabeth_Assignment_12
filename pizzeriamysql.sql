create database pizzeria;
use pizzeria;

create table `customer` (
	`customer_id` int not null,
    `phone` varchar(100) not null,
    `name` varchar(200) not null,
    primary key (`customer_id`)
    );
    
create table `order` (
	`order_id` int not null,
    `p1_type` varchar(50),
    `p1_quantity` int,
    `p1_price` decimal(5,2),
	`p2_type` varchar(50),
    `p2_quantity` int,
    `p2_price` decimal(5,2),
	`p3_type` varchar(50),
    `p3_quantity` int,
    `p3_price` decimal(5,2),
	`p4_type` varchar(50),
    `p4_quantity` int,
    `p4_price` decimal(5,2),
    `customer_id` int not null,
    primary key (`order_id`),
    foreign key (`customer_id`) references `customer` (`customer_id`)
    );
    
create table `customer_account` (
	`order_id` int not null,
    `customer_id` int not null,
    `date_time` datetime,
    foreign key (`order_id`) references `order` (`order_id`),
    foreign key (`customer_id`) references `customer` (`customer_id`)
    );
    
insert into `customer` (customer_id, phone, `name`)
values (1, '226-555-4982', 'Trevor Page');

insert into `customer` (customer_id, phone, `name`)
values (2, '555-555-9498', 'John Doe');

insert into `order` (order_id, p1_type, p1_quantity, p1_price, p3_type, p3_quantity, p3_price, customer_id)
values (1, 'Pepperoni & Cheese', 1, 7.99, 'Meat Lovers', 1, 14.99, 1);

insert into `order` (order_id, p2_type, p2_quantity, p2_price, p3_type, p3_quantity, p3_price, customer_id)
values (2, 'Vegetarian', 1, 9.99, 'Meat Lovers', 2, 14.99, 2);

insert into `order` (order_id, p3_type, p3_quantity, p3_price, p4_type, p4_quantity, p4_price, customer_id)
values (3, 'Meat Lovers', 1, 14.99, 'Hawaiian', 1, 12.99, 1);

insert into `customer_account` (order_id, customer_id, date_time)
values (1, 1, '2014-09-10 09:47:00');

insert into `customer_account` (order_id, customer_id, date_time)
values (2, 2, '2014-09-10 13:20:00');

insert into `customer_account` (order_id, customer_id, date_time)
values (3, 1, '2014-09-10 09:47:00');

select * from `order`;
select * from `customer`;
select * from `customer_account`;

update `order`
set p4_quantity = 0, p4_price = 0
where p4_quantity is null;

update `order`
set p3_quantity = 0, p3_price = 0
where p3_quantity is null;

update `order`
set p2_quantity = 0, p2_price = 0
where p2_quantity is null;

update `order`
set p1_quantity = 0, p1_price = 0
where p1_quantity is null;

-- Q4
select customer_id,
	   sum( case when 'p1_quantity' is not null then p1_price * p1_quantity else 0 end) + 
       sum( case when 'p2_quantity' is not null then p2_price * p2_quantity else 0 end) +
	   sum( case when 'p3_quantity' is not null then p3_price * p3_quantity else 0 end) +
       sum( case when 'p4_quantity' is not null then p4_price * p4_quantity else 0 end) as `total`
from `order`
group by customer_id;

-- Q5
select 
	count(ca.order_id), c.`name`, ca.customer_id, ca.date_time
from customer_account as ca
join customer as c
on ca.customer_id = c.customer_id
group by ca.customer_id, ca.date_time;