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
	regular boolean not null default false
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
	birth_date date not null,
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



drop table if exists shifts;


create table if not exists shifts (
    shift_id varchar(36) primary key,
    employee_id varchar(36),
    shift_name varchar(100) not null,
    start_time time not null,
    end_time time not null,
    foreign key (employee_id) references employees(id),
    check (start_time < end_time)
);


alter table shifts 
comment = 'Table to store shifts information';

alter table shifts
modify column shift_id varchar(36) comment 'Unique identifier for each shift',
modify column employee_id varchar(36) comment 'Unique identifier for each employee',
modify column shift_name varchar(100) comment 'Name of the shift',
modify column start_time time comment 'Start time of the shift',
modify column end_time time comment 'End time of the shift';

select * from shifts s;



drop table if exists salary; 

create table if not exists salary 
(
    employee_id varchar(36) primary key,
    salary_amount decimal(10, 2) not null,
    salary_date date not null,
    foreign key (employee_id) references employees(id),
    check (salary_amount > 0)
);

alter table salary 
comment = 'Table to store salary information';

alter table salary
modify column employee_id varchar(36) comment 'Unique identifier for each employee',
modify column salary_amount decimal(10, 2) not null comment 'Amount of salary',
modify column salary_date date not null comment 'Date of salary payment';

select * from salary;



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

select * from authors a;



drop table if exists books;

create table books
(
	id varchar(36) primary key,
	title varchar(200) not null,
	genre varchar(50) not null,
	price decimal(10, 2) not null,
	isbn varchar(36) not null,
	publication_year year not null,
	check (price > 0)
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

select * from books b;



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
	
select * from authors_books ab;


drop table book_orders;

create table book_orders
(
	id varchar(36) primary key,
	book_id varchar(36) not null, 
	customer_id varchar(36) not null,
	handled_by varchar(36) not null,
	order_date date not null,
	status varchar(36) not null,
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

select * from book_orders bo;



drop table if exists menu_categories;

create table if not exists menu_categories (
    id varchar(36) primary key,
    name varchar(200),
    description text
);

alter table menu_categories 
comment = 'Table to store menu categories';

alter table menu_categories  
modify column id varchar(36) comment 'Identifier for the menu category',
modify column name varchar(200) comment 'Name of the menu category',
modify column description text comment 'Decsription of the menu category';

select * from menu_categories mc;



drop table if exists menu;

create table if not exists menu (
    id varchar(36) primary key,
    name varchar(200) not null,
    description text,
    price decimal(10, 2) not null,
    category_id varchar(36),
    is_vegan boolean not null default false,
    is_gluten_free boolean not null default false,
    ingredients text,
    date_added date not null,
    is_available boolean not null default true,
    preparation_time int,
    calories int,
    image_url varchar(200),
    spicy_level int,
    allergens text,
    foreign key (category_id) references menu_categories(id),
    check (price > 0),
    check (preparation_time >= 0),
    check (calories >= 0),
    check (spicy_level >= 0)
);

alter table menu
comment = 'Table to store menu information';

alter table menu  
modify column id varchar(36) comment 'Identifier for the menu item',
modify column name varchar(200) comment 'Name of the menu item',
modify column description text comment 'Description of the menu item',
modify column price decimal(10, 2) comment 'Price of the menu item',
modify column category_id varchar(36) comment 'Identifier for the menu category',
modify column is_vegan boolean comment 'Is the menu item vegan',
modify column is_gluten_free boolean comment 'Is the menu item gluten-free',
modify column ingredients text comment 'Ingredients of the menu item',
modify column date_added date comment 'Date the menu item was added',
modify column is_available boolean comment 'Is the menu item available',
modify column preparation_time int comment 'Preparation time of the menu item',
modify column calories int comment 'Calories of the menu item',
modify column image_url varchar(200) comment 'Image url of the menu item',
modify column spicy_level int comment 'Spicy level of the menu item',
modify column allergens text comment 'Allergens of the menu item';

select * from menu m;



drop table if exists menu_orders;


create table if not exists menu_orders (
    id varchar(36) primary key,
    order_date datetime not null,
    customer_id varchar(36),
    menu_id varchar(36),
    quantity int not null,
    employee_id varchar(36),
    order_status varchar(50) not null,
    foreign key (customer_id) references customers(id),
    foreign key (menu_id) references menu(id),
    foreign key (employee_id) references employees(id),
    check (quantity > 0)
);

alter table menu_orders 
comment = 'Table to store menu orders';

alter table menu_orders
modify column id varchar(36) comment 'Identifier for the menu order',
modify column order_date datetime comment 'Date and time of the order',
modify column customer_id varchar(36) comment 'Identifier for the customer',
modify column menu_id varchar(36) comment 'Identifier for the menu item',
modify column quantity int comment 'Quantity of the menu item ordered',
modify column employee_id varchar(36) comment 'Identifier for the employee',
modify column order_status varchar(50) comment 'Status of the order';

select * from menu_orders mo;