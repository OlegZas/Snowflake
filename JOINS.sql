-- 1/24/25 
-- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
SELECT DISTINCT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, CONCAT(E2.FIRST_NAME, '',E2.LAST_NAME) AS EMPLOYEE, E2.HIRE_DATE, E2.SALARY
FROM EMPLOYEES E
JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID 
JOIN DEPARTMENTS D ON E2.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E2.SALARY
;

--12. Write a MySQL query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
SELECT J.*
FROM JOB_HISTORY J
INNER JOIN EMPLOYEES E ON E.EMPLOYEE_ID = J.EMPLOYEE_ID AND SALARY > 10000
;

--11. Write a MySQL query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
SELECT JOB_TITLE, FIRST_NAME, LAST_NAME, SALARY, MIN_SALARY,(E.SALARY - MIN_SALARY) AS SALARY_DIFFERENCE_FROM_MIN 
FROM EMPLOYEES E 
INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID
;
