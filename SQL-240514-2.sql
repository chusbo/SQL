create database 한빛학사;
#한빛학사 데이터베이스를 생성

create table 학과(
학과번호 char(2),
학과명 varchar(20),
학과장명 varchar(20));
#학과 테이블 생성

insert into 학과
values('AA', '컴퓨터공학과', '배경민'),
('BB', '소프트웨어학과', '김남준'),
('CC', '디자인융합학과', '박선영');
#학과 테이블에 3건의 레코드 삽입

create table 학생(
학번 char(5),
이름 varchar(20),
생일 date,
연락처 varchar(20),
학과번호  char(2));
#학생 테이블 생성

insert into 학생
values('S001', '이윤주', '2020-01-30', '01033334444', 'AA'),
('S001', '이승우', '2021-02-23', null, 'AA'),
('S003', '백재용', '2018-03-31', '01077778888', 'DD');
#학생 테이블의 3건의 레코드 삽입

create table 휴학생 as
select *
from 학생
where 1=2;  #1=2; 구조만 병경(데이터 복사x)
#학생 테이블에 휴학생 테이블 생서

create table 회원(
아이디 varchar(20) primary key,
회원명 varchar(20),
키 int,
몸무게 int,
체질량지수 decimal(4, 1) as (몸무게 / power(키 / 100, 2)) stored);
#회원 테이블 생성 및 체질량지수 자동계산되도록 설정

insert into 회원(아이디, 회원명, 키, 몸무게)
values('APPLE', '김사과', 178, 70);
# 레코드 삽입

#alter table add = 컬럼 추가
#alter table drop column = 컬럼 삭제
#alter table change column = 컬럼 내용 및 속성 변경
#alter table modify column = 컬럼에 속성만 변경

alter table 학생 add 성별 char(1);
#학생 테이블에 성별 컬럼 추가

alter table 학생 modify column 성별 varchar(2);
#학생 테이블 성별 컬러 데이터타입 변경

alter table 학생 change column 연락처 휴대폰번호 varchar(20);
# 학생 테이블 연락처->휴대폰으로 변경

alter table 학생 drop column 성별;
#학생 테이블에 성별 컬럼 삭제

alter table 휴학생 rename 졸업생;
#휴학생 테이블 졸업생 으로 변경

drop table 학과;
drop table 학생;
#학생,학과 테이블 삭제

create table 학과(
학과번호 char(2) primary key,
학과명 varchar(20) not null,
학과장명 varchar(20));
#제약조건 추가하여 학과 테이블 생성

create table 학과(
학과번호 char(2),
학과명 varchar(20) not null,
학과장명 varchar(20),
primary key(학과번호));
#방법2.테이블 레벨로 제약조건 설정

create table 학생(
학번 char(5) primary key,
이름 varchar(20) not null,
생일 date not null,
연락처 varchar(20) unique,
학과번호 char(2) references 학과(학과번호),
성별 char(1) check(성별 in('남', '여')),
등록일 date default(curdate()),
foreign key(학과번호) references 학과(학과번호));
#제약조건 추가하여 학생 테이블 재생성

create table 학생(
학번 char(5),
이름 varchar(20) not null,
생일 date not null,
연락처 varchar(20),
학과번호 char(2),
성별 char(1),
등록일 date default(curdate()),
primary key(학번),
unique(연락처),
check(성별 in ('남', '여')),
foreign key(학과번호) references 학과(학과번호));
#방법2. 테이블 레벨로 제약조건 설정

create table 과목(
과목번호 char(5) primary key,
과목명 varchar(20) not null,
학점 int not null check(학점 between 2 and 4),
구분 varchar(20) check(구분 in('전공', '교양', '일반')));
#제약조건을 추가하여 과목 테이블 생성

create table 수강_1(
수강년도 char(4) not null,
수강학기 varchar(20) not null check(수강학기 in ('1학기', '2학기', '여름학기', '겨울학기')),
학번 char(5) not null,
과목번호 char(5) not null,
성적 decimal(3, 1) check(성적 between 0 and 4.5),
primary key(수강년도, 수강학기, 학번, 과목번호),
foreign key (학번) references 학생(학번),
foreign key (과목번호) references 과목(과목번호));
#제약조건 추가하여 수강_1테이블 생성, 기본키는 수강년도,수강학기,학번,과목번호

create table 수강_2(
수강번호 int primary key auto_increment,
수강년도 char(4) not null,
수강학기 varchar(20) not null check(수강학기 in ('1학기', '2학기', '여름학기', '겨울학기')),
학번 char(5) not null,
과목번호 char(5) not null,
성적 numeric(3, 1) check(성적 between 0 and 4.5),
foreign key (학번) references 학생(학번),
foreign key (과목번호) references 과목(과목번호));
#수강번호라는 대리키를 기본키로 하는 제약조건 추가

insert into 학과
values ('AA', '컴퓨터공학과', '배경민');
insert into 학과
values ('BB', '소프트웨어학과', '김남준');
insert into 학과
values ('CC', '디자인융합과', '박선영');
#학과 테이블에 레크도 3건 추가

insert into 학생(학번, 이름, 학과번호, 생일)
values ('S0001', '이윤주', 'AA', '2020-01-30');
insert into 학생(학번, 이름, 생일, 학과번호)
values ('S0002', '이승은', '2021-02-23', 'AA');
insert into 학생(학번, 이름, 생일, 학과번호)
values ('S0003', '백재용', '2018-03-31', 'CC');
#학생 테이블에 레코드 3건 추가

insert into 과목(과목번호, 과목명, 구분, 학점)
values ('C0001', '데이터베이스실습', '전공', 3);
insert into 과목(과목번호, 과목명, 구분, 학점)
values ('C0002', '데이터베이스 설계와 구축', '전공', 4);
insert into 과목(과목번호, 과목명, 구분, 학점)
values ('C0003', '데이터 분석', '전공', 3);
#과목 테이블에 레코드 3건 추가

insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0001', 4.3);
insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0001', 4.5);
#오류 발생
insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0002', 4.4);
insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0002', 'C0002', 4.3);
#수강_1 테이블에 레코드 추가

insert into 수강_2(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0001', 4.3);
insert into 수강_2(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0001', 4.5);
#수강_2 테이블에 레코드 추가

alter table 학생 add constraint check(학번 like 'S%');
#학생 테이블에서 모든 학번은 'S'로 시작하는 제약조건 추가

alter table 학생 drop constraint 연락처;
#학생 테이블에서 연락처에 걸려있는 제약조건 삭제

create table 학생_2(
학번 char(5),
이름 varchar(20) not null,
생일 date not null,
연락처 varchar(20),
학과번호 char(2),
성별 char(1),
등록일 date default(curdate()),
primary key(학번),
constraint uk_학생2_연락처 unique(연락처),
constraint ck_학생2_성별 check(성별 in ('남', '여')),
constraint fk_학생2_학과번호 foreign key(학과번호) references 학과(학과번호));
#학생_2 테이블 생성하며 제약조건 지정

create table 수강평가(
평가순번 int primary key auto_increment,
학번 char(5) not null,
과목번호 char(5) not null,
평점 int check(평점 between 0 and 5),
과목평가 varchar(500),
평가일시 datetime default current_timestamp,
foreign key (학번) references 학생(학번),
foreign key (과목번호) references 과목(과목번호) on delete cascade);

insert into 수강평가(학번, 과목번호, 평점, 과목평가)
values('S0001', 'C0001', 5, 'SQL학습에 도움이 되었습니다.'),
('S0001', 'C0003', 5, 'SQL 활용을 배워서 좋았습니다.'),
('S0002', 'C0003', 5, '데이터 분석에 관심이 생겼습니다.'),
('S0003', 'C0003', 5, '머신러닝과 시각화 부분이 유용했습니다.');

delete from 과목 where 과목번호 = 'C0003';
select * from 과목;
select * from 수강평가;
#과목 테이블에서 'C0003'과목을 삭제-연결된 수행평가 테이블도 삭제 확인

select * from 회원;
select * from 구매;
create table 회원(
아이디 char(5) primary key,
이름 char(5) not null,
생년 int,
지역 char(2),
국번 int,
전화번호 varchar(20),
키 int,
가입일 varchar(20));

create table 구매(
순번 int primary key auto_increment,
아이디 char(5),
물품 char(5),
분류 char(2),
단가 int,
수량 int,
foreign key (아이디) references 회원(아이디));

insert into 회원(아이디, 이름, 생년, 지역, 국번, 전화번호, 키, 가입일)
values ('YJS', '유재석', 1972, '서울', 010, '11111111', 178, '2008.8.8'),
('KHD', '강호동', 1970, '경북', 011, '22222222', 182, '2007.7.7'),
('KKJ', '김국진', 1965, '서울', 019, '33333333', 171, '2009.9.9'),
('KYM', '김용만', 1967, '서울', 010, '44444444', 177, '2015.5.5'),
('KJD', '김제동', 1974, '경남', null, null, 173, '2013.3.3'),
('NHS', '남희석', 1971, '충남', 016, '66666666', 180, '2017.4.4'),
('SDY', '신동엽', 1971, '경기', null, null, 176, '2008.10.10'),
('LHJ', '이휘재', 1972, '경기', 011, '88888888', 180, '2006.4.4'),
('LKK', '이경규', 1960, '경남', 018, '99999999', 170, '2004.12.12'),
('PSH', '박수홍', 1970, '서울', 010, '00000000', 183, '2012.5.5');

select * from 회원;

insert into 구매(아이디, 물품, 분류, 단가, 수량)
values ('KHD', '운동화', null, 30, 2),
('KHD', '노트북', '전자', 1000, 1),
('KYM', '모니터', '전자', 200, 1),
('PSH', '모니터', '전자', 200, 5),
('KHD', '청바지', '의류', 50, 3),
('PSH', '메모리', '전자', 80, 10),
('KJD', '책', '서적', 15, 5),
('LHJ', '책', '서적', 15, 2),
('LHJ', '청바지', '의류', 50, 1),
('PSH', '운동화', null, 30, 2),
('LHJ', '책', '서적', 15, 1),
('PSH', '운동화', null, 30, 2);

select * from 구매;

--------------------------------------------------------
#문제1

