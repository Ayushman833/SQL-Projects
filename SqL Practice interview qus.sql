DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(50)
);

INSERT INTO employees (emp_id, name, department, salary, city)
VALUES
(1, 'Rahul', 'IT', 45000, 'Raipur'),
(2, 'Priya', 'HR', 35000, 'Delhi'),
(3, 'Amit', 'IT', 55000, 'Mumbai'),
(4, 'Neha', 'Sales', 30000, 'Raipur'),
(5, 'Karan', 'HR', 40000, 'Delhi'),
(6, 'Sneha', 'Sales', 50000, 'Mumbai'),
(7, 'Rohit', 'IT', 60000, 'Delhi'),
(8, 'Pooja', 'Sales', 35000, 'Raipur'),
(9, 'Anjali', 'IT', 50000, 'Raipur'),
(10, 'Vikas', 'HR', 45000, 'Mumbai');

SELECT * FROM employees;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments (department_id, department_name, location)
VALUES
(101, 'IT', 'Raipur'),
(102, 'HR', 'Delhi'),
(103, 'Sales', 'Mumbai'),
(104, 'Finance', 'Raipur'),
(105, 'Marketing', 'Bhilai');

SELECT * FROM departments;

ALTER TABLE employees
ADD COLUMN department_id INT;

UPDATE employees
SET department_id = CASE
    WHEN department = 'IT' THEN 101
    WHEN department = 'HR' THEN 102
    WHEN department = 'Sales' THEN 103
END;

--Q1 – INNER JOIN
select e.name, d.department_name 
from employees e
Inner join departments d 
on e.department_id=d.department_id;

--Q2 – LEFT JOIN
select e.name, d.department_name 
from employees e
left join departments d 
on e.department_id=d.department_id;

--Q3 – INNER JOIN + WHERE
select e.name, d.department_name
from employees e
Inner join departments d 
on e.department_id=d.department_id
Where d.department_name='IT';

--Q4 – JOIN + ORDER BY
select e.name, d.department_name 
from employees e
join departments d 
on e.department_id=d.department_id
order by d.department_name Asc;

--Q5 – JOIN + WHERE + ORDER BY
select e.name, d.department_name
from employees e
join departments d
on e.department_id=d.department_id
where d.department_name='IT'
order by e.name Asc;

--Q6 – JOIN + GROUP BY
select d.department_name, 
count(e.emp_id) as Total_employees
from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
Having count(e.emp_id)>2;

--Q7 – JOIN + GROUP BY + ORDER BY
select d.department_name, 
Round(Avg(e.salary)) as Avg_salary
from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
order by Avg_salary desc;

--Q8 – JOIN + SUM + GROUP BY + HAVING
select d.department_name,
sum(e.salary) as total_salary
from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
having sum(e.salary)>100000
order by total_salary desc;

--Q9 – JOIN + CASE WHEN
select e.name, 
	   d.department_name, 
	   e.salary,
	   case
	    when e.salary >= 50000 then 'High Salary'
		when e.salary >= 30000 then 'Medium Salary'
		else 'Low Salary'
		end as salary_category
from employees e
join departments d
on e.department_id=d.department_id;

--Q10 – JOIN + WHERE + BETWEEN
select e.name, d.department_name, e.salary 
from employees e 
join departments d 
on e.department_id=d.department_id 
where e.salary between 30000 and 60000 
order by e.salary desc;

--Q11 – LEFT JOIN
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

--Q12 – JOIN + NULL
SELECT e.name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

--Q13 – JOIN + DISTINCT
SELECT DISTINCT d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

--Q14 – JOIN + COUNT + GROUP BY
select d.department_name, count(e.emp_id) as no_of_employees
from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
having count(e.emp_id) >= 3
order by no_of_employees desc;

--Q15 – JOIN + Subquery + AVG()
select e.name, d.department_name, e.salary
from employees e
join departments d
on e.department_id=d.department_id
where e.salary > (
	   select avg(salary)
	   from employees
);

--Q16 - MAX() subquery + JOIN
SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
group by e.name, d.department_name, e.salary
order by e.salary desc limit 1;

            --Or--

SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
where e.salary = (
		select Max(salary)
		from employees
);

--Q16 - Correlated Subquery + JOIN
SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

--Q18 – JOIN + Subquery
select e.name, d.department_name, e.salary
from employees e
join departments d
on e.department_id=d.department_id
where e.salary = (
	select max(salary)
	from employees
	where salary < (
	  select max(salary)
	  from employees
	)
);

--Q19 – JOIN + Subquery
SELECT e.name, d.department_name, MIN(e.salary) AS lowest_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY e.name, d.department_name
ORDER BY lowest_salary ASC
LIMIT 1;

           --OR--

SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
where e.salary = (
	select min(salary)
	from employees
);

--Q20 - JOIN + Subquery + MAX() + WHERE
SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT MAX(e2.salary)
    FROM employees e2
    JOIN departments d2
        ON e2.department_id = d2.department_id
    WHERE d2.department_name = 'HR'
);





