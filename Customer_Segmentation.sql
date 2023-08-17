USE Portforlio_Project

SELECT *
FROM online_retail

--Find out missing values
SELECT COUNT(CASE WHEN Invoice IS NULL THEN 1 END) AS Invoice_Nulls,
	   COUNT(CASE WHEN StockCode IS NULL THEN 1 END) AS StockCode_Nulls,
	   COUNT(CASE WHEN Description IS NULL THEN 1 END) AS Description_Nulls,
	   COUNT(CASE WHEN Quantity IS NULL THEN 1 END) AS Quantity_Nulls,
	   COUNT(CASE WHEN InvoiceDate IS NULL THEN 1 END) AS InvoiceDate_Nulls,
	   COUNT(CASE WHEN Price IS NULL THEN 1 END) AS Price_Nulls,
	   COUNT(CASE WHEN [Customer ID] IS NULL THEN 1 END) AS CustomerID_Nulls,
	   COUNT(CASE WHEN Country IS NULL THEN 1 END) AS Country_Nulls
FROM online_retail

--Remove missing values
DELETE FROM online_retail
WHERE [Customer ID] IS NULL

--Remove canceled orders
DELETE FROM online_retail
WHERE Invoice LIKE 'C%'

--Check Duplicates
WITH CTE AS
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Invoice, StockCode, Quantity, InvoiceDate, [Customer ID] ORDER BY InvoiceDate ) AS Duplicate
	FROM online_retail
),
/*SELECT *
FROM CTE
WHERE Duplicate > 1*/

--Calculate RFM metrics without duplicates
	 RFM AS
(
	SELECT [Customer ID], 
		   DATEDIFF(DAY, CAST(MAX(InvoiceDate) AS DATE) ,'2011-12-10') AS Recency, --Date from customer's last purchase
		   COUNT(DISTINCT(Invoice)) AS Frequency,--Total number of purchases
		   SUM(Quantity*Price) AS Monetary --Total spend by the customer
	FROM CTE
	WHERE Duplicate = 1
	GROUP BY [Customer ID]
),
--Lable RFM Scores
	Score AS
(
	SELECT *,
		   NTILE(5) OVER (ORDER BY Recency DESC) AS Recency_Score, --The nearest date gets 5 and the furthest date gets 1
		   NTILE(5) OVER (ORDER BY Frequency) AS Frequency_Score, --The least frequency gets 1 and the maximum frequency gets 5
		   NTILE(5) OVER (ORDER BY Monetary) AS Monetary_Score --The least money gets 1, the most money gets 5
	FROM RFM
),
	RFM_Score AS
(
	SELECT *,
		   CONCAT(Recency_Score,Frequency_Score,Monetary_Score) AS RFM_Score
	FROM Score
),
--Define RFM Scores as Segments
	Seg AS
(
	SELECT *,
		   CASE WHEN RFM_Score LIKE '[1,2][1,2]%' THEN 'Hibernating'
			    WHEN RFM_Score LIKE '[1,2][3,4]%' THEN'At_Risk'
				WHEN RFM_Score LIKE '[1,2]5%' THEN 'Cant_Loose'
				WHEN RFM_Score LIKE '3[1,2]%' THEN 'About_to_Sleep'
			    WHEN RFM_Score LIKE '33%' THEN 'Need_attention'
				WHEN RFM_Score LIKE '[3,4][4,5]%' THEN 'Loyal_Customers'
				WHEN RFM_Score LIKE '41%' THEN 'Promising'
				WHEN RFM_Score LIKE '51%' THEN 'New_Customers'
				WHEN RFM_Score LIKE '[4,5][2,3]%' THEN 'Potential_Loyalists'
				WHEN RFM_Score LIKE '5[4,5]%' THEN 'Champions'
		   END AS Segment
	FROM RFM_Score
)
SELECT * 
FROM Seg



