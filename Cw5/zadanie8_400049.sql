use AdventureWorksDW2019

------ zadanie 8

SELECT 
	FIS.OrderDate, 
	Count(*) as Orders_cnt
FROM dbo.FactInternetSales FIS
GROUP BY FIS.OrderDate
ORDER BY Orders_cnt DESC

------ zadanie 8 a)

SELECT 
	FIS.OrderDate, 
	Count(*) as Orders_cnt
FROM dbo.FactInternetSales FIS
GROUP BY FIS.OrderDate
HAVING Count(*) < 100
ORDER BY Orders_cnt DESC

------ zadanie 8 b)

SELECT 
	PR.OrderDate,
	DP.EnglishProductName,
	PR.RowNum,
	PR.UnitPrice
FROM (
	SELECT 
		FIS.ProductKey,
		FIS.OrderDate,
		ROW_NUMBER() OVER(PARTITION BY FIS.OrderDate ORDER BY FIS.UnitPrice DESC) AS RowNum,
		FIS.UnitPrice
	FROM dbo.FactInternetSales FIS
	) as PR
JOIN DimProduct DP on DP.ProductKey = PR.ProductKey
WHERE PR.RowNum <= 3
ORDER BY PR.OrderDate