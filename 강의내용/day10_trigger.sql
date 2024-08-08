create schema testDB;
use testDB;
create table testtbl(id int, txt varchar(10));
insert testtbl values(1,'뉴진스');
insert testtbl values(2,'에스파');
insert testtbl values(3,'아이브');
commit;

delimiter $$
create trigger testtrg
	after delete -- before도 가능
	on testtbl -- testtbl에 testtrg를 붙일예정
    for each row -- 각 행마다 적용시킬예정
begin
	set @msg = '그룹 해체';
end $$
delimiter ;

set @msg = '';
insert testtbl values(4, '아이들');
select @msg;
delete from testtbl where id=3;
select @msg;