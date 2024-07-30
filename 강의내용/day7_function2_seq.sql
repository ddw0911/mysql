-- Build-in 내장함수 *null처리함수*
-- 상수나 속성이름을 입력받아 단일값으로 반환

-- User defined 사용자 정의함수

select abs(78);
select abs(-78);

select round(4.875, 1);

select custid, round(avg(saleprice),-2) from orders group by custid;

select replace(bookname, '야구', '농구')
from book;

select bookname, char_length(trim(bookname)), length(bookname)
from book
where publisher like '굿스포츠';

select substr(name,1,1) '성', count(*) '명'
from customer
group by substr(name,1,1);

select orderdate 주문일자, adddate(orderdate, interval 10 day) 주문확정일자
from orders;

select orderid 주문번호, date_format(orderdate, '%Y-%m-%d') 주문일, custid 고객번호, bookid 책번호
from orders
where orderdate = str_to_date('20240707', '%Y%m%d');

select sysdate(), date_format(sysdate(), '%Y/%m/%d %a %h:%i');

create table mybook(bookid int unsigned auto_increment primary key, price int);
insert mybook values(null,10000);
insert mybook values(null,20000);
insert mybook values(null,null);
select sum(price), avg(price), count(*), count(price) from mybook;
select * from mybook where price is null;

select name 이름, ifnull(phone, '없음') 번호 from customer;

set @seq:=0;
select(@seq:=@seq+1) '순번', custid, name, phone
from customer
where @seq<2;