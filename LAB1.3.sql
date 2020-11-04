#1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
use geodata;
SELECT distinct ci.title, co.title, ri.title
FROM _cities ci left join _countries co ON ci.country_id =co.id
			    left join _regions ri ON ci.region_id = ri.id                
order by 1 asc;

#2. Выбрать все города из Московской области.
use geodata;
SELECT distinct ci.title
FROM _cities ci left join _regions ri ON ci.region_id = ri.id  
                where ri.title like 'Московская область'
order by 1 asc;


use employees;
#1. Выбрать среднюю зарплату по отделам.
SELECT dep.dept_name , avg(sa.salary)
FROM departments DEP
left JOIN dept_emp DE ON DEP.dept_no = DE.dept_no
left JOIN salaries SA ON DE.emp_no = SA.emp_no
group by dep.dept_name;
#2. Выбрать максимальную зарплату у сотрудника.
SELECT emp.emp_no,emp.first_name, emp.last_name,MAX(sa.salary)
FROM departments DEP
left JOIN dept_emp DE ON DEP.dept_no = DE.dept_no
left JOIN salaries SA ON DE.emp_no = SA.emp_no
left JOIN employees EMP ON DE.emp_no = EMP.emp_no
where DE.to_date='9999-01-01'
group by emp.emp_no;

#3. Удалить одного сотрудника, у которого максимальная зарплата.
USE employees;
DELETE DE, EMP,SA
FROM dept_emp DE 
left JOIN salaries SA ON DE.emp_no = SA.emp_no
left JOIN employees EMP ON DE.emp_no = EMP.emp_no
where DE.to_date='9999-01-01' and EMP.emp_no =SA.emp_no 
and SA.emp_no=DE.emp_no  and  DE.emp_no  = 
(select * from (SELECT emp.emp_no
FROM dept_emp DE 
left JOIN salaries SA ON DE.emp_no = SA.emp_no
left JOIN employees EMP ON DE.emp_no = EMP.emp_no
where DE.to_date='9999-01-01'
order by sa.salary desc
limit 1 ) as T);
#4. Посчитать количество сотрудников во всех отделах.
SELECT dep.dept_name , count(DE.emp_no)
FROM departments DEP left JOIN dept_emp DE ON DEP.dept_no = DE.dept_no
where DE.to_date='9999-01-01'
group by dep.dept_name;

#5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT dep.dept_name , count(DE.emp_no),SUM(SA.salary)
FROM departments DEP 
left JOIN dept_emp DE ON DEP.dept_no = DE.dept_no
left JOIN salaries SA ON DE.emp_no = SA.emp_no
where DE.to_date='9999-01-01' and SA.to_date='9999-01-01'
group by dep.dept_name;