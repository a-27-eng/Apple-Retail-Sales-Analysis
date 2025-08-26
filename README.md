Apple-Retail-Sales-Analysis
Advanced SQL Analysis of Apple Retail Sales Data This project demonstrates advanced SQL querying techniques on a dataset of over 1 million rows from Apple retail sales. It showcases a wide range of analytical skills, including optimizing query performance, solving real-world business problems, and extracting actionable insights from large datasets. Table of Contents

Project Overview
•	Database Schema
•	Skills Highlighted
•	Key Business Questions Solved
•	Performance Optimization
This project is designed to analyze Apple retail sales data, providing insights into store performance, product trends, and warranty claims. By leveraging advanced SQL features, the project addresses real-world business challenges and showcases efficient data processing techniques.

Database Schema 
The database consists of five main tables: • stores: Information about Apple retail stores (e.g., store ID, name, city, country). 
• category: Product categories (e.g., category ID, category name). 
• products: Details about Apple products (e.g., product ID, name, launch date, price). 
• sales: Sales transactions (e.g., sale date, store ID, product ID, quantity). 
• warranty: Warranty claims (e.g., claim date, repair status). 

Skills Highlighted
 • Performance Optimization: Created indexes to enhance query execution speeds significantly. 
• Window Functions: Used for running totals, ranking, and growth analysis.
 • Complex Joins and Aggregations: Combined data from multiple tables to derive meaningful insights.
 • Data Segmentation: Analyzed trends across various timeframes and regions. 
• Correlation Analysis: Explored relationships between variables like product price and warranty claims.




Key Business Questions Solved

1.Find the number of stores in each country.
2.Calculate the total number of units sold by each store.
3.Identify how many sales occurred in December 2023.
4.Determine how many stores have never had a warranty claim filed.
5.Calculate the percentage of warranty claims marked as "Warranty Void".
6.Identify which store had the highest total units sold in the last year.
7.Count the number of unique products sold in the last year.
8.Find the average price of products in each category.
9.How many warranty claims were filed in 2020?
10.For each store, identify the best-selling day based on highest quantity sold.
11.Identify the least selling product in each country for each year based on total units sold.
12.Calculate how many warranty claims were filed within 180 days of a product sale.
13.Determine how many warranty claims were filed for products launched in the last two years.
14.List the months in the last three years where sales exceeded 5,000 units in the USA.
15.Identify the product category with the most warranty claims filed in the last two years.
16.Determine the percentage chance of receiving warranty claims after each purchase for each country.
17.Analyze the year-by-year growth ratio for each store.
18.Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
19.Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.
20.Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.


This project was all about analyzing Apple retail sales data with over 1 million rows. The dataset included detailed information about products, sales transactions, stores, and warranty claims from various Apple retail locations worldwide. The goal was to solve real-world business problems using advanced SQL techniques.

I started by exploring the data to understand the schema. There were five main tables: stores, sales, products, category, and warranty. Each table contributed unique data dimensions, like store locations, product details, and sales trends.

I worked on solving key business problems like identifying the total sales for each store, finding the best-selling products, analyzing warranty claim trends, and even determining year-over-year growth for stores. For example, I calculated the percentage of warranty claims rejected and identified stores with the highest sales in the last year.

I also implemented advanced SQL techniques like window functions for ranking and running totals, indexing to optimize query performance, and correlation analysis to see relationships between product price and warranty claims.
