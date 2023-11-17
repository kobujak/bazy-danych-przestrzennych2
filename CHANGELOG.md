# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## 2023-11-14

### Added

- Package `/Cw6/s400049.dtsx` with SCD transformation workin on *stg_dimemp* and *scd_dimemp* tables.
- Sql file `/Cw6/cw6_400049.sql` which creates *stg_dimemp* and *scd_dimemp* tables based on *DimEmployee* table from AdventureWorksDW2019 database.
  This file also contains updates to test SSIS process and answers to questions 6 and 7 from Exercise 6.

## 2023-11-14

### Added

- New Screenshot `/Cw5/zadanie7_400049.png` of Data Viewer from .dtsx package execution.

### Fixed

- Fixed Package `/Cw5/s400049.dtsx` which now counts number of orders in each day instead of individual sold products.
- Query 8 and query 8a `/Cw5/zadanie8_400049.sql` to show Orders count instead of individual sold products

## 2023-11-13

### Added

- Package `/Cw5/s400049.dtsx` which counts number of sales from each day from FactInternetSales table in AdventureWorksDW2019 database.
- Screenshot `/Cw5/zadanie7_400049.png` of Data Viewer from .dtsx package execution.
- Sql file `/Cw5/zadanie8_400049.sql` with three queries,
  first mimicking .dtsx package, second limits result by showing days with less than 100 sales
  and third outputs three products with highest Unit Price.


## 2023-11-07

### Added

- Package `/Cw4/s400049.dtsx` which joins 3 tables from AdventureWorksDW2019 database, 
  creates new column with customer info and returns only records with purchase of socks
- Output file `/Cw4/cw4_400049.txt` created by exectution of .dtsx package.
- Sql query with dbo.FactInternetSales table information `/Cw4/cw4_400049.sql`


## 2023-10-29

### Added

- Answers to questions from Lab 3
- Stored procedure mimicking `/Cw3/s400049.dtsx` into `/Cw3/400049.sql` 

### Fixed

 - Conditional Split in `/Cw3/s400049.dtsx`

### Changed

- SSIS package `/Cw3/s400049.dtsx`
- Output file `/Cw3/cw3_400049.csv`

## 2023-10-28

### Added

- SSIS package `/Cw3/s400049.dtsx` which writes historical Currency Rates for EUR and GBP from 'X' years ago. 
- Output file `/Cw3/cw3_400049.csv` created by exectution of .dtsx package.

