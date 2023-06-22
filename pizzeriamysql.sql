create database pizzeria;
use pizzeria;

create table `customer` (
	`customer_id` int not null,
    `phone` varchar(100) not null,
    `name` varchar(200) not null,
    primary key (`customer_id`)
    );
    
create table `menu` (
	`menu_item_id` int not null,
    `pizza_type` varchar(50),
    `pizza_price` decimal(5,2),
    primary key (`menu_item_id`)
    );

create table `order` (
	`order_id` int not null,
    `date_time` datetime,
    `customer_id` int not null,
    primary key (`order_id`),
    foreign key (`customer_id`) references `customer` (`customer_id`)
    );
    
create table `customer_account` (
	`order_id` int not null,
    `customer_id` int not null,
    `menu_item_id` int not null,
    `item_quantity` int not null,
    foreign key (`order_id`) references `order` (`order_id`),
    foreign key (`customer_id`) references `customer` (`customer_id`),
    foreign key (`menu_item_id`) references `menu` (`menu_item_id`)
    );
    
select * from `order`;
select * from `customer`;
select * from `customer_account`;
select * from `menu`;

insert into `customer` (customer_id, phone, `name`)
values (1, '226-555-4982', 'Trevor Page'), (2, '555-555-9498', 'John Doe');
    
insert into `menu` (menu_item_id, pizza_type, pizza_price)
values (1, 'Pepperoni & Cheese', 7.99), (2, 'Vegetarian', 9.99), (3, 'Meat Lovers', 14.99), (4, 'Hawaiian', 12.99);

insert into `order` (order_id, date_time, customer_id)
values (1, '2014-09-10 09:47:00', 1);

insert into `order` (order_id, date_time, customer_id)
values (2, '2014-09-10 13:20:00', 2);

insert into `order` (order_id, date_time, customer_id)
values (3, '2014-09-10 09:47:00', 1);

insert into `customer_account` (order_id, customer_id, menu_item_id, item_quantity)
values (1, 1, 1, 1), (1, 1, 3, 1);

insert into `customer_account` (order_id, customer_id, menu_item_id, item_quantity)
values (2, 2, 2, 1), (2, 2, 3, 2);

insert into `customer_account` (order_id, customer_id, menu_item_id, item_quantity)
values (3, 1, 3, 1), (3, 1, 4, 1);

-- Q4
select ca.customer_id, c.`name`,
	sum(m.pizza_price * ca.item_quantity) as `total`
from `customer_account` as ca
join customer as c on ca.customer_id = c.customer_id
join `menu` as m on ca.menu_item_id = m.menu_item_id
group by ca.customer_id;

-- Q5
select ca.customer_id, c.`name`, cast(o.date_time as date) date,
	sum(m.pizza_price * ca.item_quantity) as total
from `customer_account` as ca
join customer as c on ca.customer_id = c.customer_id
join `menu` as m on ca.menu_item_id = m.menu_item_id
join `order` as o on ca.order_id = o.order_id
group by ca.customer_id, o.date_time;
