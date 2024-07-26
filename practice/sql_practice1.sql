-- select
-- 0
select employees.department_id, employee_id, concat(first_name,' ',last_name) Name, salary, round(salary*1.123) 'Increased Salary'
from employees
where employees.department_id=60;

-- 1
select concat(first_name,' ',last_name) Name, job_id Job, salary Salary, (salary+100)*12 'Increased Ann_Salary', salary+100 'Increased Salary'
from employees;

-- 2
select concat(last_name,': 1 Year Salary = $',salary*12) "1 Year Salary"
from employees;

-- 3
select distinct job_id
from employees;

-- page2 where, order by
-- 0
select concat(first_name,' ',last_name) Name, salary
from employees
where salary between 7000 and 10000
order by salary;

-- 1
select concat(first_name,' ',last_name) 'e and o Name'
from employees
where last_name like '%e%' or '%o%';

-- 2 출력값이 있도록 문제 입사년도 임의변경
select concat(first_name,' ',last_name) Name, employee_id, hire_date
from employees
where hire_date between str_to_date('1997-05-20', '%Y-%m-%d') and str_to_date('1998-05-20', '%Y-%m-%d')
order by hire_date;

-- 3
select concat(first_name,' ',last_name) Name, salary, job_id, commission_pct
from employees
where commission_pct>0
order by salary desc, commission_pct desc;

-- page3 단일행, 변환함수
-- 0
select employee_id, concat(first_name,' ',last_name) Name, salary, round(salary*1.123) 'Increased Salary'
from employees;

-- 1
select concat(first_name, ' ', last_name, ' is a ', upper(job_id)) 'Employee JOBs'
from employees
where last_name like ('%s');

-- 2
select concat(first_name,' ',last_name) Name, salary, 
CASE 
	WHEN commission_pct IS NOT NULL THEN 'Salary + Commission'
	ELSE 'Salary only'
END AS "Salary Type",
salary * (1 + ifnull(commission_pct,0))*12 Annual_Salary
from employees
order by Annual_Salary desc;

-- 3
select concat(first_name,' ',last_name) Name, hire_date, dayname(hire_date) 입사요일
from employees
order by dayofweek(hire_date);

-- page4 집계함수
-- 0
select count(distinct manager_id) '상사로 근무중인 사원수'
from employees;
-- 0 - inner join 사용
select count(distinct e2.employee_id) '상사로 근무중인 사원 수'
from employees e1 inner join employees as e2 on
e1.manager_id = e2.employee_id;

-- 1
select department_id 부서id, concat('$',format(sum(salary),2)) '급여 합계', concat('$',format(avg(salary),2)) '급여 평균', concat('$',format(max(salary),2)) '급여 최대값', concat('$',format(min(salary),2)) '급여 최소값' 
-- concat('$',format(sum(salary), '#,#')) 소숫점 없는 3자리마다 , 표현
from employees
group by department_id
order by department_id;

-- 2
select job_id 업무, avg(salary) 급여평균
from employees
where job_id not like '%CLERK%'
group by job_id
having avg(salary) >10000
order by avg(salary) desc;