-- Inspecting Data 
-- customer table
select * from sales.customers;
-- date table 
select * from sales.date;
-- markets table 
select * from sales.markets;
-- products table 
select * from sales.products;
-- transactions table
select * from sales.transactions;

-- checking unique values 

select distinct customer_type from sales.customers;
select distinct year from sales.date;
select distinct month_name from sales.date;
select distinct zone from sales.markets;
select distinct product_type from sales.products;
select distinct market_code from sales.transactions;
select distinct currency from sales.transactions;

-- total number of customers 
select count(*) from sales.customers;	

-- Show transactions for the chennai market for mark001

select * from sales.transactions where market_code = "Mark001";

-- Show transactions where currency in us dollar 

select * from sales.transactions where currency = 'USD';

-- show transaction in 2020 by join date 
select transactions.*, date.* from sales.transactions INNER JOIN sales.date on transactions.order_date = date.date where date.year = 2020;


-- Show total revenue in year 2020 
select sum(sales_amount) from sales.transactions inner join sales.date on transactions.order_date = date.date 
where date.year = 2020 and transactions.currency = 'INR' or transactions.currency = 'USD';

-- show total revenue in month of januray in year 2020

select sum(sales_amount) from sales.transactions inner join sales.date on transactions.order_date = date.date 
where date.year = 2020 and date.month_name= "January" and transactions.currency='INR';

-- show total revenue in year 2020 in chennai 
select sum(sales_amount) from sales.transactions inner join sales.date on transactions.order_date = date.date 
where date.year = 2020 and transactions.market_code = 'Mark001';

-- Show zone wise sales analysis 
select * from sales.markets;
select * from sales.transactions;

select transactions.*, markets.* from sales.transactions inner join sales.markets on transactions.market_code = markets.markets_code;
-- central zone 
select sum(sales_amount) from sales.transactions inner join sales.markets on transactions.market_code = markets.markets_code where zone = "Central";


select zone, sum(sales_amount) from sales.transactions inner join sales.markets on transactions.market_code = markets.markets_code 
group by zone
order by 2 desc;

-- markets analysis 

select markets_name, sum(sales_amount) from sales.transactions inner join sales.markets on transactions.market_code = markets.markets_code
group by markets_name
order by 2 desc;

-- products analysis 

select * from sales.products;
select * from sales.transactions;

select product_type, sum(sales_amount) from sales.transactions inner join sales.products on transactions.product_code = products.product_code
group by product_type
order by 2 desc;

-- Customer Analysis 

select customer_type, sum(sales_amount) from sales.transactions inner join sales.customers on transactions.customer_code = customers.customer_code 
group by customer_type 
order by 2 desc;