--Joins (PES1UG20CS473)--
SELECT * FROM Orders INNER JOIN InstoreStaff WHERE Orders.StaffId = InstoreStaff.StaffId;
SELECT * FROM Orders INNER JOIN Customer WHERE Orders.CustomerID = Customer.CustomerID;
SELECT * FROM MenuItem INNER JOIN MenuSellingPrice WHERE MenuItem.CurrentSellingPrice = MenuSellingPrice.CurrentSellingPrice;
SELECT * FROM InstorePay INNER JOIN InstoreShift WHERE InstorePay.RecordId = InstoreShift.InstorePayRecordId;
