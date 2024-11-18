

------------------------------------------------------------------------
-- zad 4

select (FirstName + ' ' + LastName), round(sum(UnitPrice * Quantity*(1-Discount)),2)
from Employees E
join Orders O on E.EmployeeID = O.EmployeeID
join [Order Details] OD on O.OrderID = OD.Discount
group by E.EmployeeID, (FirstName + ' ' + LastName)
order by 2 desc

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