use bookrestaurant_db;

drop index idx_book_price
    on books;
  
drop index idx_order_date
    on book_orders;



-- Non-optimized

explain analyze 
select
    (select cnt
     from (select count(*) as cnt
           from (select bo.id, bo.order_date, bo.book_id, b.title, b.price
                 from book_orders as bo
                 join books as b on bo.book_id = b.id
                 join customers as c on bo.customer_id = c.id
                 where bo.order_date > '2024-06-01'
                 and b.price > 20
                 and c.regular = True) as sub1
           ) as sub2
     limit 1) as count_orders,

    (select sm 
     from (select sum(price) as sm
           from (select bo.id, bo.order_date, bo.book_id, b.title, b.price
                 from book_orders as bo
                 join books as b on bo.book_id = b.id
                 join customers as c on bo.customer_id = c.id
                 where bo.order_date > '2024-06-01'
                 and b.price > 20
                 and c.regular = True) as sub3
           ) as sub4
     limit 1) as orders_value;
           
           
           
           
          
    


    
    
    


-- Optimized

create index idx_book_price
    on books(price);
  
create index idx_order_date
    on book_orders(order_date);
   

explain analyze
with cte as (
    select count(*) as count_orders, sum(b.price) as orders_value
    from book_orders as bo
    join books as b on bo.book_id = b.id
    join customers as c on bo.customer_id = c.id
    where bo.order_date > '2024-06-01'
    and b.price > 20
    and c.regular = True
    )

select * from cte;  
