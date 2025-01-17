---> set the Role
USE ROLE accountadmin;

---> set the Warehouse
USE WAREHOUSE OLEG_HOUSE;

USE OLEG_DATA.SUBQUERY_TEST_OZ;
/*
1. Write a MySQL query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Greenberg'.
*/
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (select salary 
    from employees 
    where UPPER(last_name)='GREENBERG')
    ; 
select * from employees WHERE LAST_NAME = 'Greenberg';

/* 
2. Write a MySQL query to find the name (first_name, last_name) of all employees who works in the IT department.
*/ 
select * FROM EMPLOYEES ;
SELECT * FROM DEPARTMENTS;

SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d on e.department_id = d.department_id AND UPPER(department_name) like '%IT%';

-- ALTERNATIVE : 
select * 
from employees 
WHERE department_id IN (select department_id from departments where UPPER(department_name) LIKE '%IT%')
