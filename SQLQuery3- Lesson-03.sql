--DA Course 20/03/2024 (Amit Israel)

--1
SELECT City, MIN(LastName) AS Min_lastName
FROM Employees
group by City

--2
SELECT Max(LastName) AS Max_lastName
FROM Employees

--3
SELECT count(EmployeeID) as AmountOfRecords
FROM Employees

--4
SELECT CategoryID,SupplierID, avg(UnitPrice) as avgPrice
FROM Products
group by SupplierID,CategoryID

--5
select max(UnitPrice) as MaxPrice, MIN(UnitPrice) as MinPrice, AVG(UnitPrice) as AvgPrice
from Products

--6
SELECT min(BirthDate) as MinBirthDate, max(BirthDate) as MaxBirthDate
FROM Employees

--7
select ShipCity, count(OrderID) AS NumOfOrders, count(distinct CustomerID)as Customers
from Orders
group by ShipCity
order by Customers DESC

--8
SELECT SupplierID, AVG(UnitPrice) as AvgUnitPrice
FROM Products
where SupplierID in(1,3,6,11,15)
group by SupplierID 
having AVG(UnitPrice)>=20

--9
SELECT ContactTitle,COUNT(Distinct Country) as Countries
FROM Customers
WHERE ContactTitle IN('Sales Agent','Accounting Manager','Sales Representative')
Group By ContactTitle
having count(Country)>5

--10
SELECT Region, count(fax) as AmountOfFax
FROM Customers
WHERE Region IS Null or Region in('Lara','DF','Isle','Wight','WA')
group by Region
having count(fax)>0

--11
SELECT ShipCountry,SUM(Freight) as SumFreight
FROM Orders
where OrderDate>'1998-01-01'
group by ShipCountry
having SUM(Freight)>1000
ORDER BY SumFreight DESC

--12
SELECT Country, COUNT(CustomerID) as customers
FROM Customers
WHERE Country LIKE('%e%')
group by Country
having COUNT(Distinct CustomerID)<10
ORDER BY customers DESC

--13
SELECT CategoryID, MAX(UnitPrice) AS MaxUnitPrice, AVG(UnitPrice) As AvgUnitPrice, MIN(UnitPrice) as MinUnitPrice
FROM Products
GROUP BY CategoryID
having AVG(UnitPrice)>30 and MIN(UnitPrice)<10

--14
SELECT CategoryID, COUNT(CategoryID) AS AmountOfProducts
FROM Products
WHERE UnitsInStock>=30
group by CategoryID
having COUNT(CategoryID)>5

--15
SELECT CategoryID, MAX(UnitPrice) AS MaxUnitPrice, AVG(UnitPrice) As AvgUnitPrice, MIN(UnitPrice) as MinUnitPrice
FROM Products
WHERE CategoryID>5
GROUP BY CategoryID
--16
SELECT Country,City,COUNT(DISTINCT CustomerID) As Customers
FROM Customers
Where Country='USA'
GROUP BY Country,City
Having COUNT(DISTINCT CustomerID)>1


--17
SELECT CategoryID, AVG(UnitsOnOrder) AS Avg_UnitsOnOrder
FROM Products
Where UnitPrice>10
group by CategoryID
having AVG(UnitsOnOrder)>0

--18
SELECT CustomerID,isNull(ShipRegion,'Unknown') as Region,count(CustomerID) as customers
FROM Orders
where ShipRegion is Null
group by CustomerID,ShipRegion
having count(CustomerID)>14
order by customers ASC

--19
SELECT CategoryID, SupplierID, AVG(UnitPrice) AS UnitInPrice
FROM Products
WHERE CategoryID IN (5,6,8)
GROUP BY  SupplierID,CategoryID
HAVING AVG(UnitPrice)>30
ORDER BY CategoryID,SupplierID ASC

--20
SELECT City, MIN(BirthDate)
FROM Employees
GROUP BY City

--21
SELECT Title, count(Title)
FROM Employees
group by Title

--22
SELECT Country,City,COUNT(Title)
FROM Employees
GROUP BY Country,City

--23
SELECT EmployeeID, COUNT(CustomerID) AS ORDERS
FROM Orders
GROUP BY EmployeeID
ORDER BY EmployeeID ASC



--24
SELECT CategoryID, AVG(UnitPrice)
FROM Products
WHERE CategoryID IN(5,6,8)
GROUP BY CategoryID

--25
SELECT ShipCountry,SUM(Freight)
FROM Orders
WHERE OrderDate>'1998-05-01'
group by ShipCountry

--26
SELECT EmployeeID, COUNT(CustomerID) AS ORDERS
FROM Orders
WHERE EmployeeID in(1,3,4,8)
GROUP BY EmployeeID
ORDER BY EmployeeID ASC

--27
SELECT SupplierID, AVG(UnitPrice) AS AvgUnitPrice
FROM Products
group by SupplierID
having AVG(UnitPrice)>40

--28
SELECT CategoryID, MAX(UnitPrice) AS MaxUnitPrice, AVG(UnitPrice) As AvgUnitPrice, MIN(UnitPrice) as MinUnitPrice
FROM Products
GROUP BY CategoryID
having (AVG(UnitPrice)>30) and (MIN(UnitPrice)<10)

--29
SELECT EmployeeID, COUNT(CustomerID) AS ORDERS
FROM Orders
GROUP BY EmployeeID
having COUNT(CustomerID)<50
ORDER BY ORDERS ASC

--30
SELECT ShipCountry, SUM(Freight)
FROM Orders
WHERE OrderDate>'1998-01-01'
GROUP BY ShipCountry
HAVING SUM(Freight)>1000


--31
SELECT CustomerID, SUM(Freight) AS Freight
FROM Orders
WHERE OrderDate BETWEEN '1997-11-01' AND '1997-12-31'
GROUP BY CustomerID
HAVING SUM(Freight)>200

--32
SELECT DISTINCT SupplierID, AVG(UnitPrice) AS AvgUnitPrice
FROM Products
group by SupplierID
order by AvgUnitPrice desc

--33
SELECT top 10 SupplierID, AVG(UnitPrice) AS AvgUnitPrice, COUNT(ProductName) AS Products
FROM Products
group by SupplierID
order by Products desc

--34
SELECT ShipCountry, SUM(Freight) AS SumFreight
FROM Orders
WHERE OrderDate> '1998-01-01'
group by ShipCountry
having SUM(Freight)>1000
order by SumFreight desc
