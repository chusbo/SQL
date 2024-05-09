use 한빛무역;

select distinct 도시 from 고객;

select 25+3;
select 25+3 as 더하기, 23-5 as 빼기, 23*5 as 곱하기, 23/5 as 실수나누기, 23 div 5 as 정수나누기, 23%5 as 나머지1, 23 mod 5 나머지2;
select 25>=3 as 비교연산; /*크거나 같다(＞=), 작거나 같다(＜=), 크다(＞), 작다(＜), 같다(=), 같지 않다(!= 또는 ＜＞)가 있음*/

select * from 고객 where 담당자직위 <> '대표 이사';
select * from 고객 where 담당자직위 <> '대표이사'; /*띄어쓰기 인식하므로 주의*/

select * from 고객 where 도시 ='부산광역시' and 마일리지<1000; /*도시가 '부산광역시'이면서 마일리지가 1,000점보다 작은 고객*/

select 고객번호, 담당자명, 마일리지, 도시 from 고객 where 도시 = '부산광역시' union select 고객번호, 담당자명, 마일리지, 도시 from 고객 where 마일리지 <1000 order by 1;
select 고객번호, 담당자명, 마일리지, 도시 from 고객 where 도시 = '부산광역시' or 마일리지<1000 order by 1;

select * from 고객 where 지역 is null; /* 값이 들어있지 않은 데이터는 is null*/
select * from 고객 where 지역 =''; /*''는 빈 문자열*/

select * from 고객 where 지역='';

update 고객 set 지역 = null where 지역 ='';
select * from 고객 where 지역 is null;

select 고객번호, 담당자명, 담당자직위 from 고객 where 담당자직위 = '영업 과장' or 담당자직위 = '마케팅 과장	';

select 담당자명, 마일리지 from 고객 where 마일리지 >= 100000 and 마일리지 <= 200000;
select 담당자명, 마일리지 from 고객 where 마일리지 between 100000 and 200000;

select * from 고객 where 도시 like '%광역시' and (고객번호 like '_c%' or 고객번호 like '__c%'); /*도시가 ‘광역시’이면서 고객번호 두 번째 글자 또는 세 번째 글자가‘C’인 고객*/

/*1번 문제*/
select * from 고객 where 도시='서울특별시' and 마일리지 >= 15000 and 마일리지 <= 20000;
/*select * from 고객 where 도시='서울특별시' and 마일리지 between 15000 and 20000;*

/*2번 문제*/
select distinct 지역,도시 from 고객 order by 1;

/*3번 문제*/
select * from 고객 where (도시='춘천시' or 도시='과천시' or 도시='광명시') and (담당자직위 like '%사원' or 담당자직위 like '%이사');

/*4번 문제*/
select * from 고객 where not(도시 like '%광역시'or 도시 like '%특별시') order by 마일리지 desc limit 3;

/*5번 문제*/
select * from 고객 where 지역 regexp'[^null]' and 담당자직위 regexp'[^대표 이사]';


select char_length('HELLO')/*영문자 개수 변환*/,
length('HELLO')/*영문자 바이트 수*/,
char_length('안녕')/*문자 개수*/,
length('안녕')/*utf-8 바이트 수*/;
 /*영문 ‘HELLO’와 한글 ‘안녕’의 문자 개수*/

select concat('DREAMS', 'COME', 'TRUE'), /*문자열 연결*/
concat_ws('-', '2023', '01', '29'); /*구분주 '-'로 연결*/
/*CONCAT , CONCAT_WS 문자 연결*/

select left('SQL 완전정복', 3) /*왼쪽부터 3문자*/
,right('SQL 완전정복', 4) /*오른쪽부터 4문자*/
,substr('SQL 완전정복', 2, 5) /*2번째 문자부터 5문자*/
,substr('SQL 완전정복', 2); /* 2번째 문자부터 끝까지*/
/*'SQL 완전정복' 문자열 길이 지정'*/

select substring_index('서울시 동작구 흑석로', ' ', 2)  /*왼쪽부터 두 번째 공백 이후 제거*/
,substring_index('서울시 동작구 흑석로', ' ', -2); /*오른쪽부터 두 번째 공백 이전 제거*/
/*‘서울시 동작구 흑석로’에서 앞/뒤 2번째 위치에 있는 공백(‘ ’) 기준으로 문자열 분리*/

select lpad('SQL', 10, '#') /* 문자열 왼쪽에 # 채우기 */
,rpad('SQL', 5, '*'); /* 문자열 오른쪽에 * 채우기 */

select length(ltrim(' SQL ')) /* ltrim = 왼쪽 공백 지우기 */
,length(rtrim(' SQL ')) /* rtrim = 오른쪽 공백 지우기 */
,length(trim(' SQL ')); /* trim = 공백 모두 지우기 */

select trim(both 'abc' from 'abcSQLabcabc')
,trim(leading 'abc' from 'abcSQLabcabc')
,trim(trailing 'abc' from 'abcSQLabcabc');

select field('JAVA', 'SQL', 'JAVA', 'C')
,find_in_set('JAVA', 'SQL,JAVA,C')
,instr('네 인생을 살아라','인생')	/* 인생의 위치 */
,locate('인생', '네 인생을 살아라');

select repeat('*',5);  /* ‘*’ 5개 반복 */

select replace('010.1234.5678', '.', '-');  /* ‘.’로 구분되어 있는 전화번호의 구분자를 */

select reverse('olleh'); #'olleh' 거꾸로

select celing(123.56) #올림
,floor(123.56) #버림
,round(123.56)  #반올림
,round(123.56, 1) #반올림(소수자리 1번째까지 표시)
,truncate(123.56, 1); #지정한 위치에서 버림

select abs(-120)
,abs(120)
,sign(-120)
,sing(120);
#-120과 120의 절댓값과 음수, 양수
 
select mod(203,4)
,203 % 4
,200 mod 4;
#203을 4로 나눈 나머지

select power(2, 3) #2의 3 제곱근
,sqrt(16)
,rand()
,rand(100)
,round(rand()*100);

select now()
,sysdate()
,curdate()
,curtime();
#현재 날짜와 시간을 다양한 형태로alter

select now()	#현재날짜
,year(now())	#연도
,quarter(now())	#분기
,month(now())	#월
,day(now())		#일
,hour(now())	#시
,minute(now())	#분
,second(now());	#초
#날짜에 관한 함수

select now()
,datediff('2025-12-20', now())
,datediff(now(), '2025-12-20')
,timestampdiff(year, now(), '2025-12-20')
,timestampdiff(month, now(), '2025-12-20')
,timestampdiff(day, now(), '2025-12-20');
#현재 날짜를 기준으로 날짜 사이의 기간

select now()
,adddate(now(), 50)					#50일 후
,adddate(now(), interval 50 day)	#50일 후
,adddate(now(), interval 50 month)	#50개월 후
,subdate(now(), interval 50 hour);	#50시간 전

select now()
,last_day(now())
,dayofyear(now())
,monthname(now())
,weekday(now());
#오늘 날짜를 기준으로 이번 달 마지막 날짜와 일 년 중 몇 일째인지, 그리고 월 이름과 요일을 확인

select cast('1' as unsigned)
,cast(2 as char(1))
,convert('1', unsigned)
,convert(2, char(1));

select if(12500*450>5000000, '초과달성','미달성');
#12,500원짜리 제품을 450개 이상 주문한 금액이 5,000,000원 이상이면 ‘초과달성’, 미만이면 '미달성'

select ifnull(1, 0)
,ifnull(null, 0)
,ifnull(1/0, 'ok');

select nullif(12*10, 120)
,nullif(12*10,1200);

#case when 마일리지 >= 10000 then 'vvip고객' 


#문제1
select 고객회사명, concat('**', left(고객회사명, 2)) as 고객회사명2, 전화번호, substr(replace(전화번호,')','-'), 2) as 전화번호2 from 고객;

#문제2
select *, truncate(주문수량 * 단가, -1) as 주문금액, truncate(주문수량*단가*할인율, -1) as 할인금액, truncate((주문수량 * 단가)-(주문수량* 단가* 할인율), -1) as 실주문금액 from 주문세부;

#문제3
select * from 사원;
select 이름, 생일, timestampdiff(year, 생일, now())as 만나이, 입사일, timestampdiff(day, 입사일, now())as 입사일수, adddate(입사일, 500)as 500일후 from 사원;

#문제4
select 담당자명
, 고객회사명
, 도시
, if(도시 like'%특별시'or 도시 like'%광역시', '대도시', '도시') as 도시구분
, 마일리지
, case when 마일리지>=100000 then 'vvip고객' when 마일리지>=10000 then 'vip고객' else '일반고객' end as 마일리지구분
 from 고객;
 
 #문제5
select 주문번호
,고객번호
,주문일
,year(주문일) as 주문년도
,quarter(주문일) as 주문분기
,month(주문일) as 주문월
,day(주문일) as 주문일
,weekday(주문일) as 주문요일
,case weekday(주문일) when 0 then '월요일'
when 1 then '화요일'
when 2 then '수요일'
when 3 then '묙요일'
when 4 then '금요일'
when 5 then '토요일'
else '일요일'
end as 한글요일
from 주문;

#문제6
select 주문번호,
고객번호,
사원번호,
주문일,
요청일,
발송일,
datediff(발송일, 요청일) as 지원일수 from 주문 where datediff(발송일, 요청일) >=7;
