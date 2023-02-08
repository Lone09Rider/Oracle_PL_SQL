set SERVEROUTPUT ON;

DECLARE
-- global Variable
num1 number := 95;
num2 number := 85;
BEGIN
dbms_output.put_line('num 1 is : '|| num1);
    DECLARE
    -- local Variable
        num1 number := 915;
    BEGIN
        dbms_output.put_line('num 1 now is : '|| num1);
        dbms_output.put_line('num 2 is : '|| num2);
    END;
END;

--create table customers(
--id int,
--name varchar2(20)
--);

--create SEQUENCE seq 
--INCREMENT BY 1
--MINVALUE 100 MAXVALUE 999 NOCYCLE NOORDER NOCACHE;
--
--insert into customers VALUES(seq.NEXTVAL, 'Honey');

--SELECT * FROM customers;

DECLARE
    c_name varchar2(20);
BEGIN
    select name into c_name from customers
    where id=102;
    dbms_output.put_line('Name is : '|| c_name);
END;
    

-- IF THEN ELSE IF
DECLARE
    c_name varchar2(20);
BEGIN
    select name into c_name from customers
    where id=102;
    IF (c_name='Mani') THEN
        dbms_output.put_line('Name is : '|| c_name);
    ELSIF (c_name='Bunty') THEN
        dbms_output.put_line('Real Name is : '|| c_name);
    ELSE
        dbms_output.put_line('Else Name is : '|| c_name);
    END IF;
END;
    
    
--  CASE Statement
DECLARE
    grade varchar2(20):='a';
BEGIN
    CASE grade
        WHEN 'A' THEN dbms_output.put_line('Exellent');
        WHEN 'B' THEN dbms_output.put_line('V. Good');
        WHEN 'C' THEN dbms_output.put_line('Good');
        WHEN 'D' THEN dbms_output.put_line('Pass');
        ELSE
            dbms_output.put_line('Not Found');
    END CASE;
END;
/


-- Loops
DECLARE 
y number := 5;
BEGIN
LOOP
    dbms_output.put_line(y);
    y := y + 5;
    IF y > 25 THEN
        exit;
    END IF;
END LOOP;
END;
/

-- While Loop
DECLARE
y number := 5;
BEGIN
WHILE y < 25 
LOOP 
dbms_output.put_line(y);
y := y+5;
END LOOP;
END;
/

-- For Loop
DECLARE
y number;
BEGIN
FOR y in 1..10
LOOP
dbms_output.put_line(y);
END LOOP;
END;
/

-- PROCEDURE
CREATE OR REPLACE PROCEDURE example
AS
BEGIN
FOR i in 1..10 
LOOP
dbms_output.put_line(i);
END LOOP;
END;
/
---- METHOD 1 Calling procedures
EXECUTE example;

---- METHOD 2 Calling procedures
BEGIN
example;
END;
/

-- PARAMETERS in PEOCEDURES
CREATE OR REPLACE PROCEDURE getMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS
BEGIN
    IF x < y THEN 
        z := x;
    ELSE
        z := y;
    END IF;
END;

DECLARE
c NUMBER;
BEGIN
    getMin(11, 5, c);
    dbms_output.put_line(c);
END;


-- Drop Procedure
DROP PROCEDURE example;

DROP FUNCTION getMaxVal;
-- FUNCTION 
CREATE OR REPLACE FUNCTION getMaxVal(x IN number, y IN NUMBER)
RETURN NUMBER
AS
z NUMBER;
BEGIN
    IF x > y THEN
        z := x;
    ELSE
        z := y;
    END IF;
    RETURN z;
END;
/

DECLARE 
x number := 9;
y number := 99;
z number;
BEGIN
    z := getMaxVal(x, y);
    dbms_output.put_line('Maximum value is : '||z);
END;
/


-- Drop Function
DROP FUNCTION getMaxVal;

-- Cursors

-- 1. IMPLICIT on DML
-- %Found, %NotFound, %IsOpen, %RowCount

select * from students;

DECLARE 
    no_of_rows number(2);
BEGIN   
    UPDATE students 
    SET sid = sid+100
    WHERE dept_id<2;
    IF SQL%notfound THEN
        dbms_output.put_line('No Employees Such That');
    ELSIF SQL%found THEN
        no_of_rows := sql%rowcount;
        dbms_output.put_line('Row Count is : '||no_of_rows);
    END IF;
END;
/

-- EXPLICIT 
DECLARE 
    id students.sid%type;
    name students.sname%type;
    CURSOR cur IS 
        SELECT sid, sname from students;
BEGIN
    OPEN cur;
    LOOP
    FETCH cur INTO id, name;
        EXIT WHEN cur%notfound;
        dbms_output.put_line(id ||', '||name);
    END LOOP;
    CLOSE cur;
END;
/



DECLARE
    id students.sid%type;
    name students.sname%type;
    CURSOR cur IS
        SELECT sid, sname FROM students;
BEGIN
    FOR i IN cur
    LOOP
        dbms_output.put_line(i.sid ||', '||i.sname);
    END LOOP;
END;
/


-- EXCEPTION HANDLING

DECLARE
x number := 7;
y number;
BEGIN
y := 0;
x := x/y;
y := 7; 
dbms_output.put_line('y is : '||y);
EXCEPTION
WHEN ZERO_DIVIDE
THEN
dbms_output.put_line('Cannot Divide by 0');
dbms_output.put_line('x is : '||x);
dbms_output.put_line('y is : '||y);
END;
/

-- RAISING EXCEPTIONS
DECLARE
    a number := 0;
    ex_val EXCEPTION;
BEGIN
    IF a <= 0 THEN
        RAISE ex_val;
    ELSE 
        NULL;
    END IF;
    EXCEPTION
    WHEN ex_val THEN
        dbms_output.put_line('Value should be greater than 0');
    WHEN no_data_found THEN
        dbms_output.put_line('No Value');
    WHEN others THEN
        dbms_output.put_line('Error');
END;
/


-- PRE DEFINED EXCEPTIONS ARE :
--case_not_found
--no_data_found
--zero_divid
--too_many_rows
--value_error


-- Finally Pakages

CREATE OR REPLACE PACKAGE myPack
AS
PROCEDURE getID(s_id students.sid%TYPE);
END myPack;
/

CREATE OR REPLACE PACKAGE BODY myPack
AS
PROCEDURE getID(s_id students.sid%TYPE)
IS
d_id students.dept_id%type;
BEGIN
    SELECT dept_id into d_id FROM students
    where sid=s_id;
    dbms_output.put_line('Dept Id : '||d_id);
END getId;
END myPack;
/

BEGIN
myPack.getid(202);
END;
/














