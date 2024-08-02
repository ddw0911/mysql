-- 1
select concat_ws(' ', name, continent, population) 하나로
from country;

-- 2
select ifnull(IndepYear, '데이터없음')
from country;

-- 3
select upper(name), lower(name)
from country;

-- 4
select ltrim(name), rtrim(name), trim(name)
from country;

-- 5
select *
from country
where length(name) > 20
order by length(name) desc;

-- 6 ?
select SurfaceArea
from country;

-- 7
select substr(name,2,4)
from country;

-- 8
select replace(code, 'A', 'Z')
from country;

-- 9 ?
select replace(code, 'A', 'ZZZZZZZZZZ')
from country;

-- 10 ?
select addtime(now(), '24:00:00');

-- 11 ?
select subtime(now(), '24:00:00');

-- 13
select count(*)
from country;

-- 14
select sum(gnp), avg(gnp), max(gnp), min(gnp)
from country;

-- 15
select round(lifeexpectancy, 0)
from country;

-- 16
select row_number() over(order by LifeExpectancy desc, name) 순위, name, LifeExpectancy
from country
group by name;

-- 17
select rank() over(order by LifeExpectancy desc) 순위, name, LifeExpectancy 
from country
group by name;

-- 18
select dense_rank() over(order by LifeExpectancy desc) 순위, name, LifeExpectancy 
from country
group by name; 