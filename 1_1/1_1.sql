select CompanyName, Address from Customers where city = 'London'
select CompanyName, Address from Customers where country = 'France' or country = 'Spain'
select ProductName, UnitPrice from Products where UnitPrice > 20 and UnitPrice < 30
select * from Categories
select ProductName, UnitPrice from Products where CategoryID = 'Meat/Poultry'
select ProductName, UnitsInStock from Products where SupplierID = ''
select * from Products where QuantityPerUnit LIKE '%bottle%'
select Title from Employees where LastName like '[B-L]%'
select Title from Employees where LastName like '[B,L]%'
select CategoryName from Categories where Description like '%,%'
select CompanyName from Customers where CompanyName like '%Store%'
select * from Products where UnitPrice not between 10 and 20
select CompanyName, Country from Suppliers where Country = 'Japan' or Country = 'Italy'
select CompanyName, Country from Suppliers where Country in ('Japan', 'Italy')
select orderID, orderDate, CustomerID from Orders where shipCountry = 'Argentina' and ShippedDate is NULL




select * from Products where QuantityPerUnit like '%bottle%'
select Title from Employees where LastName like '[B-L]%'
select Title from Employees where LastName like '[BL]%'
select CategoryName from Categories where Description like '%,%'
select CompanyName from Customers where CompanyName like '%Store%' 

select * from Products where UnitPrice < 10 or UnitPrice > 20
select ProductName, UnitPrice from Products where UnitPrice between 20 and 30

select CompanyName, Country from Customers where country = 'Japan' or country = 'Italy'

select orderID, orderDate, CustomerID from Orders where 
	(ShippedDate is NULL or ShippedDate > GETDATE()) and ShipCountry = 'Argentina'

select CompanyName, Country from Customers order by Country, CompanyName
select CategoryID, ProductName, UnitPrice from Products order by UnitPrice DESC
select companyName, Country from Customers where Country in ('Japan', 'Italy') order by Country, CompanyName 

select ISNULL(phone, ' ') + ', ' + ISNULL(fax, ' ') as 'Nowa kolumna' from Suppliers /*where fax is not Null*/

select count(*) from Products where UnitPrice < 10 or UnitPrice > 20
select TOP 1 UnitPrice from Products where UnitPrice < 20 order by UnitPrice DESC
select max(UnitPrice) from Products where QuantityPerUnit like '%bottle%'
select min(UnitPrice) from Products where QuantityPerUnit like '%bottle%'
select avg(UnitPrice) from Products where QuantityPerUnit like '%bottle%'

select * from products where UnitPrice > avg(UnitPrice) /*NOO*/
select * from products where UnitPrice > (select avg(unitprice) from Products /*YESSS*/

