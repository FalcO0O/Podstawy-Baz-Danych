-- Æw. 1

-- 1 do domu

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

-- æw. 2

SELECT DISTINCT P.ProductName, quantity
FROM [order details] AS ord1
join Products P on P.ProductID = ord1.ProductID 
WHERE quantity = ( 
	SELECT MAX(quantity)
		FROM [order details] AS ord2
		WHERE ord1.productid =
		ord2.productid 
)

--------------------------------------------------------------------------
-- æw 4

-- 1 - Podaj ³¹czn¹ wartoœæ zamówienia o numerze 10250 (uwzglêdnij cenê za przesy³kê)

select round(sum(quantity * unitprice * (1-Discount)) + (select freight from orders where orderid = 10250),2) as '10250'
from [Order Details]
where OrderID = 10250

select OD.OrderID, round(sum((UnitPrice * Quantity) * (1-Discount) + 
(select freight from orders where orders.OrderID = 10250)),2)
from [Order Details] OD
where OD.OrderID = 10250
group by OD.OrderID

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
-- 86
SELECT DISTINCT CustomerID
from Orders
WHERE YEAR(OrderDate) = 1997
-- 91
select distinct CustomerID
	FROM Customers


-- æw 5

select firstName, LastName, (select (unitPrice * quantity * (1-discount)) from [Order Details] od
join orders o on o.OrderID = od.OrderID
join Employees e on o.OrderDate = e.EmployeeID
) from Employees

-- zadanie domowe:
-- dokoñczyæ 3_1 - 4_1