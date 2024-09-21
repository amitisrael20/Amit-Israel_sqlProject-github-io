--DA Course 27/03/24 (Amit Israel)

--1
SELECT ProductName,CategoryName
FROM Products p
JOIN Categories c
ON p.CategoryID=c.CategoryID

--2
SELECT ProductName,CompanyName
FROM Products p
join Suppliers s
on p.SupplierID= s.SupplierID

--3
select CompanyName, OrderID
from Customers C
LEFT JOIN Orders O
on o.CustomerID=C.CustomerID
WHERE CompanyName LIKE('M%')

--4
SELECT RegionDescription,TerritoryDescription
FROM Region R
JOIN Territories T
ON R.RegionID=T.RegionID

--5
SELECT ProductName, CategoryName
FROM Products P
JOIN Categories C
ON P.CategoryID=C.CategoryID
WHERE UnitPrice>30

--6
SELECT ProductName, CompanyName
FROM Products P
JOIN Suppliers S
ON P.SupplierID=S.SupplierID
WHERE S.SupplierID=5 

--7
SELECT ProductName, CategoryName,CompanyName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN Suppliers S ON P.SupplierID = S.SupplierID

--8
SELECT CompanyName,OrderID
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID= O.CustomerID

--9
SELECT ProductName, CompanyName
FROM Products P
JOIN Suppliers S
ON P.SupplierID=S.SupplierID
WHERE Country LIKE('A%')

--10
SELECT ProductName, Description, City
FROM Products P
JOIN Categories C ON  c.CategoryID=p.CategoryID
JOIN Suppliers S ON P.SupplierID=S.SupplierID
WHERE City IN('Tokyo','London')

--11
SELECT OrderID,OrderDate,ShipAddress,C.CustomerID,CompanyName,Phone
FROM Orders O
JOIN Customers C 
ON C.CustomerID= O.CustomerID 
where OrderDate between ('1997-01-01') and ('1997-12-31') and (O.CustomerID LIKE ('B%') or O.CustomerID LIKE('D%'))

--12
SELECT OrderID,OrderDate,ShipAddress,C.CustomerID,CompanyName,Phone,FirstName,LastName
FROM Orders O
JOIN Customers C ON C.CustomerID= O.CustomerID
JOIN Employees E ON O.EmployeeID=E.EmployeeID
where OrderDate between ('1997-01-01') and ('1997-12-31') and
      (O.CustomerID LIKE ('B%') or O.CustomerID LIKE('D%')) AND 
	  (FirstName= 'Janet'or FirstName='Margaret')
order by OrderDate desc

--13
SELECT EM.EmployeeID,EM.FirstName, E.EmployeeID, E.FirstName
FROM Employees E
LEFT JOIN Employees EM 
ON E.EmployeeID=EM.ReportsTo
WHERE EM.ReportsTo IS NOT NULL

--14
SELECT C.CustomerID, CompanyName, AVG(Freight) AS AVG_FREIGHT
FROM Customers C
JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY C.CustomerID, CompanyName

--15
SELECT C.CustomerID, ContactName, CompanyName,ContactTitle,City,Country,SUM(Freight) AS TOTAL_FREIGHT
FROM Customers C
JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY C.CustomerID, ContactName, CompanyName,ContactTitle,City,Country
ORDER BY TOTAL_FREIGHT DESC

--16
SELECT O.OrderID, COUNT(DISTINCT ProductID) Products
FROM Orders O
JOIN [Order Details] OD 
ON O.OrderID=OD.OrderID
GROUP BY O.OrderID
ORDER BY Products DESC

--17
SELECT CategoryName,ProductName,UnitPrice,CompanyName
FROM Products P
JOIN Categories C ON P.CategoryID=C.CategoryID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE S.SupplierID IN(1,4,8)

--18
--UNION
SELECT City ,'C' AS CATEGORY FROM Customers C
UNION
SELECT CITY, 'S' AS CATEGORY FROM Suppliers S
ORDER BY CITY ASC

--19
--UNION

--20
SELECT ProductName, CompanyName
FROM Products P
JOIN Suppliers S
ON P.SupplierID=S.SupplierID

--21
SELECT O.OrderID,FirstName+' '+LastName AS Seller, Title, O.OrderDate 
FROM Orders O
JOIN Employees E
ON O.EmployeeID=E.EmployeeID

--22
SELECT CompanyName,City,COUNT(OrderID) AS ORDERS
FROM Customers C
JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY CompanyName,City
ORDER BY ORDERS DESC

--23
SELECT DISTINCT CompanyName, ContactName,Country
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID=O.CustomerID 
WHERE OrderID IS NULL

--24
SELECT  
       CASE WHEN O.CustomerID IS NULL THEN 'NON-PAYER'
       ELSE 'PAYER' END AS PAYER_TYPE,
	   COUNT(DISTINCT c.CustomerID) as customers
       
FROM Customers c 
LEFT join ORDERS o
ON C.CustomerID=O.CustomerID
GROUP BY CASE WHEN O.CustomerID IS NULL THEN 'NON-PAYER' ELSE 'PAYER' end 

--25
SELECT TOP 20 PERCENT ProductName, CompanyName AS 'SUPPLIERS', CategoryName, UnitPrice
FROM Products P
JOIN Suppliers S ON P.SupplierID=S.SupplierID
JOIN Categories C ON P.CategoryID= C.CategoryID
ORDER BY UnitPrice


--26
SELECT CompanyName, COUNT(OrderID) AS PRODUCTS
FROM Shippers S
JOIN Orders O 
ON O.ShipVia= S.ShipperID
WHERE ShipCountry IN ('Spain','France')
group by CompanyName

--27
--UNION








 
 


