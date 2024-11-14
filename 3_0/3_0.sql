use Northwind

-- Æwiczenie 1


select prod.ProductName, orders.UnitPrice from [Order Details] as orders join Products as prod
	on orders.ProductID = prod.ProductID
	where orders.UnitPrice between 20 and 30

select ProductName, UnitsInStock from Products as prod join Suppliers as sup
	on prod.SupplierID = sup.SupplierID
	where sup.CompanyName = 'Tokyo Traders'


select companyName, address from Customers join orders 
	on orders.CustomerID = Customers.CustomerID
	where YEAR(orders.OrderDate) != 1997


select companyName, phone from Suppliers join Products
	on Products.SupplierID = Suppliers.SupplierID
	where UnitsInStock in (0, null)

-- Æwiczenie 2

use library

select firstName, LastName, birth_date from member join juvenile
	on juvenile.member_no = member.member_no

select in_date, DATEDIFF(DAY, DUE_DATE, IN_Date) from loanhist join title 
	on title.title_no = loanhist.title_no
	where title.title = 'Tao Teh King' and DATEDIFF(DAY, DUE_DATE, IN_Date) > 0

select isbn from reservation join member on reservation.member_no = member.member_no
	where 'Stephen A. Graff' = firstname + ' ' + middleinitial + '. ' + lastname 

-- Æwiczenie 3

use Northwind

select productName, UnitPrice, address from Products 
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID
where (UnitPrice between 20 and 30) and CategoryName = 'Meat/Poultry'

select productName, UnitPrice, Address from Products 
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID
join Categories on Categories.CategoryID = Products.CategoryID
where CategoryName =  'Confections'



select distinct Customers.companyName, Customers.phone from Customers 
	join Orders on Customers.CustomerID = Orders.CustomerID
	join shippers on Shippers.ShipperID = Orders.ShipVia
	where YEAR(Orders.OrderDate) = 1997 and Shippers.CompanyName = 'United Package'



select companyName, phone from Customers
	join orders on Orders.CustomerID = Customers.CustomerID
	join [Order Details] on orders.OrderID = [Order Details].OrderID
	join Products on Products.ProductID = [Order Details].ProductID
	join Categories on Categories.CategoryID = Products.CategoryID
	where CategoryName = 'Confections'

-- Æwiczenie 4

use library

select firstName, lastName, birth_date, street + ' ' + city as adres from member
	inner join juvenile on member.member_no = juvenile.member_no
	inner join adult on adult.member_no = juvenile.adult_member_no

	
select child.firstName, child.lastName, birth_date, street + ' ' + city as adres, 
	parent.firstname + ' ' + parent.lastname as parent from member as child
	join juvenile on child.member_no = juvenile.member_no
	join adult on adult.member_no = juvenile.adult_member_no
	join member as parent on adult.member_no = parent.member_no


use Northwind

SELECT 
    manager.FirstName + ' ' + manager.LastName AS ManagerName,
    subordinate.FirstName + ' ' + subordinate.LastName AS SubordinateName
FROM Employees AS manager
JOIN Employees AS subordinate ON subordinate.ReportsTo = manager.EmployeeID


SELECT 
    manager.FirstName + ' ' + manager.LastName AS ManagerName,
    subordinate.FirstName + ' ' + subordinate.LastName AS SubordinateName
FROM Employees AS manager
LEFT JOIN Employees AS subordinate ON subordinate.ReportsTo = manager.EmployeeID
where subordinate.FirstName is null


use library

select street + ' ' + city as Adres from adult 
join juvenile on adult.member_no = juvenile.adult_member_no
where juvenile.birth_date <	CONVERT(date,'1996-01-01') 

select street + ' ' + city as Adres from adult 
join juvenile on adult.member_no = juvenile.adult_member_no
left join loan on loan.member_no = adult.member_no
where juvenile.birth_date <	CONVERT(date,'1996-01-01') and loan.member_no is null

-- dodatkowe

use Northwind
select CompanyName, COUNT(OrderID) from Customers
left outer join orders on orders.CustomerID = Customers.CustomerID
group by CompanyName
order by 2


select CompanyName, COUNT(OrderID) from Customers
left outer join orders on orders.CustomerID = Customers.CustomerID
and YEAR(OrderDate) = 1997 and MONTH(OrderDate) = 3
group by CompanyName
order by 2


SELECT TOP 1 s. CompanyName, Count(o.OrderID)
FROM Shippers s
LEFT OUTER JOIN Orders o ON s.ShipperID = o.ShipVia
WHERE YEAR(o.ShippedDate) = 1997 
GROUP BY s. CompanyName
order by COUNT(o.OrderID) desc


select top 1 Suppliers.companyName, count(OrderID) as Num from Suppliers
join Products on Products.SupplierID = Suppliers.SupplierID
join [Order Details] on Products.ProductID = [Order Details].ProductID
group by CompanyName
order by Num desc -- Ÿle ig

select Orders.OrderID, OrderDate, CompanyName, 
sum(round((UnitPrice * (1-discount)) * quantity, 2)) as Wartosc
from Orders
join [Order Details] on [Order Details].OrderID = Orders.OrderID
join Customers on Customers.CustomerID = Orders.CustomerID
group by Orders.OrderID -- to tez Ÿle

select distinct CompanyName, Phone from Customers as C
join orders as O on o.CustomerID = C.CustomerID
join [Order Details] as OD on OD.OrderID = o.OrderID
join Products as P on p.ProductID = od.ProductID
join Categories as CA on CA.CategoryID = P.CategoryID
where CategoryName = 'Confections'


-- do domu klienci którzy nie kupili z kat. confections i w roku 1997 (bez podzapytañ!)
SELECT DISTINCT CompanyName, Phone
FROM Customers AS C
JOIN Orders AS O ON O.CustomerID = C.CustomerID
WHERE C.CustomerID NOT IN (
    SELECT C.CustomerID
    FROM Customers AS C
    JOIN Orders AS O ON O.CustomerID = C.CustomerID
    JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
    JOIN Products AS P ON P.ProductID = OD.ProductID
    JOIN Categories AS CA ON CA.CategoryID = P.CategoryID
    WHERE CA.CategoryName = 'Confections'
) and YEAR(O.OrderDate) = 1997

SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY c.CustomerID, c.CompanyName, c.Phone
HAVING SUM(CASE WHEN cat.CategoryName = 'Confections' THEN 1 ELSE 0 END) = 0;







-- Æwiczenie 5

use library

select (firstName + ' ' + lastName) as name, (street + ' ' + city + ' ' + state + ' ' + zip) as address 
from member
inner join adult on adult.member_no = member.member_no


select firstname, lastname, birth_date, 
(street + ' ' + city + ' ' + state + ' ' + zip) as address 
from member 
inner join juvenile on member.member_no = juvenile.member_no
inner join adult on juvenile.adult_member_no = adult.member_no


-- podaj to wszystko i imiona rodziców
SELECT m. firstname, m.lastname, j.birth_date, a.state, a.city, a. street,
m2.firstname as adult_firstname, m2.lastname as adult_lastname
FROM [member] m
INNER JOIN juvenile j ON m. member_no = j.member_no
INNER JOIN adult a ON j. adult_member_no = a.member_no
INNER JOIN [member] m2 ON a.member_no = m2.member_no



use Northwind
-- napisz polecenie które wyœwietla pracownikow oraz ich podwladnych

select employer.FirstName + ' ' + employer.lastName as pracownik,
employee.FirstName + ' ' +employee.LastName as raportuje_do
from Employees as employer
inner join Employees as employee on employer.EmployeeID = employee.ReportsTo

-- wyswietl pracownikow ktorzy nie maja podwladnych

SELECT e.FirstName, e.lastname from Employees e
LEFT JOIN Employees s on e.EmployeeID = s.ReportsTo
where s.EmployeeID is null


SELECT distinct e.FirstName, e.lastname from Employees e
LEFT JOIN Employees s on e.EmployeeID = s.ReportsTo
where s.EmployeeID is not null

use library

select distinct adult.member_no, (street + ' ' + city + ' ' + state + ' ' + zip) as address from [member]
inner join adult on member.member_no = adult.member_no
inner join juvenile on adult.member_no = juvenile.adult_member_no
where year(juvenile.birth_date) < 1996

select distinct adult.member_no, (street + ' ' + city + ' ' + state + ' ' + zip) as address from adult
inner join juvenile j on adult.member_no = j.adult_member_no
left join loanhist l on l.member_no = adult.member_no
where year(j.birth_date) < 1996
and (l.member_no is null or l.due_date > GETDATE())

use library
select firstname, lastname, count(*) as child_num
from adult
inner join dbo.member m on m.member_no = adult.member_no
inner join dbo.juvenile j on adult.member_no = j.adult_member_no
where state = 'AZ'
group by firstname, lastname, m.member_no
having count(*) > 2

UNION
select firstname, lastname, count(*) as child_num
from adult
inner join dbo.member m on m.member_no = adult.member_no
inner join dbo.juvenile j on adult.member_no = j.adult_member_no
where state = 'CA'
group by firstname, lastname, m.member_no
having count(*) > 3
order by child_num desc
	

use Northwind
SELECT o.OrderID, ROUND(SUM(od.Quantity * od.UnitPrice * (1-od.Discount)), 2) as koszt,
e.FirstName, e.LastName FROM Orders o 
INNER JOIN [Order Details] od ON o. OrderID = od.OrderID
INNER JOIN Customers c ON o. CustomerID = c. CustomerID
INNER JOIN Employees e ON o. EmployeeID = e. EmployeeID
GROUP BY o.OrderID, c.CompanyName,e.FirstName, e. LastName 
HAVING SUM(od.Quantity) > 250