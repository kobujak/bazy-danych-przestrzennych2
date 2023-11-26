use AdventureWorksDW2019

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CSV_Customers' AND TABLE_SCHEMA = 'dbo')
   DROP TABLE [dbo].[CSV_Customers];
GO


CREATE TABLE dbo.CSV_Customers (
FirstName nvarchar(255), 
LastName nvarchar(255), 
EmailAdress nvarchar(255),
Adress nvarchar(255),
City nvarchar(255),
Region nvarchar(255),
PhoneNumber nvarchar(255),
CREATE_TIMESTAMP datetime,
UPDATE_TIMESTAMP datetime,

);




select * from dbo.CSV_Customers order by UPDATE_TIMESTAMP desc, CREATE_TIMESTAMP desc