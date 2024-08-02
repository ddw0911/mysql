-- 순위함수 : 조회결과에 순위부여
-- row_number, rank, dense_rank, ntile

-- 1) row_number : 유일한 값으로 순위 부여 (일반적 사용)
select * from payment;

select row_number() over(order by amount desc) num, customer_id, amount
from (
	select customer_id, sum(amount) amount from payment group by customer_id
) x;

select row_number() over(order by amount desc, customer_id desc) num, customer_id, amount
from (
	select customer_id, sum(amount) amount from payment group by customer_id
) x;

-- rank : 우선순위 고려x (공동순위는 같은순서(숫자) 부여 - 다음순위는 공동순위 데이터 수만큼 숫자를 건너뛴다)
select rank() over(order by amount desc) num, customer_id, amount
from(
	select customer_id, sum(amount) amount from payment group by customer_id
) x;

-- 파티션별 ex)학년별 석차, 직급별 연봉
select staff_id,
row_number() over(partition by staff_id order by amount desc, customer_id) num, customer_id, amount
from (
	select customer_id, staff_id, sum(amount) amount from payment group by customer_id, staff_id
) x;

-- dense-rank : 공동순위는 같은 순위처리 + 다음순위는 다음숫자
select dense_rank() over(order by amount desc) num, customer_id, amount
from(
	select customer_id, sum(amount) amount from payment group by customer_id
) x;

-- ntile : 그룹순위 - 인자로 지정한 개수만큼 데이터 행을 그룹화 -> 그룹에 순위부여 ex)그룹에 대한 혜택을 차등지급할 때
select ntile(100) over(order by amount desc) num, customer_id, amount
from(
	select customer_id, sum(amount) amount from payment group by customer_id
) x;

-- 분석함수 : 데이터그룹을 기반으로 앞뒤행을 계산하거나 그룹에대한 누적분포, 상대 순위 계산시 사용
-- 집계함수와 달리 분석함수는 그룹마다 여러행을 반환할 수 있어서 활용도가 높다 (인자값 적용가능)
-- lag, lead - 데이터 전후값 차이를 연산할 때 
select x.payment_date, lag(x.amount,2) over(order by x.payment_date) lag_amount, amount,
	lead(x.amount,2) over(order by x.payment_date) lead_amount
from (
	select date_format(payment_date, '%Y-%m-%d') payment_date, sum(amount) amount from payment group by date_format(payment_date, '%Y-%m-%d')
) x
order by x.payment_date;

-- 누적분포 계산함수 cume_dist : 그룹내 누적분포(%)를 계산 (0초과 1이하 범위값 반환, 항상 같은 누적분포값으로 계산) (null을 최하위(최소)값으로 처리)
select x.customer_id, x.amount, cume_dist() over(order by x.amount desc)
from (
	select customer_id, sum(amount) amount from payment group by customer_id
    ) x
order by x.amount desc;

-- 상대 순위 계산함수 percent_rank - 지정한 그룹 또는 쿼리결과로 이루어진 그룹내 상대순위를 계산할때 사용 (분포순위 계산)
select x.customer_id, x.amount, percent_rank() over(order by x.amount desc)
from (
	select customer_id, sum(amount) amount from payment group by customer_id
    ) x
order by x.amount desc;