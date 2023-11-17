use AdventureWorksDW2019


-- stg_dimemp
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'stg_dimemp' AND TABLE_SCHEMA = 'dbo')
   DROP TABLE [dbo].[stg_dimemp];
GO

SELECT 
	EmployeeKey, 
	FirstName, 
	LastName, 
	Title 
INTO dbo.stg_dimemp 
FROM dbo.DimEmployee
WHERE
	EmployeeKey BETWEEN 270 AND 275



--scd_dimemp

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'scd_dimemp' AND TABLE_SCHEMA = 'dbo')
   DROP TABLE [dbo].[scd_dimemp];
GO




CREATE TABLE dbo.scd_dimemp (
EmployeeKey int, 
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Title nvarchar(50),
StartDate datetime,
EndDate datetime,
--PRIMARY KEY(EmployeeKey) -- z primary key, nie jest tworzony nowy rekord, tylko aktualizowany jest ju¿ istniej¹cy w scd_dimemp, bez PK tworzony jest nowy rekord ale z tym samym EmployeeKey
);

INSERT INTO dbo.scd_dimemp (EmployeeKey,FirstName,LastName,Title,StartDate,EndDate)
SELECT EmployeeKey,FirstName,LastName,Title,StartDate,EndDate
FROM dbo.DimEmployee
WHERE
	EmployeeKey BETWEEN 270 AND 275


-- zadanie 5

-- sprawdzanie

SELECT * FROM dbo.stg_dimemp
SELECT * FROM dbo.scd_dimemp

--b

update dbo.stg_dimemp
set LastName = 'Nowak'
where EmployeeKey = 270;
update dbo.stg_dimemp
set Title = 'Senior Design Engineer'
where EmployeeKey = 274;

--c

update STG_DimEmp
set FIRSTNAME = 'Ryszard'
where EmployeeKey = 275

--zadanie 6 
/* 

W przypadku pierwszego query z zadania 5 b), mamy do czynienia z SCD typu 1: overwrite. Stara wartoœæ zosta³a zast¹piona now¹ w tabeli stg_dimemp oraz w tabeli scd_dimemp.
W drugim query jest to SCD typu 2: add new row, dodany jest nowy rekord, a w starym zmieniane jest end date pokazuj¹ce ¿e rekord jest nieaktualny.
W Query 5 c) mamy typ 0: retain original. W tym przpadku nie dopuszczamy do modyfikacji rekordu, ani nie tworzymy nowego.

*/
--zadanie 7

-- W przypadku query z æwiczenia 5 c), wp³yw na dzia³anie mia³o ustawienie atrybutu FirstName jako fixed, co uniemo¿liwia jego zmianê.