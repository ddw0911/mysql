select employee_id, concat(first_name, ' ' , last_name) as "Name", salary, hire_date, manager_id 
from employees;
select concat(first_name, '' , last_name) as "Name", job_id as Job, salary as Salary, (salary+100)*12 as Increased_Salary 
from employees;

select distinct department_id, job_id from employees order by department_id desc;

select concat(last_name, ' : 1 Year salary = $',salary*12) as "1 Year Salary"
from employees;

select concat(first_name, '' , last_name) as "Name", salary  
from employees 
where salary not between 7000 and 10000
order by salary;

-- join sql 1999문법 이전과 이후 구분
-- join 종류는 등가 조인 --> oracle natural / inner join
-- outer join(외부 조인 = 포괄 조인) --> left outer join, right outer join
-- self join(자체 조인)

-- 비등가 조인
-- 카티시안 곱 --> cross join

-- 조인조건에서 '='을 사용하는 조인 - equi, natural, inner join 
select emp.employee_id 사원번호, emp.first_name 이름, emp.department_id 부서번호, dept.department_id
부서번호, dept.department_name 부서이름
from employees emp, departments dept
where emp.department_id=dept.department_id;

select emp.first_name 이름, loca.location_id 지역번호, dept.department_id 부서번호, dept.department_name 부서명
from employees emp, locations loca, departments dept
where emp.employee_id=dept.department_id and loca.location_id=dept.location_id and loca.location_id=1700;

-- 셀프조인 (테이블 별칭 필요)
select e1.last_name as 대장, e2.last_name as 부하
from employees e1, employees e2
where e1.employee_id = e2.manager_id;

-- inner join(99년이후)
select e1.employee_id 상사id, e1.last_name as 상사이름, e2.employee_id 부하직원id, e2.last_name as 부하직원이름
from employees e1 inner join employees as e2 on
e1.employee_id = e2.manager_id;

-- left outer join
select dept.department_id 부서번호, dept.department_name 부서명, emp.first_name 사원명
from departments dept, employees emp
where dept.department_id = emp.department_id;