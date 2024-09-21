--DA Course 13/03/2024 (Amit Israel)

--1
Select ProductName, UnitsInStock
From Products
where UnitsInStock<=10

--2
Select *
From Employees
where City='London'

--3
SELECT*
FROM Orders
WHERE RequiredDate='1997-06-05'

--4
SELECT OrderID, CustomerID, EmployeeID, OrderDate, ShippedDate, ShipVia, ShipCountry
FROM Orders
where EmployeeID=5 And (ShipCountry LIKE 'B%') And (ShipVia IN (1,2)) and DATEDIFF(dd,OrderDate,ShippedDate)>5

--5
SELECT ProductName, UnitsInStock,UnitPrice
FROM Products
WHERE ProductName LIKE 'C%' And (UnitsInStock < 20 or UnitsInStock > 40) 

--6
SELECT*
FROM Employees
WHERE City IN('London', 'Seattle', 'Redmont')

--7
SELECT *
FROM Products
WHERE (ReorderLevel  != 0 AND ReorderLevel !=15 AND ReorderLevel != 30) And (UnitsOnOrder != 0 And UnitsOnOrder != 40) 

--8
SELECT OrderID, OrderDate,RequiredDate
FROM Orders
WHERE (RequiredDate BETWEEN '1996-09-01' AND '1996-09-22') AND (OrderID>10280)

--9
SELECT CustomerID, CompanyName, Country, Phone, Region
FROM Customers
WHERE (CompanyName LIKE'B%' OR CompanyName LIKE'R%') AND (Region is Null)

--10
SELECT ProductName, UnitPrice, SupplierID
FROM Products
WHERE (UnitPrice>20) AND (SupplierID='2' OR SupplierID='7')

--11
SELECT OrderID, Freight, CASE WHEN Freight>0 And Freight<=50 Then 'a. 0-50'
WHEN Freight>50 And Freight<=100 Then 'b. 50-100' ELSE 'c. 100+' END AS Frieght_GROUP
FROM Orders
WHERE OrderID< 10257

--12
SELECT DISTINCT ShipCity, ShipVia, CASE WHEN ShipVia=1 Then 'Bad Ship' When ShipVia=2 Then 'Medium Ship' 
When ShipVia=3 Then 'Good Ship' END AS 'Ship Type'
FROM Orders
WHERE ShipCity LIKE 'A%'

--13
SELECT OrderID, CustomerID, OrderDate, Freight, ShipCountry
FROM Orders
WHERE OrderDate>='1998-01-01'

--14
SELECT OrderID, CustomerID, OrderDate, Freight, ShipCountry
FROM Orders
WHERE (Freight < 5 or ShipCountry='USA') And OrderDate>='1998-01-01'

--15
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Phone
FROM Customers
WHERE CustomerID IN('SPLIR','MAGAA','QUICK')

--16
SELECT OrderID, CustomerID, OrderDate, Freight, ShipCountry
FROM Orders
WHERE OrderDate BETWEEN '1997-10-01' And '1997-10-31'

--17
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Phone
FROM Customers
WHERE ContactTitle LIKE '%Manager%'

--18
SELECT EmployeeID,LastName+' '+FirstName AS EmpName, DATEDIFF(YY,BirthDate , HireDate) AS 'Age'
FROM Employees

--19
SELECT OrderID, EmployeeID, OrderDate, ISNULL(ShipCity,ShipCity) AS 'Ship Destination'
FROM Orders
WHERE ShipRegion IS Null