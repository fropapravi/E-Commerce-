# E- Commerce analysis case study [1 & 2] PSQL

## Objective: 
To analyze sales data to derive insights of E-commerce for developing marketing strategy and make appropriate decisions.

## Operations
- Aggreagate
- Filters (WHERE, GROUP BY, HAVING, LIMITS)
- Joins (LEFT JION, RIGHT JOIN, FULL JOIN)
- Windows Function (ROW_NUMBERS, RANK, DENS_RANK)
- CTE tables

## Steps to Form Tables as Follows For Case - 1

- Create Customers table

``` sql
#Customers Table

CREATE TABLE IF NOT EXISTS Customers ( 
CustomerID INT PRIMARY KEY, 
CustomerName VARCHAR(100), 
Country VARCHAR(50) 
); 
```

- Insert into Customer table

```sql
INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES 
(1, 'John Doe', 'USA'), 
(2, 'Jane Smith', 'Canada'), 
(3, 'Emily Jones', 'UK'), 
(4, 'Chris Brown', 'USA'); 
```
- Create Products table

```sql
CREATE TABLE IF NOT EXISTS Products ( 
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(100), 
Price DECIMAL(10, 2), 
Category VARCHAR(50) 
); 
```

- Insert into Products table

```sql
INSERT INTO Products (ProductID, ProductName, Price, Category) VALUES 
(1, 'Laptop', 1200.00, 'Electronics'), 
(2, 'Smartphone', 700.00, 'Electronics'), 
(3, 'Book', 15.00, 'Books'), 
(4, 'Table', 150.00, 'Furniture'); 
```
- Create Transactions Table 

```sql
CREATE TABLE IF NOT EXISTS Transactions ( 
TransactionID INT PRIMARY KEY, 
CustomerID INT, 
ProductID INT, 
Quantity INT, 
TransactionDate DATE 
); 

```
- Insert into Transactions Table 

```sql
INSERT INTO Transactions (TransactionID, CustomerID, ProductID, Quantity, 
TransactionDate) VALUES 
(1, 1, 1, 1, '2023-03-15'), 
(2, 2, 2, 1, '2023-03-15'), 
(3, 3, 3, 2, '2023-03-16'), 
(4, 4, 4, 3, '2023-03-17'), 
(5, 1, 3, 1, '2023-03-18'); 

```

## Query for the Marketing Questions

- What is the total revenue generated from each product category? 
  
```sql
SELECT 
  P.Productname 
AS 
  Product_category, 
  (P.PRICE*T.Quantity) 
AS 
  Total_revenue 
FROM 
  Products P 
LEFT JOIN
  transactions T 
ON 
  P.Productid = T.Productid 
  ```

- Which customer made the highest number of transactions? 

```sql
SELECT 
  C.Customername 
AS 
  Customer, 
  Count(T.Transactionid) 
AS 
  no_of_transaction 
FROM 
  Transactions T 
LEFT JOIN
  Customers C 
ON
  T.Customerid = C.Customerid 
GROUP BY 
  Customers 
ORDER BY
  no_of_transaction 
DESC
LIMIT 1 
```

- List products that have never been sold. 
  
```sql
SELECT 
  T.Quantity,
  P.Productname 
FROM
  Transactions T 
LEFT JOIN 
  Products P 
ON 
  P.Productid = T.Productid  
WHERE 
  T.Quantity = 0 
  ```

- What is the average transaction value for each country? 

```sql
SELECT 
  C.Country, 
  ROUND(AVG(P.Price)) 
AS 
  AVERGE_TANSACTION 
FROM 
  Products P 
LEFT JOIN 
  Transactions T 
ON 
  P.Productid = T.Productid 
LEFT JOIN 
  Customer C 
ON 
  T.Customerid = C. Customerid 
GROUP BY 
  C.Country 
```

- Which product category is most popular in terms of quantity sold? 

```sql
SELECT 
  P.Category, 
  MAX(T.Quantity) 
AS 
  most_popular  
FROM 
  Products P  
LEFT JOIN 
  Transactions T 
ON 
  P.Productid = T.Productid 
GROUP BY
  P.Category 
ORDER BY
  most_popular desc 
LIMIT 1 
```
- Identify customers who have spent more than $1000 in total?
```sql
SELECT 
  C.Customername 
FROM 
  Products P 
LEFT JOIN 
  Transactions T 
ON 
  P.Productid = T.Productid 
LEFT JOIN 
  Customers C 
ON 
  T.Customerid = C. Customerid 
GROUP BY 
  C.Customername 
HAVING 
  SUM(P.Price) > 1000 
  ```

- How many transactions involved purchasing more than one item ? 
```sql
SELECT 
  COUNT(Transactionid) 
AS 
  No_Transaction 
FROM 
  Transactions  
WHERE 
  Quantity > 1 
  ```
- What is the difference in total sales between 'Electronics' and 'Furniture' categories? 
```sql 
SELECT  
  SUM(CASE 
      WHEN P.Category = 'Electronics' THEN
      T.Quantity*P.Price else 0 end ) -  
  SUM(CASE 
      WHEN P.Category = 'Furniture' THEN
      T.Quantity*P.Price else 0 END ) 
AS
  Total_Sales_Difference 
FROM 
  Products P 
INNER JOIN 
  Transactions T 
ON 
  P.Productid = T.Productid 
  ```
- Which country has the highest average spending per transaction? 
```sql
SELECT 
  C.Country, 
  ROUND(AVG(P.Price)) 
AS 
  AVG_SPENT  
FROM 
  Customers C 
LEFT JOIN 
  Transactions T 
ON 
  C.Customerid = T. Customerid 
LEFT JOIN 
  Products P 
ON 
  T.Productid = P.Productid 
GROUP BY 
  C.Country 
  ```
- For each product, calculate the total revenue and categorize its sales volume as 'High' (more than $500), 'Medium' ($100-$500), or 'Low' (less than $100). 
```sql
SELECT 
  SUM(P.Price) 
AS 
  Total_revenue, 
  P.Productname, 
  CASE  
    WHEN SUM(P.Price) >500 THEN 'HIGH' 
    WHEN SUM(P.Price) BETWEEN 100 AND 500 THEN 'MEDIUM' 
    WHEN SUM(P.Price)  < 100 THEN 'LOW' 
END AS 
  Categorize 
FROM 
  Products P 
LEFT JOIN 
  Transactions T 
ON 
  P.Productid=T.Productid 
GROUP BY 
  P.Productname 
ORDER BY 
  SUM(P.Price) 
DESC
```
------ End of Query 1 ------
## Steps to Form Tables as Follows For Case - 2

- Products Table

```sql
CREATE TABLE IF NOT EXISTS Products ( 
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(100), 
OriginalPrice DECIMAL(10, 2), 
DiscountRate DECIMAL(5, 2)  -- Discount rate as a percentage, e.g., 10% discount is 
represented as 10. 
); 
```

- Insert into Products Table

```sql
INSERT INTO Products (ProductID, ProductName, OriginalPrice, DiscountRate) VALUES 
(1, 'Laptop', 1200.00, 15), 
(2, 'Smartphone', 700.00, 10), 
(3, 'Headphones', 150.00, 5), 
(4, 'E-Reader', 200.00, 20); 
```
- Create Sales Table

```sql
CREATE TABLE IF NOT EXISTS Sales ( 
SaleID INT PRIMARY KEY, 
ProductID INT, 
QuantitySold INT, 
SaleDate DATE 
);   
```

- Insert into Sales Table(during the 10-day sale period)

```sql
#sales during the 10-day sale period

INSERT INTO Sales (SaleID, ProductID, QuantitySold, SaleDate) VALUES 
(1, 1, 2, '2023-03-11'), 
(2, 2, 3, '2023-03-12'), 
(3, 3, 5, '2023-03-13'), 
(4, 1, 1, '2023-03-14'), 
(5, 4, 4, '2023-03-15'), 
(6, 2, 2, '2023-03-16'), 
(7, 3, 3, '2023-03-17'), 
(8, 4, 2, '2023-03-18'); 
```
- Insert into Sales Table(pre-sale transactions)

```
INSERT INTO Sales (SaleID, ProductID, QuantitySold, SaleDate) VALUES 
(9, 1, 1, '2023-03-01'), 
(10, 2, 2, '2023-03-02'), 
(11, 3, 1, '2023-03-03'), 
(12, 4, 1, '2023-03-04'), 
(13, 1, 2, '2023-03-05'), 
(14, 2, 1, '2023-03-06'), 
(15, 3, 3, '2023-03-07'), 
(16, 4, 2, '2023-03-08'), 
(17, 2, 1, '2023-03-09');
```

## Query for the Marketing Questions

-  How much revenue was generated each day of the sale? 
```sql
SELECT 
  SUM(P.Originalprice*S.Quantitysold) 
AS 
  Revenue, 
  S.Saledate 
FROM 
  Products P
LEFT JOIN  
  Sales S 
ON 
  P.Productid = S.Productid 
WHERE 
  S.Saledate 
BETWEEN 
  '2023-03-11'
AND 
  '2023-03-17' 
GROUP BY 
  S.Saledate 
 ```

- What was the total discount given during the sale period? 
```sql
SELECT  
  ROUND(SUM(P.Originalprice * S.Quantitysold *        
  P.Discountrate / 100)) 
AS 
  total_discount, 
  P.Productname 
FROM  
  Products P 
LEFT JOIN  
  Sales s 
ON 
  P.Productid = S.Productid 
WHERE 
  S.Saledate 
BETWEEN 
  '2023-03-11' 
AND 
  '2023-03-17' 
    GROUP BY  P.Productname 
  
```

- How does the sale performance compare in terms of units sold before and during the sale? 
```sql  
SELECT 
  SUM(CASE WHEN S.Saledate BETWEEN '2023-03-11' AND '2023-03-17' 
      THEN S.Quantitysold ELSE 0 END) 
      AS units_sold_during_sale, 
  SUM(CASE WHEN S.Saledate < '2023-03-01' OR S.Saledate > '2023-03-09' 
      THEN S.Quantitysold ELSE 0 END) 
      AS units_sold_before_sale 
FROM Sales S 
  ```

- What was the average discount rate applied to products sold during the sale? 
```sql
SELECT 
  ROUND(AVG(P.Discountrate),1) 
AS 
  average_discount 
FROM 
  Products P 
LEFT JOIN 
  Sales S 
ON 
  P.Productid = S.Productid 
WHERE 
  S.Saledate 
BETWEEN 
  '2022-03-11' 
AND 
  '2023-03-17' 
  ```
- Which day had the highest revenue, and what was the top-selling product on that day? 
```sql 
SELECT
  ROUND(SUM(P.OriginalPrice * S.QuantitySold * (1 - P.DiscountRate / 100))) 
AS 
  Revenue, 
  S.Saledate 
AS 
  Date, 
  P.Productname 
FROM 
  Products P 
RIGHT JOIN  
  Sales S 
ON 
  P.Productid = S.Productid 
GROUP BY 
  S.Saledate, 
  P.Productname 
ORDER BY 
  Revenue 
DESC 

```
- How many units were sold per product category during the sale?  
```sql 
SELECT 
CASE  
  WHEN P.Productid =  1 then 'Laptop' 
  WHEN P.Productid = 2 then 'Smartphone' 
  WHEN P.Productid = 3 then  'Headphones' 
  WHEN P.Productid = 4 THEN 'E-Reader' 
  ELSE 'Other' 
END AS
  Category, 
SUM(S.QuantitySold) 
AS 
  units_sold 
FROM 
  Sales S 
INNER JOIN  
  Products P 
ON 
  S.Productid = P.Productid 
WHERE 
  S.Saledate 
BETWEEN 
  '2023-03-11' 
AND 
  '2023-03-17' 
GROUP BY
  Category 
  ```

- How many transactions involved purchasing more than one item ?

``` sql

SELECT 
  COUNT(Transactionid) 
AS 
  No_Transaction 
FROM 
  Transactions  
WHERE 
  Quantity > 1 
  ```
- What was the total number of transactions each day? 
```sql
SELECT 
  S.Saledate, 
  COUNT(S.Quantitysold), 
  SUM(P.Originalprice)
AS 
  Revenue 
FROM 
  Products P 
LEFT JOIN 
  Sales S 
ON 
  P.Productid = S.Productid 
WHERE 
  S.Saledate 
BETWEEN 
  '2022-03-11' 
AND 
  '2023-03-17' 
GROUP BY 
  S.Saledate 
ORDER BY 
  S.Saledate 
ASC 
```
  
- Which product had the largest discount impact on revenue? 
```sql 
SELECT 
  P.Productname, 
  ROUND(SUM(P.OriginalPrice * S.QuantitySold * P.DiscountRate / 100)) 
AS 
  Discount_Impact 
FROM 
  Products P 
INNER JOIN  
  sales s 
ON 
  P.Productid = S.Productid 
GROUP BY 
  P.Productname 
ORDER BY 
  Discount_Impact 
DESC 
LIMIT 1
```

Thank you 

-------------- End of the Query ----------------
   
