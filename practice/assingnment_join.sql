-- 문제
-- 1
select emp.first_name, dept.department_id, dept.department_name
from employees emp, departments dept
where emp.department_id=dept.department_id;
-- 2
select dept.department_id 부서번호, dept.department_name 부서명locations , dept.location_id 부서위치
from departments dept, locations loca
where dept.location_id=loca.location_id and dept.department_id=80;
-- 3
select emp.first_name, dept.department_name, loca.location_id, loca.city
from employees emp, departments dept, locations loca
where emp.department_id=dept.department_id and loca.location_id=dept.location_id and emp.commission_pct>0;

-- 4
select emp.first_name, dept.department_id
from employees emp, departments dept
where emp.department_id=dept.department_id and concat(emp.first_name,' ',emp.last_name) like '%a%';
-- 5
select emp.first_name, emp.job_id, dept.department_id, dept.department_name
from locations loca, employees emp, departments dept
where loca.location_id= dept.location_id and emp.department_id= dept.department_id and loca.city = 'Toronto';

-- 6
select e1.first_name 'Employee', e1.employee_id 'Emp#', e2.first_name 'Manager', e2.employee_id 'Mgr#' 
from employees e1 inner join employees as e2 on e1.manager_id= e2.employee_id;
-- 7
select *
from employees emp
where emp.manager_id = null or emp.job_id='AD_PRES'
order by emp.employee_id;
-- 8
select e1.first_name, e1.department_id, e2.*
from employees e1 inner join employees as e2 on
e1.department_id=e2.department_id and e1.first_name like 'Nancy';
-- 9
CREATE TABLE job_grades(
    grade_level char(1) primary key,
    lowest_sal int,
    highest_sal int
);
insert into job_grades values('A',1000,2999);
insert into job_grades values('B',3000,5999);
insert into job_grades values('C',6000,9999);
insert into job_grades values('D',10000,14999);
insert into job_grades values('E',15000,24999);
insert into job_grades values('F',25000,40000);
COMMIT;
select * from job_grades;
select emp.first_name, emp.job_id, dept.department_name, emp.salary, jg.grade_level 
from employees emp, departments dept, job_grades jg
where emp.department_id=dept.department_id and emp.salary between jg.lowest_sal and jg.highest_sal; 
select concat(first_name, ' ', last_name) 이름, job_title 업무, department_name 부서이름, salary 급여, grade_level 급여등급
from departments, jobs, employees 
left outer join job_grades on salary BETWEEN lowest_sal and highest_sal
where employees.department_id = departments.department_id and jobs.job_id = employees.job_id;