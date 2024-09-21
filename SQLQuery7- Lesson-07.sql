--DA Course 17/04/24 (Amit Israel)

--1
CREATE TABLE Products_66
( ProductName VARCHAR(27),
  CategoryName VARCHAR(27),
  UnitPrice decimal(7,2)
)

INSERT INTO Products_66
(ProductName,CategoryName,UnitPrice)
SELECT ProductName,CategoryName, CAST(UnitPrice AS decimal(7,2)) AS UnitPrice
FROM Products P
JOIN Categories C ON P.CategoryID=C.CategoryID
WHERE UnitPrice> 66.00

SELECT*
FROM Products_66


--2
CREATE TABLE Category_4
( CategoryID Int,
  AvgUnitPrice Float
)

INSERT INTO Category_4
(CategoryID,AvgUnitPrice)
SELECT C.CategoryID,AVG(UnitPrice) AS AVG_UnitPrice
FROM Categories C
JOIN Products P ON C.CategoryID=P.CategoryID
GROUP BY C.CategoryID
HAVING AVG(UnitPrice)>(SELECT AVG(UnitPrice)
						FROM Products
						WHERE CategoryID=4)		

SELECT*
FROM Category_4


--3
CREATE TABLE OrderID_5
( OrderID Int,
  OrderDate DATE,
  MaxUnitPrice Float
)

INSERT INTO OrderID_5
(OrderID,OrderDate,MaxUnitPrice)
SELECT O.OrderID,OrderDate,MAX(UnitPrice) AS MAX_UnitPrice
FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY O.OrderID,OrderDate
HAVING MAX(UnitPrice) <5

SELECT*
FROM OrderID_5


--4
--First Table
CREATE TABLE USERS
( UserID Int,
  Gender VARCHAR(1)
)

INSERT INTO USERS
(UserID,Gender)
VALUES(123,'M'),(124,'M'),(125,'F')

SELECT*
FROM USERS
      
	  
--Second Table
CREATE TABLE DEPOSITS
( UserID Int,
  time_Stamp Date,
  Amount Int
)

INSERT INTO DEPOSITS
(UserID,time_Stamp,Amount)
VALUES(123,'2017-01-01',9),
      (123,'2017-01-02',12),
	  (123,'2017-01-03',20),
	  (124,'2017-01-03',8),
	  (124,'2017-01-04',7),
	  (125,'2017-01-02',30)

SELECT*
FROM DEPOSITS





