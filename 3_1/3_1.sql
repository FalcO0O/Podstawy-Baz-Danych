
-- æw 1

-- 1

SELECT 
    O.OrderID,
    C.CompanyName AS CustomerName,
    SUM(OD.Quantity) AS TotalUnits
FROM Orders AS O
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY O.OrderID, C.CompanyName
ORDER BY O.OrderID;

-- 2

SELECT Orders.OrderID, C.CompanyName AS CustomerName,  SUM(Quantity) AS 'lzj' 
FROM Orders
INNER JOIN [Order Details] OD on Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
GROUP BY Orders.OrderID, C.CompanyName
HAVING SUM(Quantity) > 250;


-- 3

SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
GROUP BY Orders.OrderID, C.CompanyName
ORDER BY Orders.OrderID;

-- 4

SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
GROUP BY Orders.OrderID, C.CompanyName
HAVING SUM(Quantity) > 250
ORDER BY Orders.OrderID;

-- 5

SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName, E.FirstName + ' ' + E.LastName AS 'Pracownik'
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
INNER JOIN Employees E ON E.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, C.CompanyName, E.FirstName + ' ' + E.LastName
HAVING SUM(Quantity) > 250
ORDER BY Orders.OrderID;

------------------------------------------------------------------------

-- æw 2

-- 1

SELECT CategoryName, SUM(Quantity) AS 'lzj'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName;

-- 2

SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName;

-- 3

--a
SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY lwz DESC;

--b
SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz',
SUM(Quantity) AS 'llzj'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY llzj;

-- 4

SELECT 
    O.OrderID,
    SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) + O.Freight AS OrderValue
FROM Orders AS O
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.Freight
ORDER BY O.OrderID;

------------------------------------------------------------------------

-- æw 3

-- 1
SELECT CompanyName, COUNT(OrderID) AS 'amount of orders'
FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY CompanyName

-- 2

SELECT TOP 1 CompanyName, COUNT(OrderID) AS 'amount of orders'
FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY CompanyName
ORDER BY [amount of orders] DESC


-- 3
SELECT FirstName + '' + LastName, SUM(OD.UnitPrice*Quantity*(1-Discount))
FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
GROUP BY FirstName + '' + LastName;

-- 4
SELECT TOP 1 FirstName + ' ' + LastName AS name, COUNT(OrderID)
FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY FirstName + ' ' + LastName
ORDER BY COUNT(OrderID) DESC; 

-- 5
SELECT TOP 1 FirstName + '' + LastName,
SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY FirstName + '' + LastName
ORDER BY lwz DESC;

------------------------------------------------------------------------
-- æw 4

--a)

select distinct a.firstname, a.lastname, round(sum(unitprice*[Order Details].Quantity*(1-Discount)),2)
from Employees a
left join Employees b on b.ReportsTo = a.EmployeeID
join Orders on a.EmployeeID = Orders.EmployeeID
join [Order Details] on orders.OrderID = [Order Details].OrderID
where b.EmployeeID is not null
group by a.FirstName, a.LastName, b.EmployeeID

-- b)

select (E.firstName + ' ' + E.lastname), round(sum(unitPrice*quantity*(1-discount)),2)
from Employees E
join orders o on e.EmployeeID = o.EmployeeID
join [Order Details] OD on o.OrderID = OD.OrderID
left join Employees e2 on e.EmployeeID = e2.ReportsTo
where e2.EmployeeID is null
group by (e.FirstName + ' ' + E.LastName)
order by 2 desc