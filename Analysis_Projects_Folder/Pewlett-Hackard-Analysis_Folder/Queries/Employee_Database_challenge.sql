	
--ASSIGNMENT DELIVERABLE 1--

--Creating retirement titles table
SELECT emp.emp_no, emp.first_name, emp.last_name, ttl.title, ttl.from_date, ttl.to_date 
INTO retirement_titles
FROM titles as ttl
INNER JOIN employees as emp
ON emp.emp_no = ttl.emp_no

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;

-- Check Table
SELECT *
FROM retirement_titles



-- Creating Unique Titles table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, emp_no DESC;

-- Check Table
select * 
from unique_titles


-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT count(emp_no), title
INTO retiring_titles
FROM unique_titles

GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Check Table
select * 
from retiring_titles




--ASSIGNMENT DELIVERABLE 2 --

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 	
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no

--Check table
SELECT *
FROM mentorship_eligibility



-- Retrieve the number of employees by their most recent job title who are eligible for mentorship
SELECT count(emp_no), title
INTO mentorship_titles
FROM mentorship_eligibility

GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Check Table
select * 
from mentorship_titles



--Create query for comparison
SELECT rt.count/mt.count,
	rt.title
INTO retiring_per_mentored
FROM retiring_titles as rt
LEFT JOIN mentorship_titles as mt
ON rt.title = mt.title

drop table test

select sum(count)
from retiring_titles


