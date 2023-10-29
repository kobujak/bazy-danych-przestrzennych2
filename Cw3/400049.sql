USE AdventureWorksDW2019
GO

CREATE OR ALTER PROC EUR_GBP_YearsAgo
	@YearsAgo INT
AS
	SELECT FCR.*, DC.CurrencyAlternateKey FROM dbo.FactCurrencyRate FCR
	LEFT JOIN dbo.DimCurrency DC on DC.CurrencyKey = FCR.CurrencyKey
	WHERE
		(DC.CurrencyAlternateKey = 'EUR' OR DC.CurrencyAlternateKey = 'GBP') 
		AND DATEADD(YYYY,-@YearsAgo,GETDATE()) >= FCR.Date
GO

EXEC EUR_GBP_YearsAgo @YearsAgo = 12
