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




