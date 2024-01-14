DROP TABLE IF EXISTS CUSTOMERS_400049;

CREATE TABLE CUSTOMERS_400049 (
    ProductKey int,
    CurrencyAlternateKey char(3),
    FIRST_NAME varchar(255),
    LAST_NAME varchar(255),
    OrderDateKey date,
    OrderQuantity int,
    UnitPrice float,
    SecretCode char(10)
)