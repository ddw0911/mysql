-- 1
select concat(first_name, ' ' , last_name) Name, job_id, salary
from employees
where salary > (select salary from employees where last_name like 'Tucker');

-- 2
select concat(first_name, ' ' , last_name) Name, job_id, salary, hire_date
from employees
where (job_id, salary) = any (select job_id, min(salary) from employees group by job_id);

-- 3
select concat(first_name, ' ' , last_name) Name,  salary,  hire_date, department_id, job_id
from employees
having salary > any (select avg(salary) from employees group by department_id); 

-- 4
select e.employee_id, concat(e.first_name, ' ' , e.last_name) Name, e.job_id, e.hire_date
from employees e, departments d
where e.department_id= d.department_id 
and d.location_id = (select location_id from locations where city like 'O%');

-- 5 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부
-- 서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오
select concat(e.first_name, ' ' , e.last_name) Name, e.job_id, e.salary, e.department_id, dep_avg.avg_sal 'Department Avg Salary'
from employees e 
join (select e2.department_id, avg(salary) avg_sal from employees e2 group by department_id) dep_avg 
on e.department_id=dep_avg.department_id
;

GRANT EXECUTE ON FUNCTION hr.dept_avg TO 'hr'@'localhost';
FLUSH PRIVILEGES;

select department_id, avg(salary) from employees group by department_id;

-- 6
select e.employee_id, concat(e.first_name, ' ' , e.last_name) Name, j.job_title, e.salary
from employees e, jobs j
where e.job_id = j.job_id and e.salary > any (select salary from employees where last_name like 'Kochhar');

-- 7
select e.employee_id, concat(e.first_name, ' ' , e.last_name), j.job_title, e.salary, e.department_id
from employees e, jobs j
where e.job_id=j.job_id and e.salary < (select avg(salary) from employees);

-- 8
select d.department_id, d.department_name
from departments d, employees e
where d.department_id=e.department_id
group by d.department_id
having min(e.salary) > (select min(salary) from employees where department_id = 100);

-- 9
select e.employee_id, concat(e.first_name, ' ' , e.last_name) Name, e.job_id, e.department_id
from employees e
group by job_id
having min(salary)
order by job_id;

-- 10 -- 8번과 동일

-- 11 
select concat(e.first_name, ' ' , last_name) Name, e.job_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id=d.department_id and d.location_id=l.location_id and job_id like 'SA_MAN';

-- 12 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오
select employee_id, concat(first_name, ' ', last_name) Name
from employees
where employee_id=
(select manager_id from employees group by manager_id order by count(manager_id) desc limit 1);

select employees.manager_id,  count(mgrCount.employee_id)
from employees, 
(select e.manager_id 상사id, count(e.employee_id) 부하직원수 from employees m join employees e on m.employee_id=e.manager_id group by e.manager_id) as mgrCount
group by mgrCount.manager_id
;


-- 13
select employee_id, concat(first_name, ' ' , last_name) Name, job_id, salary
from employees
where job_id = (select job_id from employees where employee_id = 123) 
and salary > (select salary from employees where employee_id = 192);

-- 14
select employee_id, concat(first_name, ' ' , last_name) Name, job_id, hire_date, salary, department_id
from employees
where department_id <> 50 and salary > (select min(salary) from employees where department_id = 50);

select min(salary) from employees group by department_id = 50;

-- 15
select employee_id, concat(first_name, ' ' , last_name) Name, job_id, hire_date, salary, department_id
from employees
where department_id <> 50 and salary > any (select max(salary) from employees group by department_id = 50);
