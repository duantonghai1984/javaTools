
CREATE TABLE MYCAT_SEQUENCE (
name VARCHAR(50) NOT NULL,
current_value INT NOT NULL,
increment INT NOT NULL DEFAULT 1000,
PRIMARY KEY(name)
) ENGINE=InnoDB;
INSERT INTO MYCAT_SEQUENCE(name,current_value,increment) VALUES ('TEST', 100000, 100);


CREATE FUNCTION mycat_seq_currval(seq_name VARCHAR(50)) RETURNS varchar(64) CHARSET utf8 
DETERMINISTIC 
BEGIN DECLARE retval VARCHAR(64); 
SET retval="-999999999,null"; 
SELECT concat(CAST(current_value AS CHAR),",",CAST(increment AS CHAR)) INTO retval FROM MYCAT_SEQUENCE WHERE name = seq_name; 
RETURN retval; END


CREATE FUNCTION mycat_seq_setval(seq_name VARCHAR(50),value INTEGER) RETURNS varchar(64) CHARSET utf8 
DETERMINISTIC 
BEGIN UPDATE MYCAT_SEQUENCE SET current_value = value WHERE name = seq_name; RETURN mycat_seq_currval(seq_name); 
END

CREATE FUNCTION mycat_seq_nextval(seq_name VARCHAR(50)) RETURNS varchar(64) CHARSET utf8 
DETERMINISTIC 
BEGIN UPDATE MYCAT_SEQUENCE SET current_value = current_value + increment WHERE name = seq_name; 
RETURN mycat_seq_currval(seq_name); 
END