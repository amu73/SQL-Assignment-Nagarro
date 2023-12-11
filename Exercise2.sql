/*
Write separate queries using 
a join, 
a subquery, 
a CTE, and 
then an EXISTS to list all AdventureWorks customers who have not placed an order.
*/

-- CONNECT TO DATABASE
USE AdventureWorks2008R2;

-- 2.1 Using Join
SELECT DISTINCT P.BusinessEntityID, P.FirstName, P.LastName
FROM Person.Person P
LEFT JOIN Sales.Customer C
 ON P.BusinessEntityID = C.PersonID
LEFT JOIN Sales.SalesOrderHeader H
 ON C.CustomerID = H.CustomerID
WHERE H.SalesOrderID IS NULL

-- 2.2 Using a subquerry
SELECT DISTINCT P.BusinessEntityID,P.FirstName, P.LastName
FROM Person.Person P
WHERE P.BusinessEntityID NOT IN (
 SELECT C.PersonID
 FROM Sales.Customer C
 JOIN Sales.SalesOrderHeader H
 ON C.CustomerID = H.CustomerID
 );
-- ORDER BY  P.BusinessEntityID;

--2.3 USING CTE
WITH ActiveCustomers (BusinessEntityID)
AS (
 SELECT DISTINCT C.PersonID
 FROM Sales.Customer C
 JOIN Sales.SalesOrderHeader H
 ON C.CustomerID = H.CustomerID
)
SELECT DISTINCT P.BusinessEntityID, P.FirstName, P.LastName
FROM Person.Person P
LEFT JOIN ActiveCustomers A
	ON A.BusinessEntityID = P.BusinessEntityID
WHERE A.BusinessEntityID IS NULL;

--2.4 USING EXISTS
SELECT DISTINCT P.BusinessEntityID, P.FirstName, P.LastName
FROM Person.Person P
WHERE NOT EXISTS (
 SELECT * FROM Sales.Customer C
 JOIN Sales.SalesOrderHeader H
 ON C.CustomerID = H.CustomerID
 WHERE C.PersonID = P.BusinessEntityID
 );