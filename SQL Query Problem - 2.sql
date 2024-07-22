#Problem Statement 2

#1.  How much revenue was generated each day of the sale? 
  
    SELECT SUM(P.Originalprice*S.Quantitysold) as Revenue, 
    S.Saledate 
    FROM Products p 
    LEFT JOIN  
    Sales S 
    ON P.Productid = S.Productid 
    WHERE S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' 
    GROUP BY S.Saledate 
  
#2. Which product had the highest sales volume during the sale? 
    SELECT SUM(P.Originalprice*S.Quantitysold) as revenue, 
    S.Saledate 
    FROM Products P 
    LEFT JOIN  
    Sales S 
    ON P.Productid = S.Productid 
    WHERE S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' 
    GROUP BY S.Saledate 
  
#3. What was the total discount given during the sale period? 
  
    SELECT  
    ROUND(SUM(P.Originalprice * S.Quantitysold * P.Discountrate / 100)) AS 
    total_discount, 
    P.Productname 
    FROM  Products P 
    LEFT JOIN  
    Sales s ON P.Productid = S.Productid 
    WHERE S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' 
    GROUP BY  P.Productname 
  
#4.  How does the sale performance compare in terms of units sold before and during the sale? 
  
    SELECT 
    SUM(CASE WHEN S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' THEN 
    S.Quantitysold ELSE 0 END) AS units_sold_during_sale, 
    SUM(CASE WHEN S.Saledate < '2023-03-01' OR S.Saledate > '2023-03-09' THEN 
    S.Quantitysold ELSE 0 END) AS units_sold_before_sale 
    FROM Sales S 
  
#5. What was the average discount rate applied to products sold during the sale? 
  
    SELECT ROUND(AVG(P.Discountrate),1) AS average_discount 
    FROM Products P 
    LEFT JOIN Sales S 
    ON P.Productid = S.Productid 
    WHERE S.Saledate BETWEEN '2022-03-11' AND '2023-03-17' 
  
#6. Which day had the highest revenue, and what was the top-selling product on that day? 
  
    SELECT ROUND(SUM(P.OriginalPrice * S.QuantitySold * (1 - P.DiscountRate / 100))) 
    AS Revenue, 
    S.Saledate AS Date, 
    P.Productname 
    FROM Products P 
    RIGHT JOIN  
    Sales S ON P.Productid = S.Productid 
    GROUP BY S.Saledate, P.Productname 
    ORDER BY Revenue DESC 
  
#7. How many units were sold per product category during the sale?  
  
    SELECT CASE  
    WHEN P.Productid =  1 then 'Laptop' 
    WHEN P.Productid = 2 then 'Smartphone' 
    WHEN P.Productid = 3 then  'Headphones' 
    WHEN P.Productid = 4 THEN 'E-Reader' 
    ELSE 'Other' 
    END AS Category, 
    SUM(S.QuantitySold) AS units_sold 
    FROM Sales S 
    INNER JOIN  
    Products P ON S.Productid = P.Productid 
    WHERE S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' 
    GROUP BY Category 
  
#8. What was the total number of transactions each day? 
  
    SELECT S.Saledate, COUNT(S.Quantitysold), SUM(P.Originalprice) as Revenue 
    FROM Products P 
    LEFT JOIN Sales S 
    ON P.Productid = S.Productid 
    WHERE S.Saledate BETWEEN '2022-03-11' AND '2023-03-17' 
    GROUP BY S.Saledate 
    ORDER BY S.Saledate ASC 
  
#9. Which product had the largest discount impact on revenue? 
  
    SELECT P.Productname, ROUND(SUM(P.OriginalPrice * S.QuantitySold * 
    P.DiscountRate / 100)) AS Discount_Impact 
    FROM Products P 
    INNER JOIN  
    sales s ON P.Productid = S.Productid 
    GROUP BY P.Productname 
    ORDER BY Discount_Impact DESC 
    LIMIT 1
