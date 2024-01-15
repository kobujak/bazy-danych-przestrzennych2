# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## 2024-01-15


### Added
- Package `/Cw11/s400049.dtsx` which exectutes Web Service Task
- WSDL `/Cw11/calc_400049.wsdl` file which is used to get methods from web service 
- Result file from task execution `/Cw11/calc_400049.txt`

## 2024-01-15


### Added
- Catalog `/projekt/bcp`  with commands in `/projekt/bcp/bcp.txt` to create `/projekt/bcp/CUSTOMERS_400049.fmt` and add result file to Sql Server database using bcp.
- Result file from ETL processing `/projekt/bcp/CUSTOMERS_400049.csv`
- Format file `/projekt/bcp/CUSTOMERS_400049.fmt`
- Screenshot `/projekt/400049.png` of results form table *CUSTOMERS_400049* 

### Changed
- Added sql password encrpytion in base64 to script `/projekt/s400049.sh`. User now must provide password for his postgresql database

### Fixed
- Fixed randomizing SecretCode value in `/projekt/update_table.sql`

## 2024-01-14


### Added

- New directory with ETL script `/projekt`. This directory contains shell scirpt `/projekt/s400049.sh` which downloads file, validates it and inserts records into postgre database.
  Additionally there are two sql queries `/projekt/create_table.sql` and `/projekt/update_table.sql` which are used while script is executed. Logfile  `/projekt/s400049_01142024.log` with example output is also provided.
  For more information about check changelog in script.

## 2023-12-04


### Added

- Package `/Cw9/s400049.dtsx` which creates *STG_CUSTOMERS* table, unzips provided file. Data from unzipped files is inserted into previously created table using Foreach loop container.
  Email adress is set to null for records from every second file using For loop container.
- Screenshot `/Cw8/cw8_400049.png` with results of package execution from *STG_CUSTOMERS* table.

## 2023-12-04

### Added

- Screenshot `/Cw8/cw8_400049_sql.png` with results from audit table.

### Changed

- Renamed `/Cw8/cw8_400049.png` to `/Cw8/cw8_400049_ssis.png`


## 2023-11-27

### Added

- Package `/Cw8/s400049.dtsx` which checks which implements audit logic in data flow created in `/Cw7/s400049.dtsx`.
- Sql file `/Cw8/cw8_400049.sql` which creates *AUDIT_TABLE* table in AdventureWorksDW2019 to insert audit records.
- Screenshot `/Cw8/cw8_400049.png` with control flow from `/Cw8/s400049.dtsx` package.


## 2023-11-26

### Added

- Package `/Cw7/s400049.dtsx` which checks if file `/Cw7/Customers_FULL.xml` exists. If the result is true, truncates all existing data from *CSV_Customers* table and inserts records from `/Cw7/Customers_FULL.xml` file and sets current date.
  as CREATE_TIMESTAMP
  If result is false, file `/Cw7/Customers_09DEC2020.xml` is used as a source file. Package compares existing records in *CSV_Customers* table with records in file. If records with the same FirstName, LastName and EmailAdress exists, it performs 
  an update and sets current date in UPDATE_TIMESTAMP field. When record has no match in database it is inserted into *CSV_Customers* and CREATE_TIMESTAMP is set for this entry.
- Sql file `/Cw7/cw7.sql` which creates *CSV_Customers* table in AdventureWorksDW2019 database and queries data from this table which is used for screenshot.
- Screenshot `/Cw7/cw7_400049.png` with results of `/Cw7/s400049.dtsx` package execution.
- Source file `/Cw7/Customers_FULL.xml` with `/Cw7/Customers_FULL.xsd` schema
- Source file `/Cw7/Customers_09DEC2020.xml` with `/Cw7/Customers_09DEC2020.xsd` schema


## 2023-11-17

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

