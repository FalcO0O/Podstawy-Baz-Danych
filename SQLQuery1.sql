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

select round(sum(unitPrice*Quantity*(1-Discount)),2) from [Order Details] where orderid = 10250
