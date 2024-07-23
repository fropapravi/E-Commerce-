# Problem Statement 1 

#1. What is the total revenue generated from each product category? 
  
    SELECT P.Productname as Product_category, (P.PRICE*T.Quantity) AS 
    TOTAL_REVENUE  
    FROM PRODUCTS P 
    left join transactions T 
    on P.Productid = T.Productid 
    
#2. Which customer made the highest number of transactions? 
  
    SELECT C.Customername as Customer, Count(T.Transactionid) as no_of_transaction 
    FROM Transactions T 
    left join Customers C 
    on T.Customerid = C.Customerid 
    group by Customers 
    order by no_of_transaction desc 
    limit 1 
  
#3. List products that have never been sold. 
  
    SELECT T.Quantity, P.Productname 
    FROM Transactions T 
    LEFT JOIN Products P 
    ON P.Productid = T.Productid  
    WHERE T.Quantity = 0 
  
#4. What is the average transaction value for each country? 
  
    SELECT C.Country, ROUND(AVG(P.Price)) AS AVERGE_TANSACTION 
    FROM Products P 
    LEFT JOIN Transactions T 
    ON P.Productid = T.Productid 
    LEFT JOIN Customer C 
    ON T.Customerid = C. Customerid 
    GROUP BY C.Country 
  
#5. Which product category is most popular in terms of quantity sold? 
  
    SELECT P.Category, MAX(T.Quantity) AS most_popular  
    FROM Products P  
    LEFT JOIN Transactions T 
    ON P.Productid = T.Productid 
    GROUP BY P.Category 
    order by most_popular desc 
    limit 1 
  
#6. Identify customers who have spent more than $1000 in total. 
  
    SELECT C.Customername 
    FROM Products P 
    LEFT JOIN Transactions T 
    ON P.Productid = T.Productid 
    LEFT JOIN Customers C 
    ON T.Customerid = C. Customerid 
    GROUP BY C.Customername 
    HAVING SUM(P.Price) > 1000 
  
#7. How many transactions involved purchasing more than one item ? 
  
    SELECT Count(Transactionid) AS No_Transaction 
    FROM Transactions  
    WHERE Quantity > 1 
  
#8. What is the difference in total sales between 'Electronics' and 'Furniture' categories? 
  
    select  
    sum(case when P.Category = 'Electronics' then 
    t.Quantity*P.Price else 0 end ) -  
    sum(case when P.Category = 'Furniture' then 
    T.Quantity*P.Price else 0 end ) as Total_Sales_Difference 
    from Products P 
    inner join Transactions T 
    on P.Productid = T.Productid 
  
#9. Which country has the highest average spending per transaction? 
  
    SELECT C.Country, ROUND(AVG(P.Price)) AS AVG_SPENT  
    FROM Customers C 
    LEFT JOIN Transctions T 
    ON C.Customerid = T. Customerid 
    LEFT JOIN Products P 
    ON T.Productid = P.Productid 
    GROUP BY C.Country 
  
#10. For each product, calculate the total revenue and categorize its sales volume as 'High' (more than $500), 'Medium' ($100-$500), or 'Low' (less than $100). 
  
    SELECT SUM(P.Price) AS TOTAL_REVENUE, P.Productname, 
    CASE  
    WHEN SUM(P.Price) >500 THEN 'HIGH' 
    WHEN SUM(P.Price) BETWEEN 100 AND 500 THEN 'MEDIUM' 
    WHEN SUM(P.Price)  < 100 THEN 'LOW' 
    END AS Categorize 
    FROM Products P 
    LEFT JOIN Transactions T 
    ON P.Productid=T.Productid 
    GROUP BY P.Productname 
    ORDER BY SUM(P.Price) DESC
