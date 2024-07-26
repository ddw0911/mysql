select phone from customer where name='김연아';

select * from customer;

select bookname, price from book;
select distinct publisher from book;
select * from book where price <20000;
select * from book where price >= 10000 and price <=20000 ;
select * from book where price between 10000 and 20000 ;

select * from book where publisher in ('굿스포츠', '대한미디어');
select publisher from book where bookname like '축구의 역사';
select publisher from book where bookname like '%축구%'; -- 축구가 포함된 bookname 검색
select publisher from book where bookname like '%축구';
select publisher from book where bookname like '축구%';

select * from book where bookname like '_구%';

select * from book order by bookname;

select * from book order by price , bookname; -- 가격 오름차순, 가격이 같으면 이름 오름차순

select * from book order by price desc, publisher;

-- 15
select sum(saleprice) as 총매출 from orders;

-- 16
select sum(saleprice) as '김연아 고객의 구매총액' from orders where custid=2;

-- 17
select sum(saleprice) 총판매액, avg(saleprice) 평균값, min(saleprice) 최저가, max(saleprice) 최고가 from orders;

-- 18 COUNT
select count(*) from customer; -- *연산 : null 포함 튜플개수 count
select distinct count(phone) from customer; -- 속성지정 연산 : null 제외 튜플개수 count
select count(ifnull(phone,0)) from customer; -- null이 있다면 0으로 치환하여 연산

-- 19 GROUP BY
 select custid, count(*) as '주문수량', sum(saleprice) as '총 판매액' from orders group by custid;
 
 -- 20 HAVING
 select custid, count(*) 주문수량 from orders where saleprice >= 8000 group by custid having count(*) >=2;
 
 -- select 실행순서 1.from 2.where 3.group by 4.having 5.select 6.order by
 -- sql문은 실행순서가 없는 비절차적 언어이지만 내부적 실행순서는 존재
 
 select bookname from book where bookid=1;
 select bookname from book where price >= 20000;
 select sum(saleprice) 총구매액 from orders where custid=1;
 select count(orderid) 구매도서의수 from orders where custid=1;
 
 select count(bookid) '도서 총 개수' from book;
 select count(distinct publisher) '출판사 총 개수' from book;
 select name, address from customer;
 select orderid from orders where orderdate between '2024-07-04' and '2024-07-07';
 select orderid from orders where orderdate not between '2024-07-04' and '2024-07-07';
 select name, address from customer where name like "김%";
 select name, address from customer where name like "김%아";
 
 -- JOIN : 한 테이블의 행과 다른 테이블의 행에 연결하여 두개 이상의 테이블을 결합하는 연산 - 두 개 이상 테이블을 테이블 한 개로 만들기
 -- 고객과 고객주문에 대한 데이터 모두 출력
 select * from customer, orders
 where customer.custid = orders.custid order by orders.orderid; -- 두 테이블을 연결하는 조건 추가
 
 -- 23 equi join(동등조인) - 동등조건(공통속성)에 의한 테이블 조인
 select name, saleprice from customer, orders where customer.custid=orders.custid;
 -- 24
 select name, sum(saleprice) from customer, orders where customer.custid=orders.custid group by customer.custid order by customer.name;
 
 -- 25
 select customer.name, book.bookname 
 from customer,book,orders 
 where customer.custid=orders.custid and book.bookid=orders.bookid;
 -- 26
 select customer.name, book.bookname, book.price 
 from customer,book,orders 
 where customer.custid=orders.custid and book.bookid=orders.bookid and book.price=20000;
 
 -- outer join(외부조인)
select customer.name, orders.saleprice
from customer left outer join orders on customer.custid = orders.custid; -- left(customer)에 있는 모든 custid(orders에는 없는 custid 포함)하여 select(left기준)

-- 5
select count(distinct book.publisher) as '구매한 도서의 출판사 수 '
from book, customer, orders 
where book.bookid=orders.bookid and customer.custid=orders.custid and orders.custid = 1;
-- 6
select book.bookname, book.price as '책 정가', book.price-orders.saleprice as '정가-판매가격'
from book, orders, customer
where book.bookid=orders.bookid and customer.custid=orders.custid and orders.custid = 1;
-- 7
select distinct book.bookname as '구매하지 않은 책'
from book 
left join orders on book.bookid = orders.bookid
left join customer on customer.custid=orders.custid
where orders.custid <> 1; 