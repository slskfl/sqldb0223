-- 만약 employees가 존재하면 우선 삭제한다
drop database if exists sqldb;
create database sqldb;
-- 데이터베이스 접근하기
USE sqldb;
-- 데이터베이스 확인하기
SHOW DATABASES;

use sqldb;
-- 회원 테이블 생성하기
create table usertbl( -- 회원테이블
	userId	char(8) not null primary key, -- 사용자 아이디(PK)
    name varchar(10) not null, -- 이름
    birthYear int not null, -- 출생년도
    addr char(2) not null, -- 지역(경기, 서울 식으로 2글자만 입력)
    mobile1 char(3),-- 휴대폰 국번( 011, 016,017,018, 010 등)
    mobile2 char(8), -- 휴대폰의 나머지 전화번호
    height smallint, -- 키
    mDate date -- 회원가입일
);

-- 회원 구매 테이블 생성하기
create table buytbl(
	num int auto_increment not null primary key, -- 순번(PK)
    userID char(8) not null, -- 아이디(FK)
    prodName char(6) not null, -- 물품명
    groupName char(4) , -- 분류
    price int not null, -- 단가
    amount smallint not null, -- 수량
    foreign key(userID) references usertbl(userID)
);

-- 회원 테이블 레코드 삽입하기 
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL , NULL , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL , NULL , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

-- 회원테이블 레코드 확인하기
select* from usertbl;

use sqldb;
-- 구매 테이블 레코드 삽입
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책' , '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책' , '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책' , '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);
-- 구매테이블 레코드 확인하기
select* from buytbl;

--  구매 테이블에서 사용자가 구매한 물품의 개수를 조회하시오.
select userID as '사용자 아이디', sum(amount) as '총 구매 수량'
from buytbl group by userID;

-- 구매 테이블에서 사용자가 구매한 물품에 대한 구매액의 총합을 조회하시오.
select userID as '사용자 아이디', sum(amount*price)  as '총 구매액'
from buytbl group by userID;

-- 먼저 가입한 순서로 회원들을 조회하시오.
select name, mDate from usertbl order by mDate;

-- 최근에 가입한 순서로 회원들을 조회하시오.
select name, mDate from usertbl order by mDate desc;

-- 신장이 큰 순서대로 정렬하되 만약 신장이 같을 경우에 이름 순으로 정렬하시오
select name, height from usertbl order by height desc, name asc;

-- 전체 구매자가 구매한 물품에 대한 개수의 평균을 구하시오.
select avg(amount) as '평균 구매 개수'
from buytbl;

-- 사용자 별로 구매한 물품에 대한 개수의 평균을 구하시오.
select userID, avg(amount) as '평균 구매 개수'
from buytbl group by userID;

-- 회원들의 거주 지역을 조회하시오.
select addr from usertbl order by addr;

select *  from usertbl limit 5;
select *  from usertbl limit 5, 5;

-- 가장 큰 신장을 가진 사용자와 가장 작은 신장을 가진 사용자를 조회하시오.
select name, max(height), min(height) from usertbl; 

select name, max(height), min(height) from usertbl group by name; 

select name, height from usertbl 
where height=(select max(height) from usertbl)
or height=(select min(height) from usertbl); 

-- 휴대폰이 있는 사용자의 수를 구하시오.
select count(*) from usertbl;

select count(mobile1) as '휴대폰이 있는 사용자' from usertbl;

-- buytbl을 buytbl2로 테이블 복사하기
create table buytbl2(select * from buytbl);

-- 총 구매액이 1000 이상인 사용자를 조회하시오.
select userID as '사용자', sum(amount*price) as '총 구매액' 
from buytbl group by userID;

-- 에러 구문, where절 사용 불가
select userID as '사용자', sum(amount*price) as '총 구매액' 
from buytbl where sum(amount*price) >= 1000
group by userID;

select userID as '사용자', sum(amount*price) as '총 구매액' 
from buytbl 
group by userID
having sum(amount*price) >= 1000;

-- 분류별로 합계 및 그 총합을 구하시오
select num, groupName, sum(price*amount) AS '비용'
from buytbl group by groupName, num with rollup;












