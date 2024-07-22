# Problem Statement 1

#creating the Table 
#data file


#Customers Table
CREATE TABLE IF NOT EXISTS Customers ( 
CustomerID INT PRIMARY KEY, 
CustomerName VARCHAR(100), 
Country VARCHAR(50) 
); 

INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES 
(1, 'John Doe', 'USA'), 
(2, 'Jane Smith', 'Canada'), 
(3, 'Emily Jones', 'UK'), 
(4, 'Chris Brown', 'USA'); 

#Products Table
CREATE TABLE IF NOT EXISTS Products ( 
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(100), 
Price DECIMAL(10, 2), 
Category VARCHAR(50) 
); 

INSERT INTO Products (ProductID, ProductName, Price, Category) VALUES 
(1, 'Laptop', 1200.00, 'Electronics'), 
(2, 'Smartphone', 700.00, 'Electronics'), 
(3, 'Book', 15.00, 'Books'), 
(4, 'Table', 150.00, 'Furniture'); 

#Transactions Table 
CREATE TABLE IF NOT EXISTS Transactions ( 
TransactionID INT PRIMARY KEY, 
CustomerID INT, 
ProductID INT, 
Quantity INT, 
TransactionDate DATE 
); 

INSERT INTO Transactions (TransactionID, CustomerID, ProductID, Quantity, 
TransactionDate) VALUES 
(1, 1, 1, 1, '2023-03-15'), 
(2, 2, 2, 1, '2023-03-15'), 
(3, 3, 3, 2, '2023-03-16'), 
(4, 4, 4, 3, '2023-03-17'), 
(5, 1, 3, 1, '2023-03-18'); 
