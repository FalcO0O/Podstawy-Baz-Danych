use Northwind

-- Æwiczenie 1
select OrderID, sum(UnitPrice) from [Order Details] group by OrderID order by sum(UnitPrice) desc
select top 10 OrderID, sum(UnitPrice) from [Order Details] group by OrderID order by sum(UnitPrice) desc

-- Æwiczenie 2
select ProductID, sum(Quantity) from [Order Details] where ProductID < 3 group by ProductID
select ProductID, sum(Quantity) from [Order Details] group by ProductID
select OrderID, sum(round(UnitPrice * Quantity * (1-Discount),2)) as Cena 
	from [Order Details] group by OrderID having sum(Quantity) > 250 

-- Æwiczenie 3
select count(orderID) as [Liczba zamówieñ], EmployeeID from [Orders] group by EmployeeID
select shipVia, sum(Freight) from orders group by shipVia
select shipVia, sum(Freight) from orders where YEAR(ShippedDate) between 1996 and 1997 group by shipVia

-- Æwiczenie 4
select employeeid, COUNT(EmployeeID) as liczba, 
	YEAR(ShippedDate) as rok, MONTH(ShippedDate) as miesi¹c
	from Orders group by rollup (YEAR(ShippedDate), MONTH(ShippedDate), EmployeeID)

select max(UnitPrice) as max, min(UnitPrice) as min from products group by CategoryID

