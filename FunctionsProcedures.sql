--Functions and Procedures (PES1UG20CS473)--
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