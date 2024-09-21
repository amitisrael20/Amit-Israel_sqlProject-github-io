--DA Course 10/04/24 (Amit Israel)
--1
SELECT Discount,UnitPrice,SUM(UnitPrice) OVER()
FROM [Order Details]
ORDER BY 1,2

--2
SELECT OrderID, ProductName,Discount,OD.UnitPrice,SUM(OD.UnitPrice) OVER(partition by productname ORDER BY od.unitprice,orderid) AS SUM_Running_Unit_Price,sum(od.UnitPrice) over(partition by productname ) as TotalUnitPrice
FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID

--3
select Discount,UnitPrice,sum(UnitPrice) over(partition by discount order by unitprice) as Sum_running_Total
from [Order Details]

--4
select Discount,UnitPrice,sum(UnitPrice) over(partition by unitprice) as Sum_running_Unit_Price
from [Order Details]

--5
select Discount,UnitPrice,sum(UnitPrice) over(partition by discount, unitprice) as Sum_running_Total
from [Order Details]

--6
SELECT Discount,UnitPrice,SUM(UnitPrice) OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE ) AS Sum_Running_Total , SUM(UnitPrice) OVER(PARTITION BY DISCOUNT) AS Sum_Total
FROM [Order Details]

--7
SELECT Discount ,UnitPrice, RANK() OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS RANK,
DENSE_RANK() OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS DENSE,
ROW_NUMBER() OVER (PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS ROW
FROM [Order Details]

--8
SELECT Discount,UnitPrice, NTILE(2) OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS NTILE2,
                           NTILE(4) OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS NTILE4,
                           NTILE(10) OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS NTILE10
FROM [Order Details]

--9
SELECT DISTINCT Discount, NTILES,count(Discount) as ORDERS, MIN(UnitPrice) AS Min_UnitPrice,
                                  avg(UnitPrice) AS sum_UnitPrice,
                                  Max(UnitPrice) AS Max_UnitPrice								  
FROM(SELECT Discount,UnitPrice,
     NTILE(4) OVER(PARTITION BY DISCOUNT ORDER BY UNITPRICE) AS NTILES
     FROM [Order Details]) A
group by Discount, NTILES

--10
SELECT PRODUCTS, CASE WHEN PERCENTEGES=1 THEN 'a. 0%-25%' 
                       WHEN PERCENTEGES=2 THEN 'B. 25%-50%'
					   WHEN PERCENTEGES=3 THEN 'C. 50%-75%'
					   ELSE 'D. 75%-100%' END AS PERCENTEGES,
					   MIN(REVENUE) AS MIN_REVENUE,
					   AVG(REVENUE) AS AVG_REVENUE,
					   MAX(REVENUE) AS MAX_REVENUE,
					   COUNT(OrderID) AS CNT					   
FROM(SELECT OrderID, PRODUCTS,REVENUE, NTILE(4) OVER(PARTITION BY PRODUCTS ORDER BY REVENUE) AS PERCENTEGES
     FROM (SELECT OrderID,COUNT(ProductID) AS PRODUCTS,SUM(UnitPrice*Quantity)AS REVENUE
           FROM [Order Details]
           GROUP BY OrderID)A)B
WHERE PRODUCTS=3
GROUP BY PRODUCTS,CASE WHEN PERCENTEGES=1 THEN 'a. 0%-25%' 
                       WHEN PERCENTEGES=2 THEN 'B. 25%-50%'
					   WHEN PERCENTEGES=3 THEN 'C. 50%-75%'
					   ELSE 'D. 75%-100%' END

--11
SELECT SupplierID,UnitPrice,LEAD(UnitPrice,1,0) OVER(PARTITION BY SupplierID ORDER BY UnitPrice) AS 'LEAD',
                            LAG(UnitPrice,1,0) OVER(PARTITION BY SupplierID ORDER BY UnitPrice ) AS 'LAG'
FROM Products

--12
SELECT S.SupplierID, UnitPrice, FIRST_VALUE(UnitPrice) OVER (PARTITION BY S.SupplierID ORDER BY UnitPrice ) AS FIRST_VALUE,
        LAST_VALUE(UnitPrice) OVER (PARTITION BY S.SupplierID ORDER BY UnitPrice RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LAST_VALUE
FROM Suppliers S
JOIN Products P ON S.SupplierID=P.SupplierID

--13
SELECT EmployeeID,OrderID,OrderDate,COUNT(OrderID) OVER(PARTITION BY EmployeeID) AS RUNNING_TOTAL
FROM Orders

--14
SELECT ProductName, COUNT(OrderID) AS ORDERS, MAX (UNITPRICE) AS MEDIAN_PRICE
FROM(SELECT OrderID,ProductName ,P.UnitPrice,NTILE(2) OVER(PARTITION BY ProductName ORDER BY P.UnitPrice) AS NTILES
     FROM [Order Details] OD
     JOIN Products P  ON P.ProductID=OD.ProductID) A
WHERE NTILES=1
GROUP BY ProductName

--15
SELECT C.CategoryID,UnitPrice,ProductName,LEAD(ProductName) OVER(PARTITION BY C.CategoryID ORDER BY  UnitPrice) AS NextDate,
                                          LAG(ProductName) OVER(PARTITION BY C.CategoryID ORDER BY UnitPrice ) AS PreviousDate
FROM Products P
JOIN Categories C ON C.CategoryID=P.CategoryID
ORDER BY C.CategoryID, UNITPRICE ASC


--16
SELECT CategoryID ,ProductName,UnitPrice,FIRST_VALUE(UnitPrice) OVER (PARTITION BY CategoryID ORDER BY UNITPRICE ) AS LowestPrice,
       LAST_VALUE(UnitPrice) OVER (PARTITION BY CategoryID ORDER BY UNITPRICE RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS HighestPrice
FROM Products





