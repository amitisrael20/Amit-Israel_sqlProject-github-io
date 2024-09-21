--DA Course 03/04/24 (Amit Israel)


--1
SELECT ProductName
FROM Products
WHERE UnitPrice<(SELECT UnitPrice
                 FROM Products
                 WHERE ProductID=3)

--2
SELECT ProductName,UnitPrice
FROM Products
where UnitPrice>(SELECT UnitPrice
                 FROM Products
                 WHERE ProductName='Carnarvon Tigers')

--3
SELECT FirstName,LastName,HireDate
FROM Employees
WHERE HireDate>(SELECT HireDate
                FROM Employees
                WHERE EmployeeID=4)

--4
SELECT ProductID,ProductName,UnitPrice
FROM Products
WHERE UnitPrice>(SELECT AVG(UnitPrice)
                 FROM Products
                 WHERE CategoryID=6)


--5
SELECT EmployeeID,FirstName,Title,HomePhone 
FROM Employees
WHERE BirthDate<(select BirthDate
                 from Employees
                 where LastName='Fuller')

--6
SELECT ProductName,UnitsInStock
FROM Products
WHERE UnitsInStock < (SELECT MIN(UnitsInStock)
                      FROM Products
                      WHERE CategoryID=3)

--7
SELECT ProductID, ProductName,UnitPrice
FROM Products
WHERE CategoryID =(SELECT CategoryID
                   FROM Products
                   WHERE ProductName='Chai')

--8
SELECT ProductName,UnitPrice,CategoryID
FROM Products
WHERE UnitPrice IN(SELECT UnitPrice
FROM Products
WHERE CategoryID=5)

--9
SELECT OrderID,OrderDate
FROM Orders
WHERE CustomerID in(SELECT CustomerID
                    FROM Customers
                    WHERE Country IN ('France','Germany','Sweden') and
				    (OrderDate<'1996-09-01'))


--10
SELECT ProductID,ProductName,UnitsInStock
FROM Products
WHERE UnitPrice>(SELECT MAX(UnitPrice)
                 FROM Products
                 WHERE UnitsInStock=20)

--11
SELECT CategoryID,ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice)
                    FROM Products 
                    WHERE CategoryID=2 and UnitPrice>40)

                    
--12
SELECT CategoryID,AVG(UnitPrice) AS Avg_UnitPrice
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitPrice)>(SELECT AVG(UnitPrice)
                       FROM Products
                       WHERE CategoryID=3)

--13
SELECT ProductName,UnitPrice
FROM Products
WHERE UnitPrice>(SELECT UnitPrice
                 FROM Products
                 WHERE (ProductID=5))
				 
AND CategoryID= (SELECT CategoryID
                 FROM Products
                 WHERE ProductName='Chai')

AND ProductName !='Konbu'


--14
SELECT OrderID,AVG(UnitPrice) AS Avg_UnitPrice
FROM [Order Details]
WHERE OrderID IN (SELECT OrderID
                 FROM Orders
                 WHERE ShipCity = 'Madrid')
GROUP BY OrderID
HAVING AVG(UnitPrice)<30

--15
SELECT E.EmployeeID,FirstName,AVG(Freight) AS Avg_freight
FROM Employees E
JOIN Orders O
ON E.EmployeeID=O.EmployeeID
WHERE E.EmployeeID IN (SELECT DISTINCT EmployeeID 
                       FROM Orders
                       WHERE EmployeeID !=5)
GROUP BY E.EmployeeID,FirstName
HAVING AVG(Freight)>60

--16
SELECT O.OrderID,OrderDate,od.MaxUnitPrice
FROM (SELECT OrderID,MAX(UnitPrice) AS MaxUnitPrice
      FROM [Order Details]
      Group by OrderID) OD
JOIN Orders O on OD.orderID=O.OrderID
WHERE OrderDate>='1998-05-01'

--17
SELECT FirstName+' '+LastName AS EMPLOYEE_NAME, HireDate
FROM Employees
WHERE HireDate>(SELECT HireDate
                FROM Employees
                WHERE EmployeeID=4)

--18
select ProductName,CategoryID,UnitPrice
from Products
where CategoryID=(SELECT CategoryID
                  FROM Products
                  WHERE ProductName='ikura')

--19
SELECT ShipCountry,Freight
FROM Orders
WHERE Freight >= (SELECT MAX(Freight)
                  FROM Orders
                  WHERE ShipVia=3)

--20
SELECT ProductName, CategoryID,UnitPrice
FROM Products
WHERE UnitsInStock<(SELECT MIN(UnitPrice)
                    FROM Products
                    WHERE CategoryID=8)

--21
SELECT ProductID,MAX(Quantity) AS Max_Quantity
FROM [Order Details]
GROUP BY ProductID
HAVING MAX(Quantity)>(SELECT MAX(Quantity)
                      FROM [Order Details]
                       WHERE ProductID=59)

--22
SELECT SupplierID,MIN(UnitPrice) AS MIN_UnitPrice
FROM Products
GROUP BY SupplierID
HAVING MIN(UnitPrice)<(SELECT MIN(UnitPrice)
                   FROM Products
                   WHERE SupplierID=10)

--23
SELECT SupplierID,ContactName
FROM Suppliers
WHERE SupplierID IN(SELECT SupplierID
                    FROM Products
                    WHERE Discontinued=1)

--24
SELECT CustomerID,CompanyName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
                  FROM Orders
                  WHERE ShipCity ='Madrid')

--25
SELECT E.EmployeeID,E.FirstName,ED.AVG_Freight
FROM(SELECT EmployeeID,
     AVG(Freight)as AVG_Freight
     FROM Orders
     GROUP BY EmployeeID) ED 
JOIN Employees E ON E.EmployeeID=ED.EmployeeID
ORDER BY ED.EmployeeID ASC








				



