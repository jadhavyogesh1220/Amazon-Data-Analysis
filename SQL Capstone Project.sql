select * from odinschool.amazon;
SELECT * FROM INFORMATION_SCHEMA.tables;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'odinschool.amazon';

/*Feature Engineering*/

alter table odinschool.amazon add column timeofday varchar(30);
UPDATE odinschool.amazon
 SET timeofday = case 
				   when hour(time) between 6 AND 12 THEN 'Morning'
				   when hour(time) between 12 AND 18 THEN 'Afternoon'
				   when hour(time) between 18 AND 24 THEN 'Evening'
				End;
alter table odinschool.amazon add column dayname varchar(30);
UPDATE odinschool.amazon
 SET dayname = DAYNAME(date);   
 
alter table odinschool.amazon add column monthname varchar(30);
UPDATE odinschool.amazon
 SET monthname = MONTHNAME(date); 

select * from odinschool.amazon; 

/*1. What is the count of distinct cities in the dataset?*/

SELECT COUNT(distinct(city)) FROM odinschool.amazon;
SELECT DISTINCT(branch),city FROM odinschool.amazon;
SELECT COUNT(distinct(product_line)) FROM odinschool.amazon;
SELECT payment_method,count(*) FROM odinschool.amazon group by payment_method;
SELECT product_line,SUM(total) as sales FROM odinschool.amazon group by product_line ORDER BY sales DESC;
SELECT monthname,SUM(total) as revenue FROM odinschool.amazon GROUP BY monthname;
SELECT monthname,SUM(cogs) FROM odinschool.amazon GROUP BY monthname ;
SELECT product_line,SUM(total) as revenue FROM odinschool.amazon GROUP BY product_line order by revenue DESC;
SELECT city,SUM(total)as revenue FROM odinschool.amazon GROUP BY city order by revenue DESC;
SELECT product_line,SUM(VAT) as total_vat FROM odinschool.amazon GROUP BY product_line ORDER BY total_vat DESC;

/*SELECT AVG(sum_sales) FROM (SELECT product_line,sum(total) as sum_sales FROM odinschool.amazon 
GROUP BY product_line) as sales;*/

SELECT product_line, sum(total),
CASE
   WHEN sum(total)>= (SELECT AVG(sum_sales) FROM (SELECT product_line,sum(total) as sum_sales 
                     FROM odinschool.amazon GROUP BY product_line) as sales)
   THEN "Good"
   ELSE "Bad"
END AS SalesPerformance FROM odinschool.amazon GROUP BY product_line;

/*
SELECT AVG(sum_sales) FROM (SELECT product_line,sum(total) as sum_sales 
                     FROM odinschool.amazon GROUP BY product_line) as sales */


SELECT branch,sum(quantity) as total_products_sold FROM odinschool.amazon 
GROUP BY branch 
HAVING sum(quantity) >=(select sum(quantity)/count(distinct(branch)) FROM odinschool.amazon ); 

/*13*/
SELECT gender,product_line,count(*) FROM odinschool.amazon 
GROUP BY gender,product_line order by count(*) desc;

SELECT product_line,ROUND(avg(rating),2) AS avg_rating
FROM odinschool.amazon GROUP BY product_line ORDER BY avg_rating DESC;

SELECT dayname,timeofday,count(total) as sales FROM odinschool.amazon 
GROUP BY dayname,timeofday ORDER BY dayname,timeofday;


SELECT customer_type,sum(total) as revenue FROM odinschool.amazon GROUP BY customer_type;


SELECT city,MAX(VAT) as max_vat FROM odinschool.amazon 
GROUP BY city order by max_vat DESC;

SELECT customer_type,SUM(VAT) as total_VAT FROM odinschool.amazon 
GROUP BY customer_type order by total_VAT DESC;

SELECT COUNT(DISTINCT(customer_type)) FROM odinschool.amazon;

SELECT COUNT(DISTINCT(payment_method)) FROM odinschool.amazon;

/*21*/
SELECT customer_type,COUNT(*) FROM odinschool.amazon GROUP BY customer_type;

SELECT customer_type,count(total) FROM odinschool.amazon GROUP BY customer_type;

SELECT gender,COUNT(*) FROM odinschool.amazon GROUP BY gender;

SELECT branch,gender,COUNT(*) FROM odinschool.amazon 
GROUP BY branch,gender ORDER BY branch,gender;

SELECT timeofday,COUNT(rating) FROM odinschool.amazon GROUP BY timeofday;

SELECT branch,timeofday,COUNT(*) as rating_count FROM odinschool.amazon 
GROUP BY branch,timeofday ORDER BY rating_count DESC;

SELECT dayname,ROUND(AVG(rating),2) as avg_Rating FROM odinschool.amazon 
GROUP BY dayname ORDER BY avg_Rating DESC;

SELECT dayname,branch,ROUND(AVG(rating),2) as avg_Rating FROM odinschool.amazon 
GROUP BY dayname,branch ORDER BY avg_Rating DESC;



