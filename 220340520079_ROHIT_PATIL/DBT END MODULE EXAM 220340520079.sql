/*1. Create table DEPT with the following structure:-*/

Create table DEPT(
DEPTNO	int(2),
DNAME varchar(15),
LOC	varchar(10)
);
drop table dept;

Insert into DEPT values
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30	,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

SELECT * FROM DEPT;

/*2. Create table EMP with the following structure:-*/
Create table EMP
( 
EMPNO int(4),
ENAME varchar(10),
JOB	varchar(9),
HIREDATE date,
SAL	float(7,2),
COMM float(7,2),
DEPTNO int(2)
);
drop table emp;


Insert into EMP VALUES
(7839,'KING','MANAGER','1991-11-17',5000,NULL,10),
(7698,'BLAKE','CLERK','1981-05-01',2850,NULL,30),
(7782,'CLARK','MANAGER','1981-06-09',2450,NULL,10),
(7566,'JONES','CLERK','1981-04-02',2975,NULL,20),
(7654,'MARTIN','SALESMAN','1981-09-28',1250,1400,30),
(7499,'ALLEN','SALESMAN','1981-02-20',1600,300,30);

SELECT * FROM EMP;

/*3.Display all the employees where SAL between 2500 and 5000 (inclusive of both).*/
SELECT * FROM EMP WHERE SAL BETWEEN 2500 AND 5000;

/*4. Display all the ENAMEs in descending order of ENAME.*/
SELECT ENAME FROM EMP ORDER BY ENAME DESC;

/*5.	Display all the JOBs in lowercase*/
SELECT LOWER(JOB)FROM EMP;

/*6.Display the ENAMEs and the lengths of the ENAMEs*/
SELECT ENAME, LENGTH(ENAME) FROM EMP;

/* 7. Display the DEPTNO and the count of employees who belong to that DEPTNO .*/
SELECT DEPTNO ,COUNT(*) AS 'TOTAL NO OF EMPLOYEES' FROM EMP GROUP BY DEPTNO;

/*8.	Display the DNAMEs and the ENAMEs who belong to that DNAME.*/
SELECT DNAME ,ENAME FROM DEPT,EMP WHERE EMP.DEPTNO=DEPT.DEPTNO;

/*9. Display the position at which the string ‘AR’ occurs in the ename.*/
SELECT INSTR(ENAME,'AR') AS POSITION FROM EMP;

/*10. Display the HRA for each employee given that HRA is 20% of SAL*/
SELECT ENAME ,SAL*0.2 AS "HRA" FROM EMP;


/*1.	Write a stored procedure by the name of PROC1 that accepts two varchar strings as parameters. Your procedure should then determine if the first varchar string exists inside the varchar string. For example, if string1 = ‘DAC’ and string2 = ‘CDAC, then string1 exists inside string2.  The stored procedure should insert the appropriate message into a suitable TEMPP output table. Calling program for the stored procedure need not be written*/
DROP TABLE TEMPP;
CREATE TABLE TEMPP(
STRING1 VARCHAR(100),
STRING2 VARCHAR(100),
MESSAGE VARCHAR(100)
);

DELIMITER //
CREATE PROCEDURE PROC1(STRING1 VARCHAR(100),
STRING2 VARCHAR(100))
BEGIN
	DECLARE MASSAGE VARCHAR(100);
    DECLARE NUMM INT;
		SELECT LOCATE(STRING1,STRING2) INTO NUMM;
        IF NUMM > 0 THEN INSERT INTO TEMPP VALUES(STRING1,STRING2,"string1 exists inside string2");
        ELSE INSERT INTO TEMPP VALUES (STRING1,STRING2,'string1 does not exists in string2');
		END IF;
        SELECT * FROM TEMPP;
END ; //
DELIMITER ;

CALL PROC1('DAC','CDAC');
CALL PROC1('DAC','MUMBAI');




/*2.	Create a stored function by the name of FUNC1 to take three parameters, the sides of a triangle. The function should return a Boolean value:- TRUE if the triangle is valid, FALSE otherwise. A triangle is valid if the length of each side is less than the sum of the lengths of the other two sides. Check if the dimensions entered can form a valid triangle. Calling program for the stored function need not be written.*/

DELIMITER //
CREATE FUNCTION FUNC1(A INT,B INT,C INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	IF A<(B+C) AND B<(A+C) AND C<(A+B) THEN
		RETURN TRUE;
	ELSE 	
		RETURN FALSE;
	END IF;
    END ; //
    DELIMITER ;
    
    CREATE TABLE TRIANGLE
    (
    A INT,
    B INT,
    C INT,
    REMARK VARCHAR(25)
    );
    ;
    DELIMITER //
    CREATE PROCEDURE TRIANGLEE(P INT, Q INT, R INT)
    BEGIN 
		IF FUNC1(P,Q,R) THEN
			INSERT INTO TRIANGLE VALUES (P,Q,R,"VALID TRIANGLE");
		ELSE 
			INSERT INTO TRIANGLE VALUES(P,Q,R,"VALID TRIANGLE");
		END IF;
	END ; //
    DELIMITER ;
        CALL TRIANGLEE(10,20,30);
        CALL TRIANGLEE(30,20,10);
        DROP PROCEDURE TRIANGLEE;
        SELECT DISTINCT * FROM TRIANGLE;
    DROP TABLE TRIANGLE;