/* **************
   SQL Window Function - Part #1
   Video URL - https://youtu.be/Ww71knvhQ-s?si=qngs_x4jDu3FeyhO
 ************** */

/*
Insert data from employeeCompanyA.sql file
*/

/*
1) Partition By Similar to Group By but it use in OVER clause in window function.
2) Can use Order By clause inside OVER clause in window function.
3) DENSE_RANK() does not leave gaps in ranking after ties, while RANK() leaves gaps in the ranking sequence.
4) LEAD(): Retrieves the value of a specified column from the next row in the window.
   LAG(): Retrieves the value of a specified column from the previous row in the window.
5) LEAD(): LEAD(column_name, offset, default_value) OVER (PARTITION BY column_name ORDER BY column_name)
  LAG(): LAG(column_name, offset, default_value) OVER (PARTITION BY column_name ORDER BY column_name)
*/

SELECT * FROM employeeCompanyA;

-- Max salary earn by employeeCompanyA

SELECT MAX(salary) FROM employeeCompanyA;

SELECT * 
FROM employeeCompanyA 
WHERE salary = (SELECT MAX(salary) FROM employeeCompanyA);

-- Max Salary of each department
SELECT dept_name, MAX(salary) AS max_salary
FROM employeeCompanyA
GROUP BY dept_name;

-- Max Salary of the table with other details (Only possible with window function)
SELECT a.*,
	MAX(a.salary) OVER() AS max_salary
FROM employeeCompanyA AS a;

-- Max Salary of each department with other details (Only possible with window function)
SELECT a.*,
	MAX(a.salary) OVER(PARTITION BY a.dept_name) AS max_salary
FROM employeeCompanyA AS a;


/* ROW_NUMBER() Window Function */

-- a) Assign unique row number to each employee
SELECT ROW_NUMBER() OVER() AS SN,
	a.*
FROM employeeCompanyA AS a;

-- b) Assign unique row number to each employee as per department
SELECT ROW_NUMBER() OVER(PARTITION BY a.dept_name) AS SN_dept,
	a.*
FROM employeeCompanyA AS a;

SELECT ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY emp_id) AS rn,
	a.*
FROM employeeCompanyA AS a;

-- Q.1 Fetch the first 2 old employee of each department to join the company.
SELECT * FROM (
	SELECT 
        ROW_NUMBER() OVER(PARTITION BY a.dept_name ORDER BY emp_ID) AS rn,
		a.*
	FROM employeeCompanyA AS a
) empAsDept
WHERE empAsDept.rn < 3;

/* RANK() Window Function */
-- Q.2 Fetch the max 3 employee of each department getting higher salary.

SELECT * FROM (
	SELECT RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk,
		a.*
	FROM employeeCompanyA AS a
) empAsDept
WHERE empAsDept.rnk < 4;

/* DENSE_RANK() Window Function */

-- Compare rank, dense_rank & row_number
SELECT
	ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rowNum,
	RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk,
    DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS dense_rnk,
	a.*
FROM employeeCompanyA AS a

/* LEAD() & LAG() Window Function */

-- LAG(columnName, lastRowToShow, defaultValue)

SELECT a.*,
	LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) AS prev_emp_salary,
    LEAD(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) AS next_emp_salary
FROM employeeCompanyA AS a;

-- Q.3 Fetch to display Salary of employe is higher, lower or equal to previous one.
SELECT a.*,
	LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) AS prev_emp_salary,
    CASE WHEN LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) = 0 THEN 'No Previous Record'
		WHEN a.salary > LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) THEN 'Higher than Prev Employee'
		WHEN a.salary < LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) THEN 'Lower than Prev Employee'
        WHEN a.salary = LAG(salary, 1, 0) OVER(PARTITION BY dept_name ORDER BY emp_ID) THEN 'Equal with Prev Employee'
    END AS sal_range
FROM employeeCompanyA AS a;