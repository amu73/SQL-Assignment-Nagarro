/*
Create a function that takes as inputs a 
SalesOrderID, 
a Currency Code, 
and a date, 
and returns a table of all the SalesOrderDetail rows for that Sales Order including 
Quantity, ProductID, UnitPrice, and the unit price converted to the target currency based on the end of day rate for the date provided. 
Exchange rates can be found in the Sales.CurrencyRate table. 
( Use AdventureWorks)
*/

-- CONNECT TO DATABASE;
USE AdventureWorks2008R2; 

GO
CREATE FUNCTION Sales.uf_NewFunction(@SalesOrderId int,@CurrencyCode nchar(3),@Date datetime)
RETURNS TABLE
AS
RETURN
SELECT sod.ProductID AS 'Product ID',
sod.OrderQty AS ' Order Quantity',
sod.UnitPrice As 'Unit Price',
sod.UnitPrice*cr.EndOfDayRate AS 'Target Price'
FROM Sales.SalesOrderDetail AS sod,
Sales.CurrencyRate AS cr
WHERE cr.ToCurrencyCode = @CurrencyCode AND
cr.ModifiedDate = @Date AND
sod.SalesOrderID = @SalesOrderID


GO
Select * from Sales.uf_NewFunction(65253,'MXN','2008-03-01 00:00:00.000');
DROP FUNCTION Sales.uf_NewFunction;
