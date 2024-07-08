drop database bookrestaurant_db;

create database if not exists bookrestaurant_db;

use bookrestaurant_db;




drop table if exists customers;

create table if not exists customers
(
	id varchar(36) primary key,
	first_name varchar(200) not null,
	last_name varchar(200) not null,
	email varchar(200) not null,
	phone varchar(50) not null,
	birth_date date,
	regular boolean
);


alter table customers
comment = 'Table to store customers information';

alter table customers
modify column id varchar(36) comment 'Unique identifier for each customer',
modify column first_name varchar(200) not null comment 'First name of the customer',
modify column last_name varchar(200) not null comment 'Last name of the customer',
modify column email varchar(200) not null comment 'Email address of the customer',
modify column phone varchar(50) not null comment 'Phone number of the customer',
modify column birth_date date not null comment 'Birth date of the customer',
modify column regular boolean not null comment 'Regular or not customer';


select * from customers;



drop table if exists employees;

create table if not exists employees
(
	id varchar(36) primary key,
	first_name varchar(200) not null,
	last_name varchar(200) not null,
	email varchar(200) not null,
	phone varchar(50) not null,
	birth_date date,
	position varchar(200) not null
);


alter table employees 
comment = 'Table to store employees information';

alter table employees
modify column id varchar(36) comment 'Unique identifier for each employee',
modify column first_name varchar(200) not null comment 'First name of the employee',
modify column last_name varchar(200) not null comment 'Last name of the employee',
modify column email varchar(200) not null comment 'Email address of the employee',
modify column phone varchar(50) not null comment 'Phone number of the employee',
modify column birth_date date not null comment 'Birth date of the employee',
modify column position varchar(200) not null comment 'Position of the employee';

select * from employees e;


drop table if exists authors;

create table authors
(
	id varchar(36) primary key,
	first_name varchar(200) not null,
	last_name varchar(200) not null,
	biography text
);


alter table authors 
comment = 'Table to store authors information';

alter table authors
modify column id varchar(36) comment 'Unique identifier for each author',
modify column first_name varchar(200) not null comment 'First name of the author',
modify column last_name varchar(200) not null comment 'Last name of the author',
modify column biography text comment 'Biography of the author';


drop table if exists books;

create table books
(
	id varchar(36) primary key,
	title varchar(200) not null,
	genre varchar(50) not null,
	price decimal(10, 2) not null,
	isbn varchar(36) not null,
	publication_year year not null 
);
	
	
alter table books 
comment = 'Table to store books information';

alter table books
modify column id varchar(36) comment 'Unique identifier for each book',
modify column title varchar(200) not null comment 'Title of the book',
modify column genre varchar(50) not null comment 'Genre of the book',
modify column price decimal(10, 2) not null comment 'Price of the book',
modify column isbn varchar(36) not null comment 'ISBN of the book',
modify column publication_year year not null comment 'Publication year of the book';


drop table if exists authors_books;

create table authors_books(
	author_id varchar(36),
	book_id varchar(36),
	foreign key (author_id) references authors(id)
	on delete cascade,
	foreign key (book_id) references books(id)
	on delete cascade
);


alter table authors_books 
comment = 'Table to store relationship between authors and books';

alter table authors_books
modify column author_id varchar(36) comment 'Identifier for the author',
modify column book_id varchar(36) comment 'Identifier for the book';
	

drop table book_orders;

create table book_orders
(
	id varchar(36) primary key,
	book_id varchar(36), 
	customer_id varchar(36),
	handled_by varchar(36),
	order_date date not null,
	status varchar(36),
	foreign key (customer_id) references customers(id),
	foreign key (book_id) references books(id),
	foreign key (handled_by) references employees(id)
);

alter table book_orders
comment = 'Table to store book orders information';

alter table book_orders 
modify column id varchar(36) comment 'Identifier for the book order',
modify column book_id varchar(36) comment 'Identifier for the book',
modify column customer_id varchar(36) comment 'Identifier for the customer',
modify column handled_by varchar(36) comment 'Identifier for the cashier',
modify column order_date date comment 'Date of the book order',
modify column status varchar(36) comment 'Status of the book order';


drop table if exists menu;

create table if not exists menu (
    id varchar(36) primary key,
    name varchar(200) not null,
    description text,
    price decimal(10, 2) not null,
    category_id varchar(36),
    is_vegan boolean,
    -- default false,
    is_gluten_free boolean,
    -- default false,
    ingredients text,
    date_added date not null,
    is_available boolean,
    -- default true,
    preparation_time int,
    calories int,
    image_url varchar(200),
    spicy_level int,
    allergens text,
    foreign key (category_id) references menu_categories(id)
);

select * from menu m;


alter table menu
comment = 'Table to store menu information';


drop table if exists menu_categories;

create table if not exists menu_categories (
    id varchar(36) primary key,
    name varchar(200),
    description text
) comment 'table to store menu categories';


select * from menu_categories mc;

drop table if exists menu_orders;


create table if not exists menu_orders (
    id varchar(36) primary key,
    order_date datetime not null,
    customer_id varchar(36),
    menu_id varchar(36),
    quantity int not null,
    employee_id varchar(36),
    order_status varchar(50) not null,
    -- default 'pending',
    -- reservation_id varchar(36),
    foreign key (customer_id) references customers(id),
    foreign key (menu_id) references menu(id),
    foreign key (employee_id) references employees(id)
    -- foreign key (reservation_id) references reservations(id)
) comment 'table to store customer orders for menu items, including quantity, total price, and status';
