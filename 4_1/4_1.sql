use Northwind

-- Æw. 1

-- 1

SELECT DISTINCT Customers.CompanyName, Customers.Phone
FROM Customers
INNER JOIN Orders O on Customers.CustomerID = O.CustomerID
INNER JOIN Shippers S on O.ShipVia = S.ShipperID
WHERE year(ShippedDate) = 1997 AND S.CompanyName = 'United Package';

-- 2 

select c.companyName, c.Phone
from Customers c
where c.CustomerID in
(select c2.customerId from Customers c2
join orders o on c2.CustomerID = o.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID
join Categories c3 on p.CategoryID = c3.CategoryID
and c3.CategoryName = 'Confections'
)

-- 3

select c.companyName, c.Phone
from Customers c
where c.CustomerID in
(select c2.customerId from Customers c2
join orders o on c2.CustomerID = o.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID
join Categories c3 on p.CategoryID = c3.CategoryID
and not c3.CategoryName = 'Confections'
)


--------------------------------------------------------------------------


-- æw. 2

-- 1

SELECT DISTINCT P.ProductName, quantity
FROM [order details] AS ord1
join Products P on P.ProductID = ord1.ProductID 
WHERE quantity = ( 
	SELECT MAX(quantity)
		FROM [order details] AS ord2
		WHERE ord1.productid =
		ord2.productid 
)

-- 2

SELECT P.ProductName, P.UnitPrice
FROM Products P
WHERE P.UnitPrice < (
 SELECT AVG(UnitPrice) FROM Products
 ); 

 -- 3

SELECT P.ProductID, P.ProductName
FROM Products AS P
WHERE P.UnitPrice < (
SELECT AVG(UnitPrice)
	FROM Products AS P2
	WHERE P2.CategoryID = P.CategoryID
) 

--------------------------------------------------------------------------

-- æw 3

-- 1

SELECT P.ProductName, P.UnitPrice, 
	(SELECT AVG(UnitPrice)
	FROM Products) AS 'averagePrice',
	P.UnitPrice - (SELECT AVG(UnitPrice) FROM Products) AS 'difference'
FROM Products AS P;


-- 2

SELECT 
(SELECT C.CategoryName
	FROM Categories AS C
	WHERE C.CategoryID = P.CategoryID) AS 'CategoryName',
P.ProductName, P.UnitPrice,
(SELECT AVG(P2.UnitPrice)
	FROM Products AS P2
	WHERE P2.CategoryID = P.CategoryID) AS 'AveragePriceByCategory',
	P.UnitPrice - (SELECT AVG(P2.UnitPrice)
FROM Products AS P2
WHERE P2.CategoryID = P.CategoryID) AS 'difference'
FROM Products AS P

--------------------------------------------------------------------------
-- æw 4

-- 1 - Podaj ³¹czn¹ wartoœæ zamówienia o numerze 10250 !

select round(sum(quantity * unitprice * (1-Discount)) + (select freight from orders where orderid = 10250),2) as '10250'
from [Order Details]
where OrderID = 10250

-- 2
select o.orderId, round((select sum(UnitPrice * quantity *(1-discount)) from [Order details] as od
where o.orderid = od.orderid) + o.freight,2) from orders as o

-- 3

SELECT CustomerID,Address,City,Country
FROM Customers
WHERE CustomerID NOT IN (
SELECT DISTINCT CustomerID
FROM Orders
WHERE YEAR(OrderDate) = 1997
);

-- sprawdzenie
-- 86
SELECT DISTINCT CustomerID
from Orders
WHERE YEAR(OrderDate) = 1997

-- 91
select distinct CustomerID
	FROM Customers

-- 4

SELECT T.ProductName
FROM (SELECT DISTINCT p.ProductID as ProductID, p.ProductName as ProductName, o.CustomerID as CustomerID
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID 
GROUP BY p.ProductID, p.ProductName, o.CustomerID) as T 
GROUP BY T.ProductID, T.ProductName
HAVING COUNT (T.ProductID) >= 2

-- æw 5

-- 1
SELECT (SELECT (FirstName +' '+ LastName) 
FROM Employees 
WHERE Orders.EmployeeID=Employees.EmployeeID) as 'Pracownik',
ROUND(SUM(Quantity*UnitPrice*(1-Discount)+Freight), 2) as 'Wartosc'
FROM [Order Details]
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY EmployeeID

-- 2

SELECT TOP 1 E.FirstName + ' ' + e.LastName as 'name', (
 SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
 from Orders AS O
 INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
 WHERE E.EmployeeID = O.EmployeeID AND year(O.ShippedDate) = 1997
 ) AS 'value'
FROM Employees as e
ORDER BY value DESC


-- 3

-- a) którzy maj¹ podw³adnych

SELECT E.FirstName + ' ' + E.LastName AS 'name', 
(SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
from Orders AS O
INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
WHERE E.EmployeeID = O.EmployeeID) + (SELECT sum(O.Freight)
from Orders as o
WHERE o.EmployeeID = e.EmployeeID)
FROM Employees AS E
WHERE e.EmployeeID IN (select distinct a.EmployeeID
from Employees as a
inner join Employees as b on a.EmployeeID = b.ReportsTo)


-- b) którzy nie maj¹ podw³adnych

SELECT E.FirstName + ' ' + E.LastName AS 'name', 
(SELECT SUM(OD.UnitPrice*od.quantity*(1-od.Discount))
from Orders AS O
INNER JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
WHERE E.EmployeeID = O.EmployeeID) + (SELECT sum(O.Freight)
from Orders as o
WHERE o.EmployeeID = e.EmployeeID)
FROM Employees AS E
WHERE e.EmployeeID IN (select distinct a.EmployeeID
from Employees as a
left join Employees as b on a.EmployeeID = b.ReportsTo
where b.EmployeeID is null);

-- 4

-- a)
SELECT 
    E.FirstName + ' ' + E.LastName AS 'name', 
    (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
     FROM Orders AS O
     INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
     WHERE E.EmployeeID = O.EmployeeID) +
    (SELECT SUM(O.Freight)
     FROM Orders AS O
     WHERE O.EmployeeID = E.EmployeeID) AS TotalSales,
    (SELECT MAX(O.OrderDate)
     FROM Orders AS O
     WHERE O.EmployeeID = E.EmployeeID) AS LastOrderDate
FROM Employees AS E
WHERE E.EmployeeID IN (
    SELECT DISTINCT A.EmployeeID
    FROM Employees AS A
    INNER JOIN Employees AS B ON A.EmployeeID = B.ReportsTo
);

-- b)
SELECT 
    E.FirstName + ' ' + E.LastName AS 'name', 
    (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
     FROM Orders AS O
     INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
     WHERE E.EmployeeID = O.EmployeeID) +
    (SELECT SUM(O.Freight)
     FROM Orders AS O
     WHERE O.EmployeeID = E.EmployeeID) AS TotalSales,
    (SELECT MAX(O.OrderDate)
     FROM Orders AS O
     WHERE O.EmployeeID = E.EmployeeID) AS LastOrderDate
FROM Employees AS E
WHERE E.EmployeeID IN (
    SELECT DISTINCT A.EmployeeID
    FROM Employees AS A
    LEFT JOIN Employees AS B ON A.EmployeeID = B.ReportsTo
    WHERE B.EmployeeID IS NULL
);
