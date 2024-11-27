-- podaj nazwy przewoznikow ktorzy w 03.1998 przewozili produkty z kategorii meat/poultry
-- podaj nazwy przewoznikow ktorzy w 03.1997 NIE przewozili produkty z kategorii meat/poultry
-- dla ka¿dego przewoŸnika podaj wartoœæ produktów z kategorii meat/poultry które przewozi³ w marcu 1998
-- 2 sposobami

select distinct companyName from Suppliers S -- powinno byæ 3 federal express speedy package i united package
join Orders O on o.ShipVia = S.SupplierID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID
join Categories c on p.CategoryID = c.CategoryID
where c.CategoryName = 'meat/poultry' and MONTH(o.OrderDate) = 3 and year(o.OrderDate) = 1998

select distinct companyName, (
select CategoryName from Categories c
join Products p on p.CategoryID = c.CategoryID
join [Order Details] od on od.ProductID = p.ProductID
join Orders o on od.OrderID = o.OrderID
where c.CategoryName = 'meat/poultry'
and MONTH(o.OrderDate) = 3 and year(o.OrderDate) = 1998
)
from Suppliers




select distinct companyName from Suppliers S -- 1 powinno byc
join Orders O on o.ShipVia = S.SupplierID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID
join Categories c on p.CategoryID = c.CategoryID
where c.CategoryName != 'meat/poultry' or not (MONTH(o.OrderDate) = 3 and year(o.OrderDate) = 1998)

select companyName, -- 2 wyniki (jeden null)
(select count(
	UnitPrice*Quantity*(1-discount)) from [Order Details] od
	join orders o on o.OrderID = od.OrderID
	join Suppliers s on s.SupplierID = o.ShipVia
)
from Suppliers

