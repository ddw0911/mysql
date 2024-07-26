INSERT INTO producttbl values('망고',10000,'2014.02.01','del',3);
INSERT INTO producttbl values('멜론',20000,'2015.07.01','garak',4);
INSERT INTO producttbl values('오렌지',5000,'2016.10.01','juicy',5);
commit;
select* from producttbl;

select * from membertbl where membername='ksg';