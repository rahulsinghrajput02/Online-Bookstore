create table Books(
Book_ID	serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);

drop table customers;
create table Customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone int,
City varchar(100),
Country varchar(100)
);


create table Orders(
Order_ID serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date Date,
Quantity int,
Total_Amount numeric(10,2)
);
drop table Orders;


select * from Books;
select * from Customers;
select * from Orders;



-- Retrive all books in the "Fiction" genre.


Select * From Books
Where genre = 'Fiction';

-- Find Books Published after the year 1950


Select * From Books
Where published_year>1950;

-- List all customers from the Canada;

Select * from Customers
Where country = 'Canada';

-- Show orders Placed in November 2023;

Select * from Orders
Where order_date between '2023-11-01' and '2023-11-30';

-- Find the details of the most expensive book:

select * from Books
order by price desc
limit 1;



-- Retrive the total stock of books available

select sum(stock) as total_stock from Books; 


-- Show all customers who ordered moore than 1 quantity of a book;
Select * From orders
Where quantity > 1;

-- Retrieve all orders where the total amount exceed $20

Select * From orders
Where total_amount>20;

-- List all genres available in the Books table:

Select distinct genre From books;

-- Find the book with the lowest stock:

select * from books 
order by stock 
limit 1;

-- Calculate the total revenue generated from all orders:
select sum(total_amount) from orders;

-- Advance Questions:

-- Retrieve the total number of book sold for each genre:

select b.genre, sum(o.quantity) Total_Book_Sold
from books b
join orders o
on b.book_id = o.book_id
group by genre;

-- Find the average price of books in the "Fantasy" genre:
select round(avg(price),2) avg_price from books
where genre = 'Fantasy'

-- List Customers who have placed at least 2 orders:

select customer_id, count(order_id) from orders
group by customer_id
having  count(order_id)>=2;

-- Find the most frequently ordered book:

select * from books;
select * from orders;

select o.book_id,b.title , count(o.order_id) order_count
from orders o
join books b
on o.book_id = b.book_id
group by o.book_id,b.title order by order_count desc limit 1;

-- Show the top 3 most expensive books of "Fantasy" Genre:
select book_id, title, price from books
where genre = 'Fantasy'
order by price desc limit 3;

-- Retrive the total quantity of books sold by each author:

select * from books;
select * from orders;

select b.author, sum(o.quantity) total_quantity from books b
join orders o
on b.book_id = o.book_id
group by author order by total_quantity desc ;

-- List the cities where customers who  spent over $30 are located:

select distinct c.city, o.total_amount
from orders o
join customers c
on c.customer_id = o.customer_id
where total_amount > 30

-- Find the customer who spent the most on orders:

select c.customer_id,c.name , sum(total_amount) total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id,c.name order by total_spent desc limit 1;

-- Calculate the stoke remaining after fulfilling all orders:


select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0),
b.stock-coalesce(sum(o.quantity),0) stoke_remaining
from books b
left join orders o
on b.book_id = o.book_id
group by b.book_id