SELECT * FROM employees;

SELECT COUNT(emp_no) FROM employees;
--300024 rows; check figure

--List the following details of each employee: employee number, last name, first name, sex, and salary
CREATE VIEW da1 AS(
	SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
	FROM employees
	LEFT JOIN salaries
	ON employees.emp_no = salaries.emp_no
);

SELECT * FROM da1;

SELECT COUNT(emp_no) FROM da1;
--300024 rows

--List first name, last name, and hire date for employees who were hired in 1986
CREATE VIEW da2 AS(
	SELECT employees.first_name AS "First Name", employees.last_name AS "Last Name", employees.hire_date AS "Hire Date"
	FROM employees
	WHERE employees.hire_date BETWEEN '1986-01-01' AND '1986-12-31'
);

SELECT * FROM da2;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT * FROM departments;
SELECT * FROM dept_manager;
--24 department managers


CREATE VIEW da3 AS (
WITH department AS (
	SELECT d.dept_no, d.dept_name, dm.emp_no
	FROM departments AS d
	INNER JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no)
	SELECT department.*, e.last_name, e.first_name
	FROM department
	INNER JOIN employees AS e
	ON department.emp_no = e.emp_no)
;

SELECT * FROM da3;
--24 rows


--List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW da4_supplemental AS(
WITH department AS (
	SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", de.dept_no
	FROM employees AS e
	LEFT JOIN dept_emp as de
	ON e.emp_no = de.emp_no)
	SELECT department.*, d.dept_name AS "Department Name"
	FROM department
	LEFT JOIN departments AS d
	ON department.dept_no = d.dept_no
);

SELECT * FROM da4_supplemental;

CREATE VIEW da4 AS(
	SELECT "Employee Number", "Last Name", "First Name", "Department Name"
	FROM da4_supplemental)
;

SELECT * FROM da4;


--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
CREATE VIEW da5 AS(
	SELECT e.first_name AS "First Name", e.last_name AS "Last Name", e.sex AS "Sex"
	FROM employees AS e
	WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%')
;

SELECT * FROM da5;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * FROM da4;

CREATE VIEW da6 AS(
	SELECT *
	FROM da4
	WHERE "Department Name" = 'Sales'
);

SELECT * FROM da6;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM da4;

CREATE VIEW da7 AS(
	SELECT *
	FROM da4
	WHERE "Department Name" = 'Sales' OR "Department Name" = 'Development')
;

SELECT * from da7;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT * FROM employees;

CREATE VIEW da8 AS(
	SELECT last_name AS "Last Name", COUNT(last_name) AS "Frequency"
	FROM employees
	GROUP BY last_name 
	ORDER BY COUNT(last_name) DESC
);

SELECT * FROM da8;

SELECT SUM("Frequency") FROM da8;
--300024 checks to total employees

--create views so I can complete the bonus question
CREATE VIEW bonus AS(
	SELECT e.emp_no, e.emp_title_id, e.birth_date, e.first_name, e.last_name, e.sex, e.hire_date, s.salary
	FROM employees AS e
	INNER JOIN salaries AS s
	ON e.emp_no = s.emp_no
);

SELECT * FROM bonus;

CREATE VIEW bonus_2 AS(
	SELECT b.emp_no, b.emp_title_id, b.birth_date, b.first_name, b.last_name, b.sex, b.hire_date, b.salary, t.title
	FROM bonus AS b
	INNER JOIN titles AS t
	ON b.emp_title_id = t.title_id
);

SELECT * FROM bonus_2;