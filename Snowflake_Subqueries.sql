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
/*
4. Write a MySQL query to find the name (first_name, last_name) of the employees who are managers.
*/
SELECT * 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID  IN(SELECT MANAGER_ID FROM EMPLOYEES)
;
