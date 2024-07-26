-- sql practice2
-- 0
select 'Han-bit' as company, concat(emp.first_name, ' ' , emp.last_name) Name, job_id, dept.department_name, loca.city
from employees emp, departments dept, locations loca
where emp.department_id=dept.department_id and dept.location_id=loca.location_id and loca.city='oxford';

-- 1
select dept.department_name 부서명, count(emp.employee_id) 사원수
from employees emp, departments dept
where emp.department_id=dept.department_id
group by emp.department_id
having count(emp.employee_id) >=5
order by count(emp.employee_id) desc;

-- 2
select concat(emp.first_name, ' ' , emp.last_name) Name, emp.job_id, dept.department_name, emp.hire_date, emp.salary, jg.grade_level
from employees emp
join departments dept on emp.department_id=dept.department_id
left join job_grades jg on emp.salary between jg.lowest_sal and jg.highest_sal;

-- 3
select concat(emp.first_name, ' ' , emp.last_name) Name,
case
when emp.manager_id is not null then concat(emp.first_name, ' ', emp.last_name, ' report to ', upper(concat(mgr.first_name, ' ' , mgr.last_name)))
else '상사없음'
end as 보고체계
from employees emp left outer join employees mgr
on emp.manager_id=mgr.employee_id;