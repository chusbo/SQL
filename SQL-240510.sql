use 한빛무역;

select count(*),
count(고객번호),
count(도시),
count(지역)
from 고객;
# 고객 테이블에서 고객번호, 도시, 지역 개수

select sum(마일리지),
avg(마일리지),
min(마일리지),
max(마일리지)
from 고객;
#고객 마일리지 합과 평균 마일리지, 최소 마일리지와 최대 마일리지를 조회

select sum(마일리지),
avg(마일리지),
min(마일리지),
max(마일리지)
from 고객
where 도시='서울특별시';
#‘서울특별시’ 고객에 대해 마일리지합, 평균마일리지, 최소마일리지, 최대마일리지 조회

select 도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
group by 도시;
#도시별 고객의 수와 해당 도시 고객들의 평균마일리지를 조회

select 도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
group by 1;
#GROUP BY에 컬럼명 대신 SELECT 나열되어 있는 컬럼의 순번을 넣을 수도있음(비추천)

select 담당자직위,
도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
group by 담당자직위,
도시
order by 1, 2;
#담당자직위별, 같은 담당자직위에 대해서는 도시별 결과(고객수와 평균마일리지),(담당자직위 순, 도시 순으로 정렬)

select 도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
group by 도시
having count(*) >=10;
# 도시별로 그룹을 묶어서 고객수와 평균마일리지를 구하고, 이 중에서 고객수가 10명 이상인 레코드만

select 도시,
sum(마일리지)
from 고객
where 고객번호 like 'T%'
group by 도시
having sum(마일리지) >=1000;
# 고객번호가 ‘T’로 시작하는 고객에 대해 도시별로 묶어서 고객의 마일리지 합 (마일리지 합이 1000 이상)

select 도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
where 지역 is null
group by 도시
with rollup;
#지역이 NULL고객 도시별로 고객수와 평균마일리지, 맨 마지막 행에 전체 고객수와 전체 고객에 대한 평균마일리지

select ifnull(도시,'총계') as 도시,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객
where 지역 is null
group by 도시
with rollup;
# 맨 마지막 행 null 값에 '총계'입력

select ifnull(담당자직위, '총계') as 담당자직위,
도시,
count(*) as 고객수
from 고객
where 담당자직위 like '%마케팅%'
group by 담당자직위, 도시
with rollup;

select 담당자직위, 
도시 
from 고객 
where 담당자직위 like '%마케팅%';

select 지역,
count(*) as 고객수
from 고객
where 담당자직위 = '대표 이사'
group by 지역
with rollup;
#담당자직위가 ‘대표 이사’인 고객 지역별로 고객수, 전체 고객수

select 지역,
count(*) as 고객수,
grouping(지역) as 구분
from 고객
where 담당자직위 = '대표 이사'
group by 지역
with rollup;
#담당자직위가 ‘대표 이사’인 고객 지역별로 고객수, 전체 고객수(grouping 사용)

select group_concat(이름)
from 사원;
#GROUP_CONCAT( )을 사용하여 사원 테이블에 들어있는 이름을 한 행에 나열

select group_concat(distinct 지역)
from 고객;
#고객 테이블에 들어있는 지역을 한 행에 나열하되 중복되는 지역은 한 번씩만

select 도시,
group_concat(고객회사명) as 고객회사명목록
from 고객
group by 도시;
#고객 테이블에서 도시별 고객회사명

--------------------------------------------------------------------------------
#문제1
select count(*) as 'COUNT(도시)',
count(distinct 도시) as 'COUNT(DISTINCT 도시)'
from 고객;

#문제2
select distinct(year(주문일)) as 주문년도,
count(*) as 주문건수
from 주문
group by 주문년도;

#문제3
select year(주문일) as 주문년도,
quarter(주문일) as 분기,
count(*) as 주문건수
from 주문
group by 주문년도, 분기
with rollup;


select * from 주문;
#문제4
select distinct(month(주문일)) as 주문월,
count(month(주문일)) as 주문건수
from 주문 where datediff(발송일, 요청일) >0
group by 주문월
order by 1;

#문제5
select 제품명,
sum(재고) as 재고합
from 제품
where 제품명 like '%아이스크림'
group by 제품명;

#문제6
select case when 마일리지>=50000 then 'vip고객' else '일반고객' end as 고객구분,
count(*) as 고객수,
avg(마일리지) as 평균마일리지
from 고객 group by 고객구분;
--------------------------------------------------------------------------------

select 부서.부서번호,
부서명,
이름,
사원.부서번호
from 부서
cross join 사원
where 이름='배재용';
#사원 테이블과 부서 테이블을 크로스 조인하여 ‘배재용’ 사원에 대한 정보

select 사원번호,
직위,
사원.부서번호,
부서명
from 사원
inner join 부서
on 사원.부서번호 = 부서.부서번호
where 이름= '이소미';
#'이소미' 사원의 사원번호, 직위, 부서번호, 부서명

select 고객.고객번호,
담당자명,
고객회사명,
count(*) as 주문건수
from 고객
inner join 주문
on 고객.고객번호 = 주문.주문번호
group by 고객.고객번호,
담당자명,
고객회사명
order by count(*) desc;

select 고객.고객번호,
담당자명,
고객회사명,
sum(주문수량*단가) as 주문금액합
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
inner join 주문세부
on 주문.주문번호 = 주문세부.주문번호
group by 고객.고객번호,
담당자명,
고객회사명
order by 4 desc;
#고객별(고객번호, 담당자명, 고객회사명)로 주문금액 합, 주문금액 합이 많은 순서

select 고객번호,
담당자명,
마일리지,
등급.*
from 고객
cross join 마일리지등급 as 등급
where 담당자명 = '이은광';
#고객 테이블과 마일리지등급 테이블을 크로스 조인, 고객 테이블에서 담당자‘이은광’의 고객번호, 담당자명, 마일리지와 마일리지등급

select 사원번호,
직위,
사원.부서번호,
부서명
from 사원
inner join 부서
on 사원.부서번호 = 부서.부서번호;

select 사원번호,
직위,
사원.부서번호,
부서명
from 사원
cross join 부서;

select 고객번호,
고객회사명,
담당자명,
마일리지,
등급명
from 고객
inner join 마일리지등급
on 마일리지>=하한마일리지
and 마일리지<=상한마일리지
where 담당자명 = '이은광';

select 사원번호,
이름,
부서명
from 사원
left outer join 부서
on 사원.부서번호 = 부서.부서번호
where 성별='여';

select 부서명,
사원.*
from 사원
right outer join 부서
on 사원.부서번호 = 부서.부서번호;

select 사원.사원번호,
사원.이름,
사원.사원번호 as '상사의 사원번호',
상사.이름 as '상사의 이름'
from 사원
inner join 사원 as 상사
on 사원.상사번호 = 상사.사원번호;
#부서명과 해당 부서의 소속 사원 정보, 이때 사원이 한명도 존재하지 않는 부서명도 출력

select 부서명,
사원.*
from 사원
right outer join 부서
on 사원.부서번호 = 부서.부서번호
where 사원.부서번호 is null;
#사원이 한 명도 존재하지 않는 부서명

select 이름,
부서.*
from 사원
left outer join 부서
on 사원.부서번호 = 부서.부서번호
where 부서.부서번호 is null;
#소속 부서가 없는 사원


#-----셀프조인------
select 사원.사원번호,
사원.이름,
상사.사원번호 as '상사의 사원번호',
상사.이름 as '상사의 이름'
from 사원
inner join 사원 as 상사
on 사원.상사번호 = 상사.사원번호;
#사원의 사원번호,이름 - 상사의 사원번호,이름

select 사원.이름 as 이름,
사원.직위,
상사.이름 as 상사이름
from 사원 as 상사
right outer join 사원
on 사원.상사번호 = 상사.사원번호
order by 상사이름;
#사원이름, 직위, 상사이름, 상사가 없는 사원의 이름

--------------------------------------------------------------------------------
#문제1
select 제품.제품명,
sum(주문수량) as 주문수량합,
sum(주문수량*주문세부.단가) as 주문금액합
from 제품
inner join 주문세부
on 제품.제품번호=주문세부.제품번호
group by 제품.제품명;

#문제2
select year(주문일) as 주문년도,
제품.제품명 as 제품명,
sum(주문세부.주문수량) as 주문수량합
from 주문
inner join 주문세부
on 주문.주문번호=주문세부.주문번호
inner join 제품 
on 주문세부.제품번호=제품.제품번호
where 제품명 like '%아이스크림'
group by 주문년도, 제품명;

#문제3
select 제품명,
sum(주문세부.주문수량) as 주문수량합
from 제품
left outer join 주문세부
on 제품.제품번호=주문세부.제품번호
group by 제품명;

#문제4
select 고객번호,
고객회사명,
담당자명,
마일리지등급.등급명,
마일리지
 from 고객
inner join 마일리지등급
on 마일리지 between 10000 and 99999
where 등급명='A';