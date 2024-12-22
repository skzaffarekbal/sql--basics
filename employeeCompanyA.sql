/* **************
   SQL Window Function - Part #1
   Video URL - https://youtu.be/Ww71knvhQ-s?si=qngs_x4jDu3FeyhO
 ************** */
drop table employeeCompanyA;
create table employeeCompanyA
( emp_ID int
, emp_NAME varchar(50)
, dept_name varchar(50)
, salary int);

insert into employeeCompanyA values(101, 'Mohan', 'Admin', 4000);
insert into employeeCompanyA values(102, 'Rajkumar', 'HR', 3000);
insert into employeeCompanyA values(103, 'Akbar', 'IT', 4000);
insert into employeeCompanyA values(104, 'Dorvin', 'Finance', 6500);
insert into employeeCompanyA values(105, 'Rohit', 'HR', 3000);
insert into employeeCompanyA values(106, 'Rajesh',  'Finance', 5000);
insert into employeeCompanyA values(107, 'Preet', 'HR', 7000);
insert into employeeCompanyA values(108, 'Maryam', 'Admin', 4000);
insert into employeeCompanyA values(109, 'Sanjay', 'IT', 6500);
insert into employeeCompanyA values(110, 'Vasudha', 'IT', 7000);
insert into employeeCompanyA values(111, 'Melinda', 'IT', 8000);
insert into employeeCompanyA values(112, 'Komal', 'IT', 10000);
insert into employeeCompanyA values(113, 'Gautham', 'Admin', 2000);
insert into employeeCompanyA values(114, 'Manisha', 'HR', 3000);
insert into employeeCompanyA values(115, 'Chandni', 'IT', 4500);
insert into employeeCompanyA values(116, 'Satya', 'Finance', 6500);
insert into employeeCompanyA values(117, 'Adarsh', 'HR', 3500);
insert into employeeCompanyA values(118, 'Tejaswi', 'Finance', 5500);
insert into employeeCompanyA values(119, 'Cory', 'HR', 8000);
insert into employeeCompanyA values(120, 'Monica', 'Admin', 5000);
insert into employeeCompanyA values(121, 'Rosalin', 'IT', 6000);
insert into employeeCompanyA values(122, 'Ibrahim', 'IT', 8000);
insert into employeeCompanyA values(123, 'Vikram', 'IT', 8000);
insert into employeeCompanyA values(124, 'Dheeraj', 'IT', 11000);
COMMIT;


/* **************
   Video Summary
 ************** */

select * from employeeCompanyA;

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no of records.
select dept_name, max(salary) from employeeCompanyA
group by dept_name;

-- By using MAX as an window function, SQL will not reduce records but the result will be shown corresponding to each record.
select e.*,
max(salary) over(partition by dept_name) as max_salary
from employeeCompanyA e;


-- row_number(), rank() and dense_rank()
select e.*,
row_number() over(partition by dept_name) as rn
from employeeCompanyA e;


-- Fetch the first 2 employees from each department to join the company.
select * from (
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as rn
	from employeeCompanyA e) x
where x.rn < 3;


-- Fetch the top 3 employees in each department earning the max salary.
select * from (
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employeeCompanyA e) x
where x.rnk < 4;


-- Checking the different between rank, dense_rnk and row_number window functions:
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as dense_rnk,
row_number() over(partition by dept_name order by salary desc) as rn
from employeeCompanyA e;



-- lead and lag

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' end as sal_range
from employeeCompanyA e;

-- Similarly using lead function to see how it is different from lag.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employeeCompanyA e;
