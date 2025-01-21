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

-- ---------------------
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(255),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    state_province VARCHAR(100),
    country_id CHAR(2)
);
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Te', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brun', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
(2200, '12-98 Victoria Stree', '2901', 'Sydney', 'New South Wale', 'AU'),
(2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
(2500, 'Magdalen Centre, The', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
(2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
(2700, 'Schwanthalerstr. 703', '80925', 'Munich', 'Bavaria', 'DE'),
(2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
(2900, '20 Rue des Corps-Sai', '1730', 'Geneva', 'Geneve', 'CH'),
(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
(3100, 'Pieter Breughelstraa', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
(3200, 'Mariano Escobedo 999', '11932', 'Mexico Cit', 'Distrito Feder', 'MX');

/* 
3. Write a MySQL query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department.
*/
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, E.MANAGER_ID, D.LOCATION_ID, L.COUNTRY_ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.MANAGER_ID IS NOT NULL OR E.MANAGER_ID != 0 AND L.COUNTRY_ID IN (SELECT COUNTRY_ID FROM COUNTRIES WHERE UPPER(COUNTRY_NAME) = 'USA');
-- ALTERNATIVE WITH SUBQUERIES 
SELECT first_name, last_name 
FROM employees 
WHERE manager_id in 
    (SELECT employee_id 
    FROM employees 
    WHERE department_id 
    IN 
        (SELECT department_id 
        FROM departments 
        WHERE location_id 
        IN 
            (SELECT location_id 
            FROM locations 
            WHERE country_id='US')
        )
    );
/* 1/18/25
4. Write a MySQL query to find the name (first_name, last_name) of the employees who are managers.
*/
SELECT * 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID  IN(SELECT MANAGER_ID FROM EMPLOYEES)
;

/*
5. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.*/
SELECT FIRST_NAME, LAST_NAME, SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)FROM EMPLOYEES)
GROUP BY FIRST_NAME, LAST_NAME, SALARY

-----------------------
CREATE TABLE jobs (
    JOB_ID     STRING,
    JOB_TITLE  STRING,
    MIN_SALARY NUMBER,
    MAX_SALARY NUMBER
);

INSERT INTO jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) 
VALUES
    ('AD_PRES', 'President', 20000, 40000),
    ('AD_VP', 'Administration Vice President', 15000, 30000),
    ('AD_ASST', 'Administration Assistant', 3000, 6000),
    ('FI_MGR', 'Finance Manager', 8200, 16000),
    ('FI_ACCOUNT', 'Accountant', 4200, 9000),
    ('AC_MGR', 'Accounting Manager', 8200, 16000),
    ('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
    ('SA_MAN', 'Sales Manager', 10000, 20000),
    ('SA_REP', 'Sales Representative', 6000, 12000),
    ('PU_MAN', 'Purchasing Manager', 8000, 15000),
    ('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
    ('ST_MAN', 'Stock Manager', 5500, 8500),
    ('ST_CLERK', 'Stock Clerk', 2000, 5000),
    ('SH_CLERK', 'Shipping Clerk', 2500, 5500),
    ('IT_PROG', 'Programmer', 4000, 10000),
    ('MK_MAN', 'Marketing Manager', 9000, 15000),
    ('MK_REP', 'Marketing Representative', 4000, 9000),
    ('HR_REP', 'Human Resources Representative', 4000, 9000),
    ('PR_REP', 'Public Relations Representative', 4500, 10500);

/*
6. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade. */
SELECT FIRST_NAME, LAST_NAME, SALARY  
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID AND E.SALARY = J.MIN_SALARY ;

-- 1/19/2025
/* 7. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments. */
SELECT FIRST_NAME, LAST_NAME, SALARY, (SELECT AVG(SALARY) FROM EMPLOYEES)
FROM EMPLOYEES E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
        AND DEPARTMENT_ID IN(SELECT DEPARTMENT_ID  FROM DEPARTMENTS WHERE DEPARTMENT_NAME LIKE '%IT%')
;
-- *****************************************************************************************************

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES 
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000.00, 0.00, 0, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1987-06-18', 'AD_VP', 17000.00, 0.00, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1987-06-19', 'AD_VP', 17000.00, 0.00, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1987-06-20', 'IT_PROG', 9000.00, 0.00, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1987-06-21', 'IT_PROG', 6000.00, 0.00, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1987-06-22', 'IT_PROG', 4800.00, 0.00, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1987-06-23', 'IT_PROG', 4800.00, 0.00, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1987-06-24', 'IT_PROG', 4200.00, 0.00, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1987-06-25', 'FI_MGR', 12000.00, 0.00, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1987-06-26', 'FI_ACCOUNT', 9000.00, 0.00, 108, 100);

INSERT INTO employees 
    (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
VALUES 
    (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '1987-09-17', 'SH_CLERK', 4000.00, 0.00, 123, 50);

-- *****************************************************************************************************
-- *****************************************************************************************************
/*8. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of  Bell. */
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'BELL' );

/* 9. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments. */ 
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES E 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

/*10. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of each department. */ 
SELECT E.first_name, E.last_name, E.salary
FROM EMPLOYEES E
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS avg_dept_salary ON E.department_id = avg_dept_salary.department_id
WHERE E.salary > avg_dept_salary.avg_salary;

/*1/20/25
11. Write a MySQL query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.*/
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY > (SELECT SUM(SALARY)FROM EMPLOYEES WHERE JOB_ID = 'SH_CLERK');

-- 12. Write a MySQL query to find the name (first_name, last_name) of the employees who are not supervisors.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (SELECT MANAGER_ID FROM EMPLOYEES) ;

--13. Write a MySQL query to display the employee ID, first name, last name, and department names of all employees.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
ORDER BY SALARY DESC;
-- ALTERNATIVE: 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E ;

-- *************************
/* 1/21/25_____14. Write a MySQL query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.  */
SELECT FIRST_NAME, LAST_NAME, SALARY, E.DEPARTMENT_ID, D.DEPARTMENT_ID,     
    (
        SELECT AVG(E2.SALARY)
        FROM EMPLOYEES E2
        INNER JOIN DEPARTMENTS D2 ON E2.DEPARTMENT_ID = D2.DEPARTMENT_ID
        WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID
    ) AS AVERAGE_SAL
FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY > (SELECT AVG(E2.SALARY) AS AVERAGE_SAL FROM EMPLOYEES E2 INNER JOIN DEPARTMENTS D2 ON E2.DEPARTMENT_ID = D2.DEPARTMENT_ID WHERE E.DEPARTMENT_ID = E2.DEPARTMENT_ID
  );
--  15. Write a MySQL query to fetch even numbered records from employees table.
SELECT DISTINCT *
FROM EMPLOYEES E 
WHERE EMPLOYEE_ID % 2 = 0 
;
