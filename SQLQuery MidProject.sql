--DA Course Mid Project (Amit Israel)

--1
SELECT  SUM(UnitPrice*Quantity) AS GROSS_REVENUE,
        SUM(UnitPrice*Quantity*Discount) AS DISCOUNT,
        SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue,
        COUNT(distinct OrderID) AS Orders,
        SUM(Quantity) AS Quantity,
        COUNT(DISTINCT ProductID) AS Products
FROM [Order Details]


--2
SELECT  MONTH(OrderDate) AS Month_Num,DATENAME(MONTH, OrderDate) AS Month_Name, COUNT(OrderID) AS TotalOrders, SUM(Freight) AS TotalFreight
FROM Orders
GROUP BY  MONTH(OrderDate),DATENAME(MONTH, OrderDate)
ORDER BY Month_Num ASC

--3
SELECT ShipVia,sum(DATEDIFF(dd,OrderDate,ShippedDate))as Days_to_Ship,count(OrderID) as Orders
FROM Orders
group by ShipVia
ORDER BY ShipVia asc

--4
SELECT ShipCountry, SUM(Freight) AS TotalFreight
FROM Orders
WHERE ShipCountry IN('USA','Brazil','France')
GROUP BY ShipCountry
ORDER BY TotalFreight DESC

--5
Select top 10 percent ProductID, count(OrderID)as orders
from [Order Details]
group by ProductID
order by orders desc


--6
SELECT CategoryID, SUM(UnitsInStock) AS UnitsInStock, SUM(UnitsOnOrder) AS UnitsOnOrder
FROM Products
GROUP BY CategoryID

--7
SELECT ProductID,
       COUNT(ProductID)AS ORDERS, 
	   SUM(Quantity) AS QUANTITY,
	   SUM(UnitPrice*Quantity) AS GROSS_REVENUE,
	   SUM(UnitPrice*Quantity)-(SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount)) AS DISCOUNT,
	   SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue
FROM [Order Details]
WHERE Discount=0
GROUP BY ProductID
HAVING COUNT(ProductID)<8 

--8
SELECT SupplierID, COUNT(SupplierID) AS Products
FROM Products
WHERE UnitPrice>30
GROUP BY SupplierID
having COUNT(SupplierID) > 1

--9
SELECT EmployeeID, count(EmployeeID) AS Orders,
                   sum(DATEDIFF(dd,OrderDate,ShippedDate)) AS DaysToShip,
				   sum(DATEDIFF(dd,OrderDate,ShippedDate)) / count(EmployeeID) AS DaysToShipPerOrder
FROM Orders
WHERE OrderDate BETWEEN ('1997-01-01') AND ('1997-12-31')
GROUP BY EmployeeID
ORDER BY Orders desc 

--10
SELECT Title, COUNT(EmployeeID) AS Employees
FROM Employees
GROUP BY Title
Order by Employees desc

--11
SELECT Country,City, COUNT(EmployeeID) AS Employees
FROM Employees
GROUP BY Country,City
ORDER BY Employees DESC

--12 
SELECT distinct EmployeeID, count(TerritoryID) Territories
FROM EmployeeTerritories
group by EmployeeID
order by Territories desc


