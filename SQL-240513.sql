use 한빛무역;

select 고객번호,
고객회사명,
담당자명,
마일리지
from 고객
where 마일리지 = (select max(마일리지) from 고객);
#최고 마일리지를 보유한 고객

select 고객회사명,
담당자명
from 고객
where 고객번호 = (select 고객번호 from 주문 where 주문번호 = 'H0250');
#주문번호 'H250'을 주문한 고객에 고객회사명,담당자명 - 서브쿼리 사용

select 고객회사명,
담당자명
from 고객
inner join 주문
on 고객.고객번호=주문.고객번호
where 주문번호 = 'H0250';
#-조인 사용

select 담당자명,
고객회사명,
마일리지
from 고객
where 마일리지 >(select min(마일리지) from 고객 where 도시 = '부산광역시');
#'부산광역시' 고객의 최소 마일리지보다 큰 마일리지 고객

select count(*) as 주문건수
from 주문
where 고객번호 in (select 고객번호 from 고객 where 도시 = '부산광역시');
#'부산광역시' 고객이 주문한 주문건수

select 담당자명,
고객회사명,
마일리지
from 고객
where 마일리지 > any (select 마일리지 from 고객 where 도시 = '부산광역시');
#'부산광역시'전체 고객의 마일리지보다 마일리지가 큰 고객

select 담당자명,
고객회사명,
마일리지
from 고객
where 마일리지 > all (select avg(마일리지) from 고객 group by 지역);
#각 지역의 평균 마일리지 중 최대 값보다 큰 마일리지를 가진 고객

select 고객번호,
고객회사명
from 고객
where exists (select * from 주문 where 고객번호 = 고객.고객번호);
#한 번이라도 주문한 적이 있는 고객의 정보

#실습1 - 한 번이라도 주문한 적이 있는 고객의 정보(inner join 사용)
select distinct 고객.고객번호,
고객회사명,
주소,
전화번호
from 고객
inner join 주문
on 고객.고객번호=주문.고객번호
order by 고객번호;

#실습2 - 한 번이라도 주문한 적이 없는 고객의 정보
select 고객번호,
고객회사명,
주소,
전화번호
from 고객
where !exists (select * from 주문 where 고객번호 = 고객.고객번호);

#실습2 - 한 번이라도 주문한 적이 없는 고객의 정보 ver.2
select 고객.고객번호,
고객회사명,
주소,
전화번호
from 고객
left join 주문 on 고객.고객번호 = 주문.고객번호
where 주문.고객번호 is null;

select 도시,
avg(마일리지) as 편균마일리지
from 고객
group by 도시
having avg(마일리지) > (select avg(마일리지) from 고객);
#고객 전체 평균마일리보다 평균마일리지가 큰 도시

select 담당자명,
고객회사명,
마일리지,
고객.도시,
도시_평균마일리지,
도시_평균마일리지 - 마일리지 as 차이
from 고객,
(select 도시, avg(마일리지) as 도시_평균마일리지 from 고객 group by 도시) as 도시별요약
where 고객.도시 = 도시별요약.도시;
#도시의 평균마일리지와 각 고객 마일리지 차이 (from절 서브쿼리)

with 도시별요약 as
(select 도시,
avg(마일리지) as 도시_평균마일리지
from 고객
group by 도시)

select 담당자명,
고객회사명,
마일리지,
고객.도시,
도시_평균마일리지,
도시_평균마일리지 - 마일리지 as 차이
from 고객,
도시별요약
where 고객.도시 = 도시별요약.도시;
#도시의 평균마일리지와 각 고객 마일리지 차이 (cte 사용)

select 사원번호,
이름,
상사번호,
(select 이름 from 사원 as 상사 where 상사.사원번호 = 사원.상사번호) as 상사이름
from 사원;
#사원 테이블에서 사원번호,사원이름,상사의 전화번호와 이름

select 도시,
담당자명,
고객회사명,
마일리지
from 고객
where (도시, 마일리지) in (select 도시, max(마일리지) from 고객 group by 도시);
#각 도시마다 최고 마일리지 보유 고객


#문제1
select 부서명
from 부서 
inner join 사원
on 부서.부서번호=사원.부서번호
where 이름='배재용';

#문제1 참고용
select 부서명
from 부서
where 부서번호 in (select 부서번호 from 사원 where 이름 = '배재용');

#문제2
select 제품번호,
제품명,
포장단위,
단가,
재고,
단가*재고 as 재고금액
from 제품
where !exists (select * from 주문세부 where 제품번호 = 제품.제품번호);

#문제2 참고용
select 제품번호,
제품명,
포장단위,
단가,
재고,
단가*재고 as 재고금액
from 제품
where 제품번호 not in (select 제품번호 from 주문세부);

#문제3
select 담당자명,
고객회사명,
(select count(주문일) from 주문 where 고객.고객번호=주문.고객번호) as 주문건수,
(select min(주문일) from 주문 where 고객.고객번호=주문.고객번호) as 최초주문일,
(select max(주문일) from 주문 where 고객.고객번호=주문.고객번호) as 최종주문일
from 고객
where (select count(주문일) from 주문 where 고객.고객번호=주문.고객번호)>0;

insert into 부서
values('AS', '마케팅부');
#부서 테이블에 삽입

insert into 제품
values(91, '연어피클소스', NULL, 5000, 40);
#제품 테이블에 추가

insert into 제품(제품번호, 제품명, 단가, 재고)
values(90, '연어핫소스', 4000, 50);
#제품 테이블에 추가

insert into 사원(사원번호, 이름, 직위, 성별, 입사일)
values('E20', '김사과', '수습사원', '남', curdate()),
('E21', '박바나나', '수습사원', '여', curdate()),
('E22', '정오렌지', '수습사원', '여', curdate());
#사원 테이블에 추가

update 사원
set 이름 = '김레몬'
where 사원번호 ='E20';
#사원번호가 E20인 데이터 수정

update 제품
set 단가 = 단가 * 1.1,
재고 = 재고 - 10
where 제품번호 = 91;
#제품번호 91 단가 10% 인상, 재고 -10

delete from 제품
where 제품번호 = 91;
#제품번호 91 삭제

delete from 사원
order by 입사일 desc
limit 3;
#이사입이 가장 늦은 사원 3명 삭제

insert into 제품(제품번호, 제품명, 단가, 재고)
value(91, '연어피클핫소스', 6000, 50)
on duplicate key update
제품명 = '연어피클핫소스', 단가 = 6000, 재고 = 50;
#제품번호 91이 없다면 추가 존재한다면 값을 수정

create table 고객주문요약
(고객번호 char(5) primary key,
고객회사명 varchar(50),
주문건수 int,
최종주문일 date);
#고객주문요약 테이블 만들기

insert into 고객주문요약
	select 고객.고객번호,
    고객회사명,
    count(*),
    max(주문일)
from 고객,
주문
where 고객.고객번호 = 주문.고객번호
group by 고객.고객번호,
고객회사명;
#고객주문요약 레코드 삽입
select * from 고객주문요약;

update 제품
set 단가 = (select * from
(select avg(단가)
from 제품
where 제품명 like '%소스%') as T)
where 제품번호 = 91;
#제품번호 91인 제품 단가를 '소스' 제품들 평균단가로

update 고객,
	(select distinct 고객번호
    from 주문) as 주문고객
set 마일리지 = 마일리지 * 1.1
where 고객.고객번호 in (주문고객.고객번호);
#한 번이라도 주문한 적이 있는 고객의 마일리지 10% 인상
#결과 학인
select * from 고객 where 고객번호 in (select distinct 고객번호 from 주문);


update 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
set 마일리지 = 마일리지 + 1000
where 등급명 = 'S';
#마일리지등급 'S'인 고객 마일리지 +1000
#결과 확인
select 고객번호, 고객회사명,마일리지
from 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
where 등급명 = 'S';

select * from 주문 where 주문번호 = 'H0248';
select * from 주문세부 where 주문번호 = 'H0248';
#주문번호 'H0248'주문,주문세부 확인
#후 삭제하기
delete 주문,	주문세부
from 주문
inner join 주문세부
on 주문.주문번호 = 주문세부.주문번호
where 주문.주문번호 = 'H0248'; 

select 고객.*
from 고객
left outer join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.고객번호 is null;
#한 번도 주문한 적이 없는 고객의 정보 검색
#후 삭제
delete 고객
from 고객
left join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.고객번호 is null;

select * from 제품;

insert into 제품(제품번호, 제품명, 포장단위, 단가, 재고)
value(95, '망고베리 아이스크림', '400g', 800, 30);

insert into 제품(제품번호, 제품명, 단가)
value(96, '눈꽃빙수맛 아이스크림', 2000);
