use Northwind

select max(unitPrice) as max_cena from [Order Details] group by OrderID order by max_cena desc
select max(unitPrice) as max_cena, min(unitPrice) as min_cena from [Order Details] group by OrderID
select sum(shipVia) from Orders group by shipVia
select top 1 sum(shipVia) as [Liczba zamówieñ] from Orders where YEAR(ShippedDate) = 1997 group by shipVia order by [Liczba zamówieñ] desc 


select orderid, count(*) as [liczba] from [Order Details] group by orderid having count(orderid) > 5

-- TODO
SELECT CustomerID, count(*) AS [iloœæ zamówieñ] 
FROM orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY customerID 
-- ORDER BY 


SELECT null, null, SUM(quantity) FROM orderhist

SELECT productid,null, SUM(quantity)
FROM orderhist
GROUP BY productid

SELECT productid, quantity
FROM orderhist
ORDER BY productid, quantity DESC


-- zadanie domowe 
-- 2.1


select top 1 len(firstName) from Employees order by len(firstName) desc
select count(*) from Orders where RequiredDate < ShippedDate

SELECT orderID from [Order Details]
	GROUP by orderID
	HAVING min(Discount) > 0

-- w którym kwartale zosta³o z³o¿one najwiêcej zamówieñ?

select count(*) as cnt, datepart(quarter, orderDate) from Orders group by datepart(quarter, orderDate) order by cnt desc

