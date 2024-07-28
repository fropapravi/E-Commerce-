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

   
