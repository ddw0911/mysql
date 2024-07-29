create table movietbl(
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_film longblob
)default charset= utf8mb4;

select * from movietbl;

insert movietbl values(1, '쉰들러리스트', '스티븐 스필버그', '리암 니슨', 
load_file('C:/study/mysql/ssg/script/movies/SchindlerList.txt'), load_file('C:/study/mysql/ssg/script/movies/SchindlerList.mp4'));

-- load_file 값이 null인 이유
-- 1. 최대 패킷 크기(= 최대 파일 크기) - 시스템 변수 확인 : max_allowed_packet 값 조회
show variables like 'max_allowed_packet'; -- 'max_allowed_packet', '4194304'
-- 2. 파일을 업/다운로드 할 폴더 경로를 별도 허용해야 (my-sql server) 'secure_file_priv' 조회
show variables like 'secure_file_priv'; -- 'secure_file_priv', 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\'
truncate movietbl;

insert movietbl values(2, '쇼생크탈출', '프랭크 다라본트', '팀 로빈스', 
load_file('C:/study/mysql/ssg/script/movies/ShawShank.txt'), load_file('C:/study/mysql/ssg/script/movies/ShawShank.mp4'));

insert movietbl values(3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스', 
load_file('C:/study/mysql/ssg/scri
pt/movies/LastMohican.txt'), load_file('C:/study/mysql/ssg/script/movies/LastMohican.mp4'));
commit;

-- 다운로드
select movie_script from movietbl where movie_id=1
	into outfile 'C:/study/mysql/ssg/script/movies/SchindlerList_out.txt'
    lines terminated by '\\n'; -- 줄바꿈 문자도 그대로 다운받아 저장
    
select movie_film from movietbl where movie_id=3
	into dumpfile 'C:/study/mysql/ssg/script/movies/LastMohikan_out.mp4';
    
-- pivot : 한열에 포함된 여러값을 출력하고, 여러 열로 변환하여 테이블 반환식을 회전하고 필요하면 집계까지 수행하는 과정
use modeldb;

create table pivotTest(
	uName char(5),
    season char(2),
    amount int
    );
    
insert pivotTest values('김진수', '겨울', 10),('김진수', '가을', 25),('김진수', '봄', 3),('김진수', '봄', 37),('김진수', '가을', 103),
		('윤진수', '겨울', 40),('윤진수', '겨울', 66),('윤진수', '여름', 15),('윤진수', '봄', 2222),('윤진수', '가을', 1111);
commit;

truncate pivotTest;
select * from pivotTest;

-- 판매자별 계절, 판매수량 /w sum(), if() 활용하기
select uName, sum(if(season='봄', amount,0)) as '봄',
			sum(if(season='여름', amount,0)) as '여름',
            sum(if(season='가을', amount,0)) as '가을',
            sum(if(season='겨울', amount,0)) as '겨울',
            sum(amount) as '합계'
            from pivotTest
            group by uName;
            
-- 계절별 판매자의 판매수량 집계, 출력하는 피벗테이블
select season, sum(if(uName='김진수', amount,0)) as '김진수 판매량',
			sum(if(uName='윤진수', amount,0)) as '윤진수 판매량',
            sum(amount) as '합계'
            from pivotTest
            group by season;
            
-- json 데이터 - key와 value 쌍
-- 웹과 모바일 응용 프로그램에서 데이터를 교환하기 위해 개발형 표준 포맷인 JSON 활용
-- 독립적인 데이터 포맷 - 단순하고 공개되어 있어 여러 프로그래밍 언어에서 채택
/* ex)
	{
		"userName" : "김삼순",
		"birthYear" : 2002,
		"address" : "서울 성동구 북가좌동",
		"mobile" : "01012348989"
	} -> 김삼순 회원의 정보
*/
use bookstore;
select * from usertbl;

select json_object('name', name, 'height', height) as '키180 이상 회원의 정보'
from usertbl
where height >= 180;

-- json 관련 내장함수
set @json = '{
		"usertbl1" : [
				{"name": "임재범", "height": 182},
                {"name": "이승기", "height": 182},
                {"name": "성시경", "height": 186}
        ]
	}';
    
select json_valid(@json) as json_valid; -- 문자열이 json 형식을 만족하면 1, 아니면 0 반환
select json_search(@json, 'one', '성시경') as json_search; -- 성시경 키워드가 담긴 json 문자열 한개의 경로 반환
select json_search(@json, 'one', '이승기') as json_search;
select json_search(@json, 'all', '성시경') as json_search; -- 성시경 키워드가 담긴 모든 json 문자열의 경로 반환

select json_insert(@json, '$.usertbl1[0].mDate', '2024-07-29') as json_insert; -- json 추가
select json_replace(@json, '$.usertbl1[0].name', '임영웅') as json_replace; -- json 변경
select json_remove(@json, '$.usertbl1[1].name') as json_remove; -- json 삭제