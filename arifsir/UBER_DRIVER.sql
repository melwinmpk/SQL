CREATE TABLE TRIP_TABLE (
So_No number PRIMARY KEY, 
Driver varchar2(10), 
Date_OF_TRIP DATE
);
CREATE SEQUENCE So_No START WITH 1;

DESC TRIP_TABLE;

-- TO_DATE('2021-01-01','YYYY-MM-DD')
INSERT ALL
  INTO TRIP_TABLE (Driver,Date_OF_TRIP) VALUES ('Driver1', TO_DATE('2021-01-01','YYYY-MM-DD'))
SELECT * FROM DUAL;

