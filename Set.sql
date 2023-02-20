--Set Operations (PES1UG20CS473)--
SELECT StaffId as ID, fName, lName FROM InstoreStaff UNION SELECT CustomerID, firstName, lastname FROM Customer;
SELECT StaffId as ID, fName, lName FROM InstoreStaff INTERSECT SELECT CustomerID, firstName, lastname FROM Customer;
SELECT StaffId as ID, fName, lName FROM InstoreStaff EXCEPT SELECT CustomerID, firstName, lastname FROM Customer;
SELECT CustomerID as ID, firstName, lastname FROM Customer EXCEPT SELECT StaffId, fName, lName FROM InstoreStaff;
