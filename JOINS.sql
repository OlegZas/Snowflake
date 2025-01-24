-- 1/24/25 
-- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
SELECT DISTINCT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, CONCAT(E2.FIRST_NAME, '',E2.LAST_NAME) AS EMPLOYEE, E2.HIRE_DATE, E2.SALARY
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID 
JOIN DEPARTMENTS D ON E2.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E2.SALARY
;
