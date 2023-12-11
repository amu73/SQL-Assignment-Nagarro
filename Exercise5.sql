/*
Write a Procedure supplying name information from the Person.
Person table and accepting a filter for the first name. 
Alter the above Store Procedure to supply Default Values if user does not enter any value.
( Use AdventureWorks)
*/

-- CONNECT TO DATABASE

USE AdventureWorks2008R2;

GO
CREATE PROCEDURE NamesInfo
@Name varchar(50) = 'Ken'
AS
Begin
SELECT BusinessEntityID,FirstName, LastName,PersonType
FROM Person.Person
WHERE FirstName = @Name;
END

GO
EXECUTE  NamesInfo
EXECUTE NamesInfo @Name = 'Ben'
DROP PROCEDURE NamesInfo;

