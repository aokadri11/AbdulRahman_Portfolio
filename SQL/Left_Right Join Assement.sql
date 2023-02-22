--1. Perform a left join on regions and countries tables. Select region_id and region_name from regions table, then select country_name from the countries table.
--How many records were returned

--select * from regions
--Left Join countries on regions.region_id = countries.region_id

select regions.region_id, region_name, country_name
from regions
Left Join countries on regions.region_id = countries.region_id

--Alternative methods
--select a.region_id, a.region_name, b.country_name
--from regions a
--Left Join countries b on a.region_id = b.region_id
--    3 columns 25 rows were returned

--2. Using left join, write a query that returns all columns from countries table, and city, postal_code and state_province from the locations table.
--How many records were returned in total?

--Alternative way to select all when dealing with multiple tables 

Select Countries.*, locations.city, locations.postal_code, locations.state_province
from Countries
Left join locations on countries.country_id = locations.country_id

--- Default Method
Select Countries.country_id, country_name, region_id, locations.city, locations.postal_code, locations.state_province
from Countries
Left join locations on countries.country_id = locations.country_id

--  6 columns 28 rows were returned

--3. Suppose we aim to identify departments located in different countries,
--you need to perform a left join that returns country_name from the countries table, and location_id, street_address, city and state_province from the locations table,
--then add department_id, and department_name from departments table to the result using a right join.

Select country_name, locations.location_id, locations.street_address, locations.city, locations.state_province, departments.department_id, departments.department_name
from countries
Left join locations on countries.country_id = locations.country_id
Right Join departments on locations.location_id = departments.location_id

--4. Write a query that returns employee_id, first_name,last_name, email, phone_number, hire_date, job, department_id, and department_name 
--for employees hired after 1997-06-25. Hint: Use inner join.

select employee_id, first_name,last_name, email, phone_number, hire_date, job_title, departments.department_id, department_name
from employees
Left join departments on employees.department_id = departments.department_id
Inner join jobs on employees.job_id = jobs.job_id
where hire_date > '1997-06-25'

--5. Write a query using right join, to select first_name, last_name, salary from employees table, 
--and all fields from the jobs table for employees with maximum salary of less than 12000. Hint: the employees table should come first.

select employees.first_name, employees.last_name, employees.salary, jobs.job_title, jobs.max_salary, jobs.min_salary 
from employees
Right join jobs on employees .job_id = jobs.job_id and employees.salary <= 12000

--Inner join jobs on employees.salary <= 12000

---6. Perform an inner join to select all columns except job_id, email, and phone_number from employees table, and select all columns from the dependents tables.
--How many records were returned?

--select employees.employee_id, employees.first_name, employees.last_name, employees.hire_date, employees.salary,employees.manager_id, employees.department_id, 
--dependents.dependent_id, dependents.first_name, dependents.last_name, dependents.relationship,dependents.employee_id
--from employees
--inner join dependents on employees.employee_id = dependents.employee_id

select employees.first_name, employees.last_name, employees.hire_date, employees.salary,employees.manager_id, employees.department_id, 
dependents.dependent_id, dependents.first_name, dependents.last_name, dependents.relationship,dependents.employee_id
from employees
inner join dependents on employees.employee_id = dependents.employee_id
----    30 records were returned

--7. Using full join, select all columns from the jobs table, and all columns from the employees table, except job_id in the latter.

select jobs.job_id, job_title,min_salary, max_salary, employee_id, first_name, last_name, email, phone_number, hire_date, salary, manager_id, department_id from jobs 
full join employees on jobs.job_id = employees.job_id

--8. Use left join to return a query that selects all columns from the regions table 
--and all columns from the countries table except region_id from the latter and excluding Asian region.

Select regions.region_id, region_name, country_id, country_name from regions
Left join countries on regions.region_id = countries.region_id 
where not countries.region_id = 3
--where not region_name = 'Asia'

--9. Using left join, select all columns from the departments table, first_name, last_name, manager_id from the employees table,
--and then using join, include all columns from the jobs table where the minimum salary is above 8000 and the job title excludes president.

select departments.department_id, department_name, location_id, employees.first_name, employees.last_name, employees.manager_id, job_title from departments
Left join employees on departments.department_id = employees.department_id
Full join jobs on employees.job_id = jobs.job_id and jobs.max_salary > 8000
where not jobs.job_title = 'president'

--10. Create a stored procedure that select all columns from the jobs table, and first_name, last_name and 
--employee_id from employees table then order the result by first_name in ascending order. Hint: Use inner join.

Create Procedure Jobs_EmployeeData
As 
Select jobs.*, employees.first_name, employees.last_name, employees.employee_id from jobs
Inner join employees on jobs.job_id = employees.job_id

Exec Jobs_EmployeeData