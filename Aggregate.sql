--Aggregate Functions (PES1UG20CS473)--
SELECT COUNT(*) FROM InstorePay WHERE TotalAmountPaid >= 200;
SELECT MIN(CurrentSellingPrice) as CheapestItem FROM MenuSellingPrice;
SELECT MAX(CurrentSellingPrice) as MostExpensiveItem FROM MenuSellingPrice;
SELECT AVG(CurrentSellingPrice) as AvgPrice FROM MenuSellingPrice;
