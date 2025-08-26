create database apple_db;

use apple_db;


create table stores(
store_id varchar(10) Primary key,
store_name varchar(30),
city varchar(30),
country varchar(30)
);

select * from stores;

#CAREGORIES TABLE

create table category(
category_id varchar(10) primary key,
category_name varchar(30)
);

select * from category;

#PRODUCTS TABLE

create table products(
product_id varchar(10) primary key,
product_name varchar(35),
category_id varchar(10),
launch_date date,
price float,
constraint fk_category foreign key (category_id) references category(category_id)
);

select * from products;

#SALES TABLE

create table sales(
sale_id varchar(10) primary key,
sale_date date,
store_id varchar(10),
product_id varchar(10),
quantity int,
constraint fk_store foreign key (store_id) references stores(store_id),
constraint fk_product foreign key (product_id) references products(product_id)
);

select count(*) from sales;

SELECT store_id FROM stores;

#WARRANTY TABLE

create table warranty(
claim_id varchar(10) primary key,
claim_date date,
sale_id varchar(10),
repair_status varchar(20),
constraint fk_sale foreign key (sale_id) references sales(sale_id)
);

select * from warranty;

#Find the number of stores in each country
select count(store_id)
from stores;

#2.Calculate the total number of units sold by each store.
select st.store_id,st.store_name,sum(s.quantity) as total_quantity
from sales s
join
stores st
on st.store_id=s.store_id
group by 1,2
order by 3 desc

#3Identify how many sales occurred in December 2023
select count(sale_id)  
from sales
where year(sale_date)=2023

#4.Determine how many stores have never had a warranty claim filed.
select * from stores
where store_id not in (
select distinct s.store_id  from
sales as s
right join warranty as w
on s.sale_id=w.sale_id)

#5.Calculate the percentage of warranty claims marked as "Pending".
select count(claim_id)/(select count(*) from warranty)*100 as percentage_of_pending
 from warranty
where repair_status ='Pending'

#6 Identify which store had the highest total units sold in the last year.
select st.store_id,st.store_name,s.sale_date
 from stores st
join sales s 
on st.store_id=s.store_id
where year(sale_date)=2024
order by s.sale_date desc
limit 1

#7.Count the number of unique products sold in the last year.
select count(distinct product_id) from products
where year(launch_date)=2024

#8.Find the average price of products in each category.
select category_id,avg(price) from 
products
group by category_id
order by 1 asc

#9.How many warranty claims were filed in 2020?
select count(*) from warranty
where year(claim_date)=2020

#10.For each store, identify the best-selling day based on highest quantity sold.
SELECT *
FROM (
    SELECT 
        store_id,
        DAYNAME(sale_date) AS day_name,
        SUM(quantity) AS total_unit_sold,
        RANK() OVER (PARTITION BY store_id ORDER BY SUM(quantity) DESC) AS rnk
    FROM sales
    GROUP BY store_id, DAYNAME(sale_date)
) AS t
WHERE rnk = 1;

#11.Identify the least selling product in each country for each year based on total units sold.
select * 
from
(SELECT 
        st.country,
        YEAR(s.sale_date) AS year,
        p.product_name,
        SUM(s.quantity) AS total_units_sold,
        RANK() OVER (
            PARTITION BY st.country, YEAR(s.sale_date)
            ORDER BY SUM(s.quantity) ASC
        ) AS rnk
    FROM sales s
    JOIN stores st 
        ON st.store_id = s.store_id
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY st.country, YEAR(s.sale_date), p.product_name
) as t1
where rnk=1


#12.Calculate how many warranty claims were filed within 180 days of a product sale.
select count(*)
from warranty w
left join sales s
on s.sale_id=w.sale_id
where datediff(w.claim_date,s.sale_date) =180

#13.Determine how many warranty claims were filed for products launched in the last two years.
SELECT 
p.product_name,count(w.claim_id) as no_claim,count(s.sale_id) as number_
FROM warranty w
LEFT JOIN sales s
    ON s.sale_id = w.sale_id
    join products as p
  on  p.product_id=s.product_id
WHERE w.claim_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

#14.List the months in the last three years where sales exceeded 5,000 units in the USA.
select month(s.sale_date) as month,
sum(s.quantity) as total_units_sold
from sales s
join stores st
on st.store_id=s.store_id
where st.country='United States'
and s.sale_date>=date_sub(curdate(),interval 3 year)
group by 1
having total_units_sold>5000

#15.Identify the product category with the most warranty claims filed in the last two years.
select c.category_name,count(w.claim_id) as number_of_claims 
from 
warranty w
left join sales s
on s.sale_id=w.sale_id
join products p
on p.product_id=s.product_id
join category c
on c.category_id=p.category_id
where w.claim_date>= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
group by 1;

#16.Determine the percentage chance of receiving warranty claims after each purchase for each country.
SELECT 
    country,
    total_units_sold,
    total_claims,
    (total_claims / NULLIF(total_units_sold, 0)) * 100 AS risk
FROM (
    SELECT 
        st.country AS country,
        SUM(s.quantity) AS total_units_sold,
        COUNT(w.claim_id) AS total_claims
    FROM stores st
    JOIN sales s ON s.store_id = st.store_id
    LEFT JOIN warranty w ON w.sale_id = s.sale_id
    GROUP BY st.country
) t1
ORDER BY risk DESC;

#17.Analyze the year-by-year growth ratio for each store.
with yearly_sales as
(select s.store_id,st.store_name,year(s.sale_date) as year,sum(s.quantity * p.price) as total_sale
from
sales s
join products p
on s.product_id=p.product_id
join stores st
on st.store_id=s.store_id
group by 1,2,3
order by 2,3),
growth_ratio as
(select store_name,year,lag(total_sale,1) over (partition by store_name order by year) as last_year_sale,
total_sale as current_year_sale
from yearly_sales)
select store_name,year,last_year_sale,current_year_sale,
(current_year_sale-last_year_sale)/(last_year_sale)*100 as growth_ration
from growth_ratio where last_year_sale is not null

#18.Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
SELECT 
    CASE  
        WHEN p.price < 500 THEN 'less expense product'
        WHEN p.price BETWEEN 500 AND 1000 THEN 'buyable'
        ELSE 'expensive'
    END AS price_segmented,
    COUNT(w.claim_id) AS total_claims
FROM warranty w 
LEFT JOIN sales s
    ON w.sale_id = s.sale_id
JOIN products p
    ON p.product_id = s.product_id
WHERE w.claim_date >= CURDATE() - INTERVAL 5 YEAR
GROUP BY price_segmented;

#19.Identify the store with the highest percentage of "pending" claims relative to total claims filed.
with pending_claims as
(select s.store_id,count(claim_id) as pending_claims
from warranty w
left join sales s
on w.sale_id=s.sale_id
where w.repair_status='Pending'
group by store_id),
total_claims as
(select s.store_id,count(claim_id) as total_claims
from warranty w
left join sales s
on w.sale_id=s.sale_id
group by store_id)
select p.store_id,pending_claims,total_claims,round((pending_claims/total_claims)*100,2) as ratio
from
pending_claims p
join total_claims t
on p.store_id=t.store_id
order by ratio desc

#20.Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.
with monthly_sales as
(select s.store_id,year(s.sale_date) as year ,month(s.sale_date) as month,sum(p.price*s.quantity) as total_revenue
from sales s
join products p
on s.product_id=p.product_id
group by 1,2,3
order by 1,2,3)
select store_id,year,month,total_revenue,sum(total_revenue) over (partition by store_id order by year,month) as running_sum
from monthly_sales

