/*
Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks.
*/

-- CONNECT TO DATABASE

USE AdventureWorks2008R2;
SELECT TOP(5) SalesOrderID, AccountNumber, OrderDate
FROM Sales.SalesOrderHeader
WHERE AccountNumber 
IN (SELECT AccountNumber
    FROM Sales.SalesOrderHeader
    GROUP BY AccountNumber
    HAVING SUM(SubTotal) > 70000)
ORDER BY OrderDate DESC;