-- view
create view Vorders
as select o.orderid, o.custid, c.name, o.bookid, o.saleprice, o.orderdate 
from customer c, orders o , book b 
where c.custid=o.custid and b.bookid=o.bookid;
select * from Vorders;

create view soccerbook
as select *
from book
where bookname like '%축구%';
select * from soccerbook;

create view vw_customer
as select *
from customer
where address like '%대한민국%';
select * from vw_customer;

select orderid, bookid, saleprice
from vorders
where name like '김연아';

-- 기존 view 변경 /w or replace
create or replace view vw_customer(custid, name, address)
as select custid, name, address
from customer
where address like '%영국%';
select * from vw_customer;

drop view highorders;
create view highorders
as select b.bookid, b.bookname, c.name, b.publisher, b.price
from orders o
join book b on b.bookid=o.bookid
join customer c on o.custid=c.custid
where price >= 20000;
select bookname, name
from highorders;

create or replace view highorders(bookid, bookname, name, publisher)
as select b.bookid, b.bookname, c.name, b.publisher
from orders o
join book b on b.bookid=o.bookid
join customer c on o.custid=c.custid;
select * from highorders;
select bookname, name
from highorders;

-- index
create index ix_book on book(bookname);
create index ix_book2 on book(publisher,price);
show index from book;
select * from customer where name like '박%'; -- full table scan
select * from book where publisher ='대한미디어' and price >=30000; -- index range scan

analyze table book; -- 인덱스 재구성
drop index ix_book on book;
drop index ix_book2 on book;
