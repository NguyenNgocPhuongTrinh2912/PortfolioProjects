USE Portforlio_Projects1


SELECT *
FROM sales

--Delete columns
ALTER TABLE sales
DROP COLUMN [index], Column1

--Explore missing values in each column
SELECT    COUNT(CASE WHEN [Date] IS NULL THEN 1 END) AS Date_Nulls,
	   COUNT(CASE WHEN [Year] IS NULL THEN 1 END) AS Year_Nulls,
	   COUNT(CASE WHEN [Month] IS NULL THEN 1 END) AS Month_Nulls,
	   COUNT(CASE WHEN [Customer Age] IS NULL THEN 1 END) AS CustomerAge_Nulls,
	   COUNT(CASE WHEN [Customer Gender] IS NULL THEN 1 END) AS CustomerGender_Nulls,
	   COUNT(CASE WHEN Country IS NULL THEN 1 END) AS Country_Nulls,
	   COUNT(CASE WHEN [State] IS NULL THEN 1 END) AS State_Nulls,
	   COUNT(CASE WHEN [Product Category] IS NULL THEN 1 END) AS ProductCategory_Nulls,
	   COUNT(CASE WHEN [Sub Category] IS NULL THEN 1 END) AS SubCategory_Nulls,
	   COUNT(CASE WHEN Quantity IS NULL THEN 1 END) AS Quantity_Nulls,
	   COUNT(CASE WHEN [Unit Cost] IS NULL THEN 1 END) AS UnitCost_Nulls,
	   COUNT(CASE WHEN [Unit Price] IS NULL THEN 1 END) AS UnitPrice_Nulls,
	   COUNT(CASE WHEN Cost IS NULL THEN 1 END) AS Cost_Nulls,
	   COUNT(CASE WHEN Revenue IS NULL THEN 1 END) AS Revenue_Nulls
FROM sales

--Find missing value
SELECT *
FROM sales
WHERE [Date] IS NULL

--Remove the row that has missing value
DELETE FROM sales
WHERE [Date] IS NULL

--Add Age_Brackets Column
WITH CTE AS
(
	SELECT *, CASE WHEN [Customer Age] < 31 THEN 'Youth'
				   WHEN [Customer Age] >54 THEN 'Old'
				   ELSE 'Adult'
			  END AS Age_Brackets
	FROM sales
)
select * from CTE

