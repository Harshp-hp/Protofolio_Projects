-- Inspecting Data 
select * from sales_data.sales_data_sample;

-- Checking Unique Values 

select distinct status from sales_data.sales_data_sample;
select distinct year_id from sales_data.sales_data_sample;
select distinct month_id from sales_data.sales_data_sample;
select distinct PRODUCTLINE from sales_data.sales_data_sample;
select distinct country from sales_data.sales_data_sample;
select distinct dealsize from sales_data.sales_data_sample;
select distinct territory from sales_data.sales_data_sample;
select distinct productcode from sales_data.sales_data_sample;


-- Analysis 
-- Grouping sales

-- Productline 
select Productline, sum(Sales) Revenue from sales_data.sales_data_sample group by productline order by 2 desc;
-- Year Wise 
select year_id, sum(Sales) Revenue from sales_data.sales_data_sample group by year_id order by 2 desc;
-- Dealsize
select dealsize, sum(Sales) Revenue from sales_data.sales_data_sample group by dealsize order by 2 desc;

-- What was the best month for the sales in a specific year? How much was earned that month?
select month_id, sum(Sales)  Revenue, count(ORDERNUMBER) Frequency from sales_data.sales_data_sample 
where year_id = 2004 
group by month_id 
order by 2 desc;  

-- November and Octomber month are the best sales month in 2004 year.. 

-- year 2003

select month_id, sum(sales) Revenve, count(ORDERNUMBER) Frequnecy from sales_data.sales_data_sample
where year_id = 2003 
group by month_id
order by 2 desc; 

-- In year 2003 November month was the best sales month!

-- Year 2005 

select month_id , Sum(sales) Revenue, count(ORDERNUMBER) Frequency from sales_data.sales_data_sample 
where year_id = 2005 
group by month_id 
order by 2 desc;

-- In Year 2005, may month has most sales..

-- November seems to be the month, whar product do they sell in November ??

select month_id, productline, sum(sales) Revenue, count(ORDERNUMBER) Frequnecy from sales_data.sales_data_sample
where year_id = 2004 and month_id = 11
group by month_id, productline 
order by 3 desc;


select month_id, productline, sum(Sales) Revenue, count(ORDERNUMBER) Frequnecy from sales_data.sales_data_sample
where year_id = 2003 and month_id =11 
group by month_id, productline 
order by 3 desc;

-- In year 2004 & 2003 of November month  "Classic Cars" were sold most.


-- Who is our best customer??

with rfm as 
(
	select 
			CustomerName,
            sum(Sales) MonetaryValue,
            avg(Sales) AvgMonetaryValue,
            count(ORDERNUBMER) Frequnecy,
            max(ORDERDATE) last_order_date,
            (select max(ORDERDATE) from sales_data.sales_data_sample) max_order_date,
			DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from sales_data.sales_data_sample)) Recency
      from sales_data.sales_data_sample
	  group by CUSTOMERNAME
),
rfm_calc as
(
	select r.*,
			NTILE(5) over (order by Recency desc) rfm_recency,
            NTILE(5) over (order by Frequency) rfm_frequency,
            NTILE(5) over (order by MonetaryValue) rfm_monetary
   from rfm r
)
select 
		c.*, rfm_recency+rfm_frequnecy+rfm_monetary as rfm_cell
from rfm_calc c        