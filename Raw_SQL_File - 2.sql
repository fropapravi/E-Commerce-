# Problem Statement 2 
  
# These are the dataset from sale / non sale period analysis:
  
#Products Table
CREATE TABLE IF NOT EXISTS Products ( 
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(100), 
OriginalPrice DECIMAL(10, 2), 
DiscountRate DECIMAL(5, 2)  -- Discount rate as a percentage, e.g., 10% discount is 
represented as 10. 
); 

INSERT INTO Products (ProductID, ProductName, OriginalPrice, DiscountRate) VALUES 
(1, 'Laptop', 1200.00, 15), 
(2, 'Smartphone', 700.00, 10), 
(3, 'Headphones', 150.00, 5), 
(4, 'E-Reader', 200.00, 20); 

#sales during the 10-day sale period

#Sales Table
CREATE TABLE IF NOT EXISTS Sales ( 
SaleID INT PRIMARY KEY, 
ProductID INT, 
QuantitySold INT, 
SaleDate DATE 
);  

INSERT INTO Sales (SaleID, ProductID, QuantitySold, SaleDate) VALUES 
(1, 1, 2, '2023-03-11'), 
(2, 2, 3, '2023-03-12'), 
(3, 3, 5, '2023-03-13'), 
(4, 1, 1, '2023-03-14'), 
(5, 4, 4, '2023-03-15'), 
(6, 2, 2, '2023-03-16'), 
(7, 3, 3, '2023-03-17'), 
(8, 4, 2, '2023-03-18'); 

#Additional pre-sale transactions 
  
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
