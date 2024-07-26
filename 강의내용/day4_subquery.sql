-- subquery(부속질의)
-- 실행순서 : where절의 부속질의를 먼저 처리 -> 전체질의 수행
-- 실행결과는 테이블로 반환 - 1*1, 1*n, n*1, n*n

select bookname, price
from book
where price = (select max(book.price) from book);

select customer.name
from customer
where customer.custid in (select orders.custid from orders);

-- 하위 subquery
select customer.name
from customer
where customer.custid in (
select orders.custid from orders where orders.bookid in (
select book.bookid from book where book.publisher in ('대한미디어')));

-- 튜플 변수 b1, b2
select bookname
from book b1
where b1.price > (
select avg(b2.price)
from book b2
where b1.publisher = b2.publisher
);

select userID, name
from usertbl
where birthYear >= 1970 or height >= 182;

select *
from usertbl
where height between 180 and 183;

select name
from usertbl
where addr in ('경남', '전남', '경북');

select *
from usertbl
where name like '김%';

-- ANY / ALL / SOME (subquery의 결과가 여러개일때 처리)
-- 김경호보다 키가 같거나 큰사람 조회
select * from usertbl where height > 177;
select * from usertbl where height > (select height from usertbl where name = '김경호');

-- ANY(SOME) : or (sq 결과중 하나만 만족해도)
select name, height
from usertbl
where height >= any (select height from usertbl where addr='경남')
order by height;

-- ALL : and (sq 결과 모두 만족해야)
select name, height
from usertbl
where height >= all (select height from usertbl where addr='경남')
order by height;

select name, height
from usertbl
where height = all (select height from usertbl where addr='경남')
order by height; -- =in 연산과 같음

Create table usertbl2(select * from usertbl); -- tbl 복제 (제약조건(pk,fk 등) 제외)
alter table usertbl2 add constraint pk_usertbl2 primary key (userid);

-- 2-13 도서 판매액 평균보다 자신의 구매액 평균이 더 높은 고객 이름
select customer.name
from customer
where customer.custid = any (
select o1.custid from orders o1 where o1.custid = any (
select o2.custid from orders o2 group by o2.custid having avg(o2.saleprice) > (
select avg(o3.saleprice) from orders o3)));

select customer.name
from customer
where (select avg(o1.saleprice) from orders o1 where customer.custid = o1.custid) > 
(select avg(o2.saleprice) from orders o2);

-- Group by
-- 사용자 별 구매한 물품의 개수 조회
select userID, sum(amount)
from buytbl
group by userID;

-- 구매액의 총합
select userID, sum(price*amount)
from buytbl
group by userID;

select count(*)
from usertbl;

select count(mobile1)
from usertbl;

select usertbl.*
from buytbl, usertbl
where buytbl.userID=usertbl.userID
group by buytbl.userID
having sum(price)>1000;

-- 총합 중간합계가 필요한 경우 group by, with rollup 사용
select groupName, sum(price*amount)
from buytbl
group by groupName
with rollup;