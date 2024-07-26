-- id: hr, pw: hr인 계정 만들기
create user hr@localhost identified by 'hr';

-- hr 계정에 권한 부여
grant all privileges on hr.* to hr@localhost with grant option;

-- 다른 아이피에 권한 부여
grant all privileges on hr.* to hr@'%' with grant option;

flush privileges;