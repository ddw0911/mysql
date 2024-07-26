-- 단일행 변환함수
-- 0 이번 분기에 60번 IT  부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 이에 
-- 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만
-- (반올림) 표시하는 보고서를 작성하시오. 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급
-- 여(Increased Salary로 별칭)순으로 출력한다
select employee_id, concat(first_name, ' ', last_name) Name, salary, salary*1.123 'Increased Salary'
from employees
where employees.department_id=60;

-- 1 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한
-- 다. 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 
-- 표시하시오(18행).
-- □예 James Landry is a ST_CLERK
select concat(first_name, ' ', last_name, ' is a ', UPPER(job_id))'Employee JOBs'
from employees;

-- (hint) INITCAP, UPPER, SUBSTR 함수를 사용하며 SUBSTR 함수의 경우 뒤에서부터 첫글자는 두 번째 
-- 인자에 –1을 사용한다

-- 2 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 
-- 별칭),  급여,  수당여부에  따른  연봉을  포함하여  출력하시오.  수당여부는  수당이  있으면  “Salary  + 
-- Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 
-- 높은 순으로 정렬한다(107행

select concat(first_name, ' ', last_name) Name,  salary,
case 
when commission_pct is not null then 'Salary + Commission'
else 'Salary only'
end as SalarywithCommission,
salary * (1 + ifnull(commission_pct,0)) *12 'Annual Salary'
from employees
order by 'Annual Salary' desc;

-- 3 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 
-- 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행
select concat(first_name, ' ', last_name) Name, hire_date, dayname(hire_date)
from employees
order by dayofweek(hire_date);