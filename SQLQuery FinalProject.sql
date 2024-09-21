--DA Course Final Project (Amit Israel)

--1 
SELECT  YEAR, QUARTER ,SUM(GR) AS GROSS_REVENUE, SUM(DISCOUNT) AS DISCOUNT,SUM(NT) AS NetRevenue
                                                                   
FROM
	(SELECT YEAR(OrderDate) AS YEAR, DATEPART(QUARTER,OrderDate) AS QUARTER  ,GROSS_REVENUE AS GR, DISCOUNT AS DISCOUNT,
																										  Net_Revenue AS NT,ORDERS AS ORDERS
																										 ,QUANTITY AS QUANTITY,products AS PRODUCTS
	FROM
			(SELECT OrderDate AS OrderDate ,O.OrderID AS OrderId,ProductID as ProductId,(UnitPrice*Quantity) AS GROSS_REVENUE,
							   (UnitPrice*Quantity*Discount) AS DISCOUNT,
							   SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue,
							   COUNT(distinct O.OrderID) AS ORDERS,
							   SUM(Quantity) AS QUANTITY,         
							   count(distinct ProductID) as products
			FROM [Order Details] OD
			JOIN Orders O ON OD.OrderID= O.OrderID
			GROUP BY OrderDate,O.OrderId,ProductID, (UnitPrice*Quantity),(UnitPrice*Quantity*Discount))A)A
GROUP BY YEAR, QUARTER
ORDER BY 1;


--2 
SELECT DISTINCT ProductName,SUM(DAYSTOSHIP) AS DAYSTOSHIP,COUNT(OrderId) as orders
FROM Products P
JOIN
		(SELECT O.OrderID AS OrderId ,ProductID, OrderDate as OrderDate,ShippedDate as ShippedDate,DATEDIFF(dd,OrderDate,ShippedDate) AS DAYSTOSHIP
		 FROM Orders O
		 JOIN [Order Details] OD ON O.OrderID=OD.OrderID
		 WHERE YEAR(OrderDate) =1997) A ON P.ProductID = A.ProductID
GROUP BY ProductName
having SUM(DAYSTOSHIP)>200
order by 2 DESC

--3
SELECT ShipCountry,SUM(UnitPrice*Quantity) AS GROSS_REVENUE,
                   SUM(UnitPrice*Quantity*Discount) AS DISCOUNT,
                   SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue,
				   COUNT(distinct O.OrderID) AS ORDERS,
				   SUM(Quantity) AS QUANTITY,
				   count(distinct ProductID) as products
FROM Orders o
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE lower(ShipCountry) IN('austria','brazil','germany','usa')
GROUP BY ShipCountry

--4 
SELECT MONTHNUM,MonthNAME,SUM(GROSS_REVENUE) AS GROSS_REVENUE,COUNT(ORDERS) AS Orders
FROM
    (SELECT OD.OrderID,OrderDate,SUM(UnitPrice*Quantity) AS GROSS_REVENUE,MONTH(OrderDate)AS MONTHNUM,DATENAME(MONTH,OrderDate)AS MonthNAME,COUNT(O.OrderID) AS ORDERS
     FROM Orders O
     JOIN [Order Details]OD ON OD.OrderID=O.OrderID 
     WHERE YEAR(O.OrderDate) =1997
     group by OD.OrderID,OrderDate)A
GROUP BY MONTHNUM,MonthNAME
ORDER BY 1

--5 
SELECT CompanyName,SUM(DAYSTOSHIP) as Daystoship,COUNT(OrderID) AS Orders
FROM
    (SELECT ShipperID AS ShipperID ,CompanyName AS CompanyName ,OrderID AS OrderID ,OrderDate AS OrderDate ,ShippedDate AS ShippedDate ,
	                                                                                  DATEDIFF(dd,OrderDate,ShippedDate) AS DAYSTOSHIP
     FROM Shippers S
     JOIN Orders O ON S.ShipperID = O.ShipVia
     WHERE YEAR(OrderDate)=1997) A
GROUP BY CompanyName


--6 
SELECT ProductName,Products
		FROM
		(SELECT ProductName,Products,
			   DENSE_RANK() OVER(ORDER BY Products ASC) AS rankAsc,
			   DENSE_RANK() OVER(ORDER BY Products desc) AS rankdesc
		FROM
				(SELECT ProductName,COUNT(OD.ProductID) AS PRODUCTS
				FROM [Order Details] OD
				JOIN Orders O ON O.OrderID = OD.OrderID
				JOIN Products P ON P.ProductID = OD.ProductID
				WHERE YEAR(OrderDate) = 1997
				GROUP BY ProductName
				) A  )A
WHERE rankAsc<=5 OR rankdesc<=5

--7 
SELECT TOP 10 PERCENT C.CategoryName AS CategoryName,  ProductName, COUNT(DISTINCT O.OrderID) AS ORDERS, SUM(Quantity) AS QUANTITY, SUM(OD.UnitPrice * Quantity) AS Gross_Revenue, 
									   SUM(OD.UnitPrice*Quantity*Discount) AS DISCOUNT, SUM(OD.UnitPrice*Quantity)-SUM(OD.UnitPrice*Quantity*Discount) AS Net_Revenue
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE YEAR(OrderDate) = '1997'
GROUP BY C.CategoryName,ProductName
ORDER BY 3 DESC
	
--8
SELECT CategoryName, ProductName,UnitsInStock,UnitsOnOrder
FROM Categories C
JOIN Products P ON P.CategoryID = C.CategoryID
WHERE UnitsInStock<10
ORDER BY 2 

--9
SELECT FirstName, 'top 5' as 'Performance',orders
FROM(SELECT TOP 5 FirstName AS FirstName,COUNT(EmployeeId) AS ORDERS
     FROM
         (SELECT E.EmployeeID AS EmployeeId, FirstName AS FirstName,OrderID as OrderId ,OrderDate as OrderDate
          FROM Employees E
          JOIN Orders O ON O.EmployeeID = E.EmployeeID)A
          WHERE YEAR(OrderDate) = 1997
          GROUP BY EmployeeId,FirstName
          ORDER BY 2 DESC)A

UNION ALL

SELECT FirstName, 'buttom 5' as 'Performance',orders
FROM(SELECT TOP 5 FirstName AS FirstName,COUNT(EmployeeId) AS ORDERS
     FROM
         (SELECT E.EmployeeID AS EmployeeId, FirstName AS FirstName,OrderID as OrderId ,OrderDate as OrderDate
          FROM Employees E
          JOIN Orders O ON O.EmployeeID = E.EmployeeID)A
          WHERE YEAR(OrderDate) = 1997
          GROUP BY EmployeeId,FirstName
          ORDER BY 2 ASC)A
	 



--10 
SELECT TITLE,FIRSTNAME,OrderId,Quantity,GROSS_REVENUE,DISCOUNT,Net_Revenue,
	   SUM(OrderId) OVER(PARTITION BY TITLE) AS OrderTotal,	
	   SUM(Quantity) OVER(PARTITION BY TITLE) AS quantityTotal,
	   SUM(GROSS_REVENUE) OVER(PARTITION BY TITLE) AS GrossRevenueTotal,
	   SUM(DISCOUNT) OVER(PARTITION BY TITLE) AS DiscountTotal,
	   SUM(Net_Revenue) OVER(PARTITION BY TITLE) AS NetRevenueTotal

FROM
		(SELECT DISTINCT TITLE,FIRSTNAME, COUNT(DISTINCT ORDERID) AS OrderId,
		SUM(QUANTITY) AS Quantity,
		SUM(GROSS_REVENUE) AS GROSS_REVENUE,
		SUM(DISCOUNT) AS DISCOUNT,
		SUM(Net_Revenue) AS Net_Revenue

		FROM(
				 SELECT Title AS TITLE,FirstName FIRSTNAME,OrderID AS ORDERID,
				 SUM(Quantity) QUANTITY, SUM(UnitPrice*Quantity) AS GROSS_REVENUE,
				 SUM(UnitPrice*Quantity*Discount) AS DISCOUNT,
				 SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue

				 FROM 
						        (SELECT OD.OrderID,ProductID,UnitPrice,Quantity,Discount,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName
								FROM [Order Details] OD
								JOIN Orders O ON O.OrderID= OD.OrderID) A
				 JOIN Employees E ON E.EmployeeID = A.EmployeeID
				 WHERE YEAR(OrderDate) = 1997
				 group by Title,FirstName,OrderID)A
		GROUP BY TITLE,FIRSTNAME
		)A
ORDER BY 1


--11 
SELECT RegionDescription, COUNT(distinct OrderID) as Orders, SUM(UnitPrice*Quantity) AS GROSS_REVENUE,
                         (SUM(UnitPrice*Quantity)/COUNT(distinct OrderID)) AS RevenuePerOrder
	FROM(
			SELECT distinct od.OrderID,Quantity,UnitPrice,RegionDescription
			FROM Region R
			JOIN Territories T ON R.RegionID = T.RegionID
			JOIN EmployeeTerritories E ON T.TerritoryID = E.TerritoryID
			JOIN Orders O ON E.EmployeeID= O.EmployeeID
			JOIN [Order Details] OD ON O.OrderID = OD.OrderID)a
group by RegionDescription



--12 
SELECT OrderDate, OrderMonth ,QUARTER,CustomerId,Country,City,ShipperId, CompanyName,EmployeeId,Title,FirstName,
       ProductName,CategoryName,DaysToShip,SUM(UnitPrice*Quantity) AS GROSS_REVENUE, SUM(UnitPrice*Quantity*Discount) AS DISCOUNT,
                                                                                     SUM(UnitPrice*Quantity)-SUM(UnitPrice*Quantity*Discount) AS Net_Revenue,
																			         COUNT(OrderId) AS ORDERS,
																				     COUNT(CustomerId) AS PRODUCTS
FROM
		(SELECT OrderDate,ShippedDate,DATEPART(QUARTER,OrderDate) AS QUARTER,OrderId, OrderMonth,Country,City,ShipperId,CompanyName,EmployeeId,UnitPrice,
		       Quantity,Discount,Title,FirstName,ProductName,CategoryName,CustomerId,DATEDIFF(dd,OrderDate,ShippedDate) AS DaysToShip
		 FROM
				(SELECT OrderDate AS OrderDate,o.OrderID AS OrderId,DATENAME(MONTH,OrderDate) AS OrderMonth ,C.CustomerID AS CustomerId,C.Country as Country,C.City AS City, ShipperID AS ShipperId,
						S.CompanyName AS CompanyName,E.EmployeeID AS EmployeeId, Title AS Title,FirstName AS FirstName,ProductName AS ProductName, 
						CategoryName AS CategoryName,OD.UnitPrice AS UnitPrice,Quantity AS Quantity,Discount AS Discount,ShippedDate AS ShippedDate
				 FROM Orders O
				 JOIN [Order Details] OD ON O.OrderID = OD.OrderID
				 JOIN Customers C ON C.CustomerID = O.CustomerID
				 JOIN Employees E ON E.EmployeeID = O.EmployeeID
				 JOIN Products P ON P.ProductID = OD.ProductID
				 JOIN Categories CT ON CT.CategoryID = P.CategoryID  
				 JOIN Shippers S ON S.ShipperID = O.ShipVia) A )A
GROUP BY OrderDate,OrderMonth,QUARTER,CustomerId,Country,City,ShipperId, CompanyName,EmployeeId,Title,FirstName,ProductName,CategoryName,DaysToShip





