USE Portfolio_Projects2

SELECT *
FROM basket

--Drop unnecessary columns
ALTER TABLE basket
DROP COLUMN F1, F18

--Check null values
SELECT COUNT(CASE WHEN Apple IS NULL THEN 1 END) AS Apple_Nulls,
	   COUNT(CASE WHEN Bread IS NULL THEN 1 END) AS Bread_Nulls,
	   COUNT(CASE WHEN Butter IS NULL THEN 1 END) AS Butter_Nulls,
	   COUNT(CASE WHEN Cheese IS NULL THEN 1 END) AS Cheese_Nulls,
	   COUNT(CASE WHEN Corn IS NULL THEN 1 END) AS Corn_Nulls,
	   COUNT(CASE WHEN Dill IS NULL THEN 1 END) AS Dill_Nulls,
	   COUNT(CASE WHEN Eggs IS NULL THEN 1 END) AS Eggs_Nulls,
	   COUNT(CASE WHEN [Ice cream] IS NULL THEN 1 END) AS Ice_cream_Nulls,
	   COUNT(CASE WHEN [Kidney Beans] IS NULL THEN 1 END) AS Kidney_Beans_Nulls,
	   COUNT(CASE WHEN Milk IS NULL THEN 1 END) AS Milk_Nulls,
	   COUNT(CASE WHEN Nutmeg IS NULL THEN 1 END) AS Nutmeg_Nulls,
	   COUNT(CASE WHEN Onion IS NULL THEN 1 END) AS Onion_Nulls,
	   COUNT(CASE WHEN Sugar IS NULL THEN 1 END) AS Sugar_Nulls,
	   COUNT(CASE WHEN Unicorn IS NULL THEN 1 END) AS Unicorn_Nulls,
	   COUNT(CASE WHEN Yogurt IS NULL THEN 1 END) AS Yogurt_Nulls,
	   COUNT(CASE WHEN chocolate IS NULL THEN 1 END) AS Chocolate_Nulls
FROM basket

--Create new table for market basket analysis
CREATE TABLE cross_selling (
    Antecedent VARCHAR(50),
    Consequent VARCHAR(50),
	Antecedent_Order INT,
	Consequent_Order INT,
	Antecedent_Consequent_Order INT,
	Total_Order INT,
    Support FLOAT,
	Confidence FLOAT,
	Lift FLOAT
);

--Insert values to antecedent and consequent column
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Apple');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Bread');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Butter');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Cheese');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Corn');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Dill');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Ice cream');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Kidney Beans');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Milk');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Nutmeg');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Onion');
insert into cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Sugar');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Unicorn');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Yogurt');
INSERT INTO cross_selling(Antecedent, Consequent)
VALUES ('Eggs','Chocolate');

--Calculate Antecedent_Order Column
UPDATE cross_selling
SET Antecedent_Order =
(SELECT COUNT(CASE WHEN Eggs = 1 THEN 1 END) 
FROM basket
)

--Calculate Consequent_Order Column
UPDATE cross_selling
SET Consequent_Order =
(SELECT(CASE WHEN Consequent = 'Apple' THEN COUNT(CASE WHEN Apple = 1 THEN 1 END)
			 WHEN Consequent = 'Bread' THEN COUNT(CASE WHEN Bread = 1 THEN 1 END)
			 WHEN Consequent = 'Butter' THEN COUNT(CASE WHEN Butter = 1 THEN 1 END)
			 WHEN Consequent = 'Cheese' THEN COUNT(CASE WHEN Cheese = 1 THEN 1 end) 
			 WHEN Consequent = 'Corn' THEN COUNT(CASE WHEN Corn = 1 THEN 1 end)
			 WHEN Consequent = 'Dill' THEN COUNT(CASE WHEN Dill = 1 THEN 1 end)
			 WHEN Consequent = 'Ice cream' THEN COUNT(CASE WHEN [Ice cream] = 1 THEN 1 end)
			 WHEN Consequent = 'Kidney Beans' THEN COUNT(CASE WHEN [Kidney Beans] = 1 THEN 1 end)
			 WHEN Consequent = 'Milk' THEN COUNT(CASE WHEN Milk = 1 THEN 1 end)
			 WHEN Consequent = 'Nutmeg' THEN COUNT(CASE WHEN Nutmeg = 1 THEN 1 end)
			 WHEN Consequent = 'Onion' THEN COUNT(CASE WHEN Onion = 1 THEN 1 end)
			 WHEN Consequent = 'Sugar' THEN COUNT(CASE WHEN Sugar = 1 THEN 1 end)
			 WHEN Consequent = 'Unicorn' THEN COUNT(CASE WHEN Sugar = 1 THEN 1 end)
			 WHEN Consequent = 'Yogurt' THEN COUNT(CASE WHEN Yogurt = 1 THEN 1 end)			 
			 WHEN Consequent = 'Chocolate' THEN COUNT(CASE WHEN chocolate = 1 THEN 1 end)
			
END)
FROM basket
)

--Calculate Antecedent_Consequent_Order Column
UPDATE cross_selling
SET Antecedent_Consequent_Order =
(SELECT(CASE WHEN Consequent = 'Apple' THEN COUNT(CASE WHEN Eggs = 1 AND Apple = 1 THEN 1 END)
			 WHEN Consequent = 'Bread' THEN COUNT(CASE WHEN Eggs = 1 AND Bread = 1 THEN 1 END)
			 WHEN Consequent = 'Butter' THEN COUNT(CASE WHEN Eggs = 1 AND Butter = 1 THEN 1 END)
			 WHEN Consequent = 'Cheese' THEN COUNT(CASE WHEN Eggs = 1 AND Cheese = 1 THEN 1 END)
			 WHEN Consequent = 'Corn' THEN COUNT(CASE WHEN Eggs = 1 AND Corn = 1 THEN 1 END)
			 WHEN Consequent = 'Dill' THEN COUNT(CASE WHEN Eggs = 1 AND Dill = 1 THEN 1 END)
			 WHEN Consequent = 'Ice cream' THEN COUNT(CASE WHEN Eggs = 1 AND [Ice cream] = 1 THEN 1 END)
			 WHEN Consequent = 'Kidney Beans' THEN COUNT(CASE WHEN Eggs = 1 AND [Kidney Beans] = 1 THEN 1 END)
			 WHEN Consequent = 'Milk' THEN COUNT(CASE WHEN Eggs = 1 AND Milk = 1 THEN 1 END)
			 WHEN Consequent = 'Nutmeg' THEN COUNT(CASE WHEN Eggs = 1 AND Nutmeg = 1 THEN 1 END)
			 WHEN Consequent = 'Onion' THEN COUNT(CASE WHEN Eggs = 1 AND Onion = 1 THEN 1 END)
			 WHEN Consequent = 'Sugar' THEN COUNT(CASE WHEN Eggs = 1 AND Sugar = 1 THEN 1 END)
			 WHEN Consequent = 'Unicorn' THEN COUNT(CASE WHEN Eggs = 1 AND Unicorn = 1 THEN 1 END)
			 WHEN Consequent = 'Yogurt' THEN COUNT(CASE WHEN Eggs = 1 AND Yogurt = 1 THEN 1 END)
			 WHEN Consequent = 'Chocolate' THEN COUNT(CASE WHEN Eggs = 1 AND chocolate = 1 THEN 1 END)		
END)
FROM basket
)

--Calculate Total_Order Column
UPDATE cross_selling
SET Total_Order = (SELECT COUNT(*)
				   FROM basket)

--Calculate Support Column
UPDATE cross_selling
SET Support = ROUND((CAST(Antecedent_Consequent_Order AS FLOAT)/Total_Order),4)

--Calculate Confidence Column
UPDATE cross_selling
SET Confidence = ROUND((CAST(Antecedent_Consequent_Order AS FLOAT)/Antecedent_Order),4)

--Calculate Column
UPDATE cross_selling
SET Lift = ROUND((CAST(Antecedent_Consequent_Order AS FLOAT)/Antecedent_Order)/(CAST(Consequent_Order AS FLOAT)/Total_Order),4)

SELECT * 
FROM cross_selling
ORDER BY LIFT DESC


