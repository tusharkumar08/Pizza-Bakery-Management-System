--Trigger (PES1UG20CS473)--
DELIMITER $$
CREATE trigger trigger_update
AFTER UPDATE ON MenuItem FOR EACH ROW
BEGIN
    INSERT into audit_log values(new.ItemCode, 'Update', old.Size, new.Size);
END $$
DELIMITER;

UPDATE MenuItem SET Size = 'Small'
WHERE ItemCode = 'PZ002';


--Cursor (PES1UG20CS473)--
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
