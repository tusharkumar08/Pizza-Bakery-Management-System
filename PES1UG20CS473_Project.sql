--DDL Commands--
CREATE TABLE InstoreStaff(
    StaffId VARCHAR(10) PRIMARY KEY,
    fName VARCHAR(50),
    lName VARCHAR(50),
    ADDRESS VARCHAR(20) NOT NULL,
    ContactNo CHAR(10) NOT NULL,
    taxFileNo CHAR(12) NOT NULL,
    BankCode CHAR(6) NOT NULL,
    bName VARCHAR(20) NOT NULL,
    accNo CHAR(10) NOT NULL,
    Status VARCHAR(20),
    HourlyRate VARCHAR(10) NOT NULL
);
CREATE TABLE Customer (
    CustomerID CHAR(10) PRIMARY KEY,
    firstName VARCHAR(20) NOT NULL,
    lastname VARCHAR(20) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    phoneNumber VARCHAR(10) NOT NULL,
    isHoax VARCHAR(10) DEFAULT 'unverified',
    CHECK(isHoax IN ('verified', 'unverified')),
    CONSTRAINT chk_phone CHECK (phoneNumber not like '%[^0-9]%')
);
CREATE TABLE Orders (
    OrderNo CHAR(10) PRIMARY KEY,
    OrderDateTime VARCHAR(10),
    OrderType VARCHAR(10),
    TotalAmountDue VARCHAR(10),
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentApprovalNo VARCHAR(20) NOT NULL,
    OrderStatus VARCHAR(20),
    CustomerID CHAR(10),
    StaffId VARCHAR(10),
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(StaffId) REFERENCES InstoreStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE MenuSellingPrice(
    CurrentSellingPrice FLOAT PRIMARY KEY,
    Small VARCHAR(20),
    Medium VARCHAR(10),
    Large VARCHAR(10)
);
CREATE TABLE MenuItem(
    ItemCode CHAR(10) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Size VARCHAR(10) NOT NULL,
    Price FLOAT,
    CurrentSellingPrice FLOAT,
    Description VARCHAR(50),
    FOREIGN KEY (CurrentSellingPrice) REFERENCES MenuSellingPrice (CurrentSellingPrice) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE InstorePayRecord(
    TotalAmountPaid VARCHAR(20) PRIMARY KEY,
    GrossPayment CHAR(20),
    TaxWithheld CHAR(20)
);
CREATE TABLE InstorePay(
    RecordId VARCHAR(10) PRIMARY KEY,
    TotalAmountPaid VARCHAR(20),
    DatePayment VARCHAR(10),
    PeriodStartDate VARCHAR(10),
    PeriodEndDate VARCHAR(10),
    Foreign Key (TotalAmountPaid) references InstorePayRecord(TotalAmountPaid) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE InstoreShift(
    RecordId CHAR(10) PRIMARY KEY,
    StartDate VARCHAR(10),
    StartTime VARCHAR(10),
    EndDate VARCHAR(10),
    EndTime VARCHAR(10),
    StaffId VARCHAR(10) NOT NULL,
    InstorePayRecordId VARCHAR(10) NOT NULL,
    Foreign Key (StaffId) references InstoreStaff (StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
    Foreign Key (InstorePayRecordId) references InstorePay(RecordId) ON UPDATE CASCADE ON DELETE CASCADE
);

--Population of the database--
INSERT INTO InstoreStaff VALUES ('S0001', 'Ingel', 'Kate', '2/22 Riversdale rd', '0411223301', '111111222222', '019000', 'NAB', '5653666666', 'Processed', '20');
INSERT INTO InstoreStaff VALUES ('S0002', 'Angel', 'Kota', '2/40 Riversdale rd', '0411223302', '111111222233', '019000', 'NAB', '5653666665', 'Processed', '25');
INSERT INTO InstoreStaff VALUES ('S0003', 'Maria', 'Jane', '2/50 Riversdale St', '0411223303', '11111122234', '019000', 'NAB', '5653666667', 'Processed', '30');
INSERT INTO InstoreStaff VALUES ('S0004', 'Maria', 'DB', '2/56 Riversdale St', '0411223304', '111111222235', '019000', 'NAB', '5653666668', 'Processed', '35');
INSERT INTO InstoreStaff VALUES ('S0005', 'Mike', 'Jordan', '2/59 Riversdale St', '0411223305', '111111222236', '019000', 'NAB', '5653666669', 'Processed', '40');
INSERT INTO InstoreStaff VALUES ('S0006', 'Kobe', 'Sizzler', '2/90 Riversdale St', '0411223306', '111111222237', '019000', 'NAB', '5653666670', 'Processing', '45');


INSERT INTO Customer VALUES ('C2040', 'Felipe', 'Silva', '2/28 Marine Parade','0422410808', 'verified');
INSERT INTO Customer VALUES ('C2041', 'Fabian', 'Silvaa', '2/30 Marine Parade','0422410809', 'verified');
INSERT INTO Customer VALUES ('C2042', 'John', 'Solsa', '2/50 Marine Parade 2','0422410810', 'verified');
INSERT INTO Customer VALUES ('C2043', 'Dinesh', 'Salsa', '2/12 Marine Drive','0422410811', 'verified');
INSERT INTO Customer VALUES ('C2044', 'Benito', 'Suvarna', '3/90 Marine Drive','0422410812', 'unverified');
INSERT INTO Customer VALUES ('C2045', 'Jason', 'Silver', '2/40 Goldberg St','0422410813', 'verified');


INSERT INTO Orders VALUES ('00001','2021-06-18 10:34:09', 'Delivery', '100', 'card', 'AA10555551', null, 'C2040', 'S0003');
INSERT INTO Orders VALUES ('00002','2021-06-19 10:34:33', 'Delivery', '100', 'card', 'AA10555553', null, 'C2041', 'S0003');
INSERT INTO Orders VALUES ('00003','2021-06-18 10:40:09', 'Pickup', '100', 'card', 'AA10555552', null, 'C2042', 'S0002');
INSERT INTO Orders VALUES ('00004','2021-06-18 09:40:09', 'Pickup', '100', 'card', 'AA10555551', null, 'C2042', 'S0002');
INSERT INTO Orders VALUES ('00005','2021-06-18 07:40:09', 'Delivery', '100', 'card', 'AA10555554', null, 'C2042', 'S0002');
INSERT INTO Orders VALUES ('00006','2021-06-18 06:40:01', 'Pickup', '100', 'card', 'AA10555558', null, 'C2042', 'S0001');
INSERT INTO Orders VALUES ('00007','2021-06-19 05:40:10', 'Pickup', '100', 'card', 'AA10555559', null, 'C2042', 'S0004');

INSERT INTO MenuSellingPrice VALUES ( '30', '$10', '$20', '$30');
INSERT INTO MenuSellingPrice VALUES ( '10', '$10', '$20', '$30');
INSERT INTO MenuSellingPrice VALUES ( '20', '$10', '$20', '$30');
INSERT INTO MenuSellingPrice VALUES ( '40', '$10', '$20', '$30');
INSERT INTO MenuSellingPrice VALUES ( '50', '$20', '$30', '$40');

INSERT INTO MenuItem VALUES ('PZ001', 'Margarita', 'Large', '30', '30', 'Cheese and basil only');
INSERT INTO MenuItem VALUES ('PZ002', 'Salami', 'Large', '30', '30', 'Cheese and Salami');
INSERT INTO MenuItem VALUES ('PZ003', 'Seafood', 'Medium', '20', '20', 'Cheese and Seafood');
INSERT INTO MenuItem VALUES ('PZ004', 'Cheese Burst', 'Medium', '20', '20', 'Cheese Overload');
INSERT INTO MenuItem VALUES ('PZ005', 'Farmhouse', 'Large', '20', '20', 'Cheese and veggies');

INSERT INTO InstorePayRecord VALUES ( '200', '250', '50');
INSERT INTO InstorePayRecord VALUES ( '300', '350', '50');
INSERT INTO InstorePayRecord VALUES ( '400', '450', '50');
INSERT INTO InstorePayRecord VALUES ( '150', '200', '50');
INSERT INTO InstorePayRecord VALUES ( '350', '400', '50');


INSERT INTO InstorePay VALUES ('PAY0010', '200', '20210615', '20210606', '20210612');
INSERT INTO InstorePay VALUES ('PAY0009', '300', '20210530', '20210522', '20210528');
INSERT INTO InstorePay VALUES ('PAY0008', '400', '20210515', '20210506', '20210512');
INSERT INTO InstorePay VALUES ('PAY0012', '150', '20210516', '20210514', '20210515');
INSERT INTO InstorePay VALUES ('PAY0011', '350', '20210517', '20210515', '20210516');


INSERT INTO InstoreShift VALUES ( 'SFT10', '20210606', '01:00:00 PM', '20210606', '11:30:00 PM', 'S0001', 'PAY0010');
INSERT INTO InstoreShift VALUES ( 'SFT09', '20210528', '02:00:00 PM', '20210528', '11:30:00 PM', 'S0003', 'PAY0009');
INSERT INTO InstoreShift VALUES ( 'SFT08', '20210512', '04:00:00 PM', '20210512', '11:30:00 PM', 'S0001', 'PAY0008');
INSERT INTO InstoreShift VALUES ( 'SFT07', '20210514', '05:00:00 PM', '20210514', '11:30:00 PM', 'S0006', 'PAY0011');
INSERT INTO InstoreShift VALUES ( 'SFT06', '20210515', '06:00:00 PM', '20210515', '11:30:00 PM', 'S0005', 'PAY0012');


--Joins--
SELECT * FROM Orders INNER JOIN InstoreStaff WHERE Orders.StaffId = InstoreStaff.StaffId;
SELECT * FROM Orders INNER JOIN Customer WHERE Orders.CustomerID = Customer.CustomerID;
SELECT * FROM MenuItem INNER JOIN MenuSellingPrice WHERE MenuItem.CurrentSellingPrice = MenuSellingPrice.CurrentSellingPrice;
SELECT * FROM InstorePay INNER JOIN InstoreShift WHERE InstorePay.RecordId = InstoreShift.InstorePayRecordId;


--Aggregate Functions--
SELECT COUNT(*) FROM InstorePay WHERE TotalAmountPaid >= 200;
SELECT MIN(CurrentSellingPrice) as CheapestItem FROM MenuSellingPrice;
SELECT MAX(CurrentSellingPrice) as MostExpensiveItem FROM MenuSellingPrice;
SELECT AVG(CurrentSellingPrice) as AvgPrice FROM MenuSellingPrice;


--Set Operations--
SELECT StaffId as ID, fName, lName FROM InstoreStaff UNION SELECT CustomerID, firstName, lastname FROM Customer;
SELECT StaffId as ID, fName, lName FROM InstoreStaff INTERSECT SELECT CustomerID, firstName, lastname FROM Customer;
SELECT StaffId as ID, fName, lName FROM InstoreStaff EXCEPT SELECT CustomerID, firstName, lastname FROM Customer;
SELECT CustomerID as ID, firstName, lastname FROM Customer EXCEPT SELECT StaffId, fName, lName FROM InstoreStaff;


--Functions and Procedures--
DELIMITER $$

CREATE FUNCTION checkShiftLength(start_time TIME, end_time TIME)
RETURNS varchar(30)
DETERMINISTIC
BEGIN
	DECLARE hours int(10);
	DECLARE ans varchar(30);
    DECLARE diff int(10);

    SELECT TIMESTAMPDIFF(hour,start_time,end_time) into diff;

	IF diff > 3 THEN
		SET ans = "You have finished your daily quota";
	ELSE
		SET ans = "Daily quota incomplete.";
	END IF;

	RETURN ans;
END; $$


DELIMITER $$
CREATE PROCEDURE get_Shift()
        BEGIN
            SELECT RecordId, TotalAmountPaid FROM InstorePay WHERE InstorePay.TotalAmountPaid > 150;
        END; $$
DELIMITER;



--Triggers and Cursors--
CREATE TABLE audit_log(
    ItemCode CHAR(10) PRIMARY KEY,
    Operation CHAR(10),
    OldSize CHAR(10) NOT NULL,
    NewSize CHAR(10) NOT NULL
);


DELIMITER $$
CREATE trigger trigger_update
AFTER UPDATE ON MenuItem FOR EACH ROW
BEGIN
    INSERT into audit_log values(new.ItemCode, 'Update', old.Size, new.Size);
END $$
DELIMITER;

UPDATE MenuItem SET Size = 'Small'
WHERE ItemCode = 'PZ002';


--Cursor


CREATE table Items(
    ItemName VARCHAR(20) PRIMARY KEY
);

DELIMITER $$
CREATE PROCEDURE get_info()
BEGIN
DECLARE names VARCHAR(20);
DECLARE done INT DEFAULT 0;
DECLARE del_names CURSOR FOR SELECT name from MenuItem;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN del_names;
get_items_names: LOOP
FETCH del_names into names;
IF done=1 THEN LEAVE get_items_names
END IF;
insert into Items values(names);
END LOOP get_items_names;
CLOSE del_names;
END$$
DELIMITER;


