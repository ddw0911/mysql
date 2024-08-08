-- 오류처리
-- declare 액션 handler for 오류조건 처리할문장

delimiter $$
create procedure errproc()
begin
	declare continue handler for 1146 select '테이블이 존재하지 않습니다' as '메시지';
    select * from noTable;
end $$
delimiter ;
call errProc();

select * from notable;

delimiter $$
create procedure errproc2()
begin
	declare continue handler for sqlexception
    begin
		show errors;
        select '오류가 발생하여 작업을 취소시켰습니다.' as '메시지';
        rollback;
	end;
    insert usertbl values('LSG','이승기', 1988, '서울', null, null, 170, current_date());
end $$
delimiter ;
call errproc2();

-- cursor - for문
delimiter $$
create procedure custheightavgproc()
begin
	declare userheight int; -- 고객키
    declare cnt int default 0; -- 고객수
    declare totalheight int default 0; -- 고객키 합계
    
    declare endOfRow boolean default false; -- 행의 끝
    
    declare userCursor cursor for select height from usertbl;
    
    declare continue handler for not found set endOfRow = true; -- 행의 끝이면 true 대입
    
    open userCursor;
    
    c_loop: Loop 
			fetch userCursor into userheight;
            if endOfRow then leave c_loop;
            end if;
            set cnt = cnt + 1;
            set totalheight = totalheight + userheight;
			end loop c_loop;
            
	select concat('고객의 평균 키 => ', (totalheight / cnt));
    close usercursor;
end $$
delimiter ;