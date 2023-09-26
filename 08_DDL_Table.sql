/* ***********************************************************************************
테이블 생성



데이터 생성은 create
데이터 수정은 alter
데이터 삭제는 drop라고 명명한다. 뭐 생각보다 다 아는거지?

여기에 더해서 데이터를 지우는 truncate가 있다.




- 구문
create table 테이블 이름(
  컬럼 설정
)
컬럼 설정(이런건 외우려고 하면 안되고 그냥 많이 코드를 쳐봐야 한다.)
- 컬럼명   데이터타입  [default 값]  [제약조건] 
- 데이터타입
- default : 기본값. 값을 입력하지 않을 때 넣어줄 기본값.
제약조건 설정 
- primary key (PK): 행식별 컬럼. NOT NULL, 유일값(Unique)
- unique Key (uk) : 유일값을 가지는 컬럼. null을 가질 수있다.
- not null (nn)   : 값이 없어서는 안되는 컬럼.
- check key (ck)  : 컬럼에 들어갈 수 있는 값의 조건을 직접 설정.
- foreign key (fk): 다른 테이블의 primary key 컬럼의 값만 가질 수 있는 컬럼. 
                    다른 테이블을 참조할 때 사용하는 컬럼.

- 컬럼 레벨 설정
    - 컬럼 설정에 같이 설정
- 테이블 레벨 설정
    - 컬럼 설정 뒤에 따로 설정

- 기본 문법 : constraint 제약조건이름 제약조건타입(지정할컬럼명) 
- 테이블 제약 조건 조회(그냥 뭐 알아만 두자.)
     - select * from information_schema.table_constraints;

    
테이블 삭제
- 구분
DROP TABLE 테이블이름;

- 제약조건 해제
   SET FOREIGN_KEY_CHECKS = 0;
- 제약조건 설정
   SET FOREIGN_KEY_CHECKS = 1;   
*********************************************************************************** */

/*실전!!*/

use testdb; /*만약 없다면 create database testdb 구문을 적자.*/
create table parent_tb( /*부모 디비를 만든다.*/
  no int primary key,
  name varchar(20) not null, /*이놈은 null을 가질 수 없다! not null은 컬럼 레벨에서만 설정이 가능하다.*/
  join_date timestamp default current_timestamp, /*timestamp 타입은 날짜와 시간을 다 저장한다.*/
  /*current_timestamp은 insert할 때의 일시를 넣겠다는 것이다.*/
  email varchar(100) unique, 
  gender char(1) not null check(gender in ('M','F')) /*글자수를 1글자를 넘게 설정하면, 찾을 때 잘 못찾게 된다.*/
  /*NOT NULL, CHECK 조건에 대해 잘 파악하도록 하자.*/
  
); 

/*mysql에서 테이블 확인 ----디비마다 다루는 것이 다르다.*/

show tables;


/*스키마 등에 대한 정보를 알 수 있다.*/
select * from information_schema.table_constraints
where table_schema = 'testdb';


/*하나 더 만들어볼까?*/
create table child_tb(
no int auto_increment, /*auto_increment는 자동증가를 해준다.*/
jumin_no char(14) not null, /*중간에 -가 있으니.....*/ /*똑같으면 안되니까 unique로 친다.*/
age int not null, /*ck(0이상만 가능하게!)*/
parent_no int, /*fk(parent_db의 no컬럼을 참조하게 만든다.)*/
constraint pk_child_tb primary key(no), /*제약조건의 이름은 pk_child_tb이구요, no을 primary key로 만드는 거에요! */
constraint uk_child_jumin_no unique(jumin_no), /*또 다른 제약조건을 만든다.*/
constraint ck_child_tb_age check(age > 0), -- check(age between 10 and 50)
constraint fk_child_tb_parent_tb foreign key(parent_no) references parent_tb(no) 
/*parent_no를 foreign key로 설정을 하는데, 이는 parent_tb의 no을 references로 한다.*/
);
-- 제약조건이름:타입의 약자를 거시기한다. 이 때, 이름만 봐도 뭐하는지 알 수 있게 이름을 정하는 것이 국룰이다.


/*테이블을 보여줘!*/
show tables;

/*child_tb에 대한 정보들을 insert 한다.*/
insert into child_tb(jumin_no,age,parent_no) values('851207-1234567',38,100);
insert into child_tb(jumin_no,age,parent_no) values('851207-1231567',38,100);
insert into child_tb(no,jumin_no,age,parent_no) values(100,'851207-1234568',40,100); /*근데 이런 식으로 하는건 안좋다.*/
select * from child_tb;

/*테이블 삭제!!
삭제를 하고 나면, 진짜로 정보가 없어 진 것을 볼 수 있다.
근데 foreign key 등에 연관이 되어 있는 것은 지우려고 해도 지울 수 없는 경우가 있다.
*/
desc child_tb; /*tb에 대한 정보를 알 수 있다.*/
drop table child_tb;
drop table parent_tb; /*참조하는 자식 테이블이 있기 때문에 삭제를 하지 못한다.*/
/*근데 이 drop이 에러가 날 수 있는 것은, 다른 테이블에서 이놈을 참조하는 놈이 있을 때 에러가 날 수 있다. 
그럴 때는 set FOREIGN_KEY_CHECKS=0;와 같이 코드를 작성한다.*/


/*실제로 정보들을 insert 한다.*/
insert into parent_tb values(100,'홍길동','2022-10-10','a@a.com','M');
insert into parent_tb (no,name,email,gender) values(200,'김길동','b@b.com','M');

/*정보를 한번 조회해볼까? 조회를 해 본다면 join_date에서 default값을 정했기 때문에 날짜가 자동으로 삽입된 것을 볼 수 있다.*/
select * from parent_tb;

/*이거를 실행을 시키면 많은 것들을 볼 수 있다! 주로 constraint에 관한 것이다.*/
select * from information_schema.table_constraints;


-- TODO
-- 출판사(publisher) 테이블
-- 컬럼명                 | 데이터타입        | 제약조건        
-- publisher_no 		| int  			| primary key, 자동증가
-- publisher_name 		| varchar(50)   | not null 
-- publisher_address 	| varchar(100)  |
-- publisher_tel 		| varchar(20)   | not null


-- 책(book) 테이블
-- 컬럼명 		   | 데이터타입            | 제약 조건         |기타 
-- isbn 		   | varchar(13),       | primary key
-- title 		   | varchar(50) 		| not null 
-- author 		   | varchar(50) 		| not null 
-- page 		   | int 		 		| not null, check key-0이상값
-- price 		   | int 		 		| not null, check key-0이상값 
-- publish_date   | timestamp 			| not null, default-current_timestamp(등록시점 일시)
-- publisher_no   | int 		        | not null, Foreign key-publisher --publisher의 no을 참조하기 위해!!



create table publisher(
publisher_no int primary key auto_increment,
publisher_name varchar(50) not null,
publisher_address varchar(100),
publisher_tel varchar(20) not null
);

create table book(
 isbn varchar(13) primary key, /*isbn은 세계의 책들을 관리하는 코드이다.*/
title varchar(50) not null, 
author varchar(50) not null,
page int not null, check (page>0),
price int not null, check (price>0),
publish_date timestamp not null default current_timestamp,
publisher_no int not null, 
constraint fk foreign key(publisher_no) references publisher(publisher_no)
 /*constraint를 통해 foreign key를 설정한다.*/
);

/*자, 만들었으면 조회를 해야지?*/
show tables;
select * from book;
select * from publisher;

/*조회를 하는 것도 만들었으면 drop을 하는 것도!!*/
drop table if exists book; /*if exists = 있으면 지우고 없으면 말아라!*/
drop table if exists publisher;

/* ************************************************************************************
ALTER : 테이블 수정

추가는 add 이고 수정은 modify이다.

컬럼 관련 수정

- 컬럼 추가
  ALTER TABLE 테이블이름 ADD COLUMN 추가할 컬럼설정 [,ADD COLUMN 추가할 컬럼설정]
  
- 컬럼 수정
  ALTER TABLE 테이블이름 MODIFY COLUMN 수정할컬럼명 타입 null설정 [, MODIFY COLUMN 수정할컬럼명 타입 null설정]
	- 숫자/문자열 컬럼은 크기를 늘릴 수 있다.
		- 크기를 줄일 수 있는 경우 : 열에 값이 없거나 모든 값이 줄이려는 크기보다 작은 경우
	- 데이터가 모두 NULL이면 데이터타입을 변경할 수 있다. (단 CHAR<->VARCHAR 는 가능.)
	- null 설정을 생략하면 nullable이 된다.
    - 근데 솔직히 크기를 줄일 수 있는 경우는 그렇게 많지는 않다.



- 컬럼 삭제	
  ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름 [CASCADE CONSTRAINTS] -- cascade constraints를 optional하게 넣을 수 있다.
    - CASCADE CONSTRAINTS : 삭제하는 컬럼이 Primary Key인 경우 그 컬럼을 참조하는 다른 테이블의 Foreign key 설정을 모두 삭제한다.
	- 한번에 하나의 컬럼만 삭제 가능.
	
  ALTER TABLE 테이블이름 SET UNUSED (컬럼명 [, ..]) -- 괄호 안의 컬럼들을 쓰지 않겠다고 하는 것이다. 물리적으로 삭제하는 것이 아니라 걍 안쓰는거다.
  ALTER TABLE 테이블이름 DROP UNUSED COLUMNS
	- SET UNUSED 설정시 컬럼을 바로 삭제하지 않고 삭제 표시를 한다. 
	- 설정된 컬럼은 사용할 수 없으나 실제 디스크에는 저장되 있다. 그래서 속도가 빠르다.
	- DROP UNUSED COLUMNS 로 SET UNUSED된 컬럼을 디스크에서 삭제한다. 

- 컬럼 이름 바꾸기
  ALTER TABLE 테이블이름 RENAME COLUMN 원래이름 TO 바꿀이름;

**************************************************************************************  
제약 조건 관련 수정
-제약조건 추가
  ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 설정

- 제약조건 삭제
  ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건이름
  PRIMARY KEY 제거: ALTER TABLE 테이블명 DROP PRIMARY KEY 
	- CASECADE : 제거하는 Primary Key를 Foreign key 가진 다른 테이블의 Foreign key 설정을 모두 삭제한다.

- NOT NULL <-> NULL 변환은 컬럼 수정을 통해 한다.
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 타입 NOT NULL  
   - ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 NULL
************************************************************************************ */

/*실습!!*/
use hr_join;
-- customers/orders 테이블의 구조만 복사한 테이블 생성(not null을 제외한 제약 조건은 copy가 안됨)
show tables;

/*customers에서 모든 것을 복사해서 cust를 만듬.*/
create table cust
as 
select * from customers;
/*select * from customers where 1 = 0와 같이 쓴다면, 구조 '만' 카피한다.*/

show tables;
desc cust; /*자세한 조건을 조회시킨다.*/
select * from cust; 


select * from information_schema.table_constraints where table_name = 'customers';
/*근데 위의 것을 cust/customers를 비교를 하면, cust에는 primary가 적용이 안된다.
이는 데이터를 복사를 해도 제약 조건은 복사가 되지 않음을 알게 해준다.*/


/*또 다른 예시*/
drop table if exists orders_copy;
create table orders_copy
as 
select * from orders where 1= 0;

show tables;
desc cust;



-- 제약조건 추가



-- 컬럼 추가




-- 컬럼 수정



-- 컬럼 이름 변경


-- 컬럼 삭제


/*복습 철저!!*/
-- TODO: emp 테이블의 구조만 복사해서 emp2를 생성 (이후 TODO 문제들은 emp2 테이블을 가지고 한다.)
create table emp2
as
select * from emp where 1= 0;

desc emp2;
-- TODO: gender 컬럼을 추가: type char(1)
alter table emp2 add column gender char(1); /*어떤 제약조건도 붙지 않는다. 물론, 1번 만들었는데 또 만들면 안된다.*/



-- TODO: email, jumin_num 컬럼 추가 
--   email varchar(100),  not null  
--   jumin_num char(14),  null 허용 unique


/*add column을 여러번 해도 좋다.*/
alter table emp2 add column email varchar(100) not null,
add column jumin_num char(14) unique;

desc emp2;



/*그냥 alter,add와 constraint 구문을 합쳤다고 보면 된다.*/
-- TODO: emp_id 를 primary key 로 변경
alter table emp2 add constraint pk_emp2 primary key(emp_id);

  
  /*복습 잘하자!!*/
-- TODO: gender 컬럼의 M, F 저장하도록  제약조건 추가
alter table emp2 add constraint ch_emp2_gender check(gender in ('M','F'));

/*확인을 해봐야지? 확인을 해 본다면 잘 들어갔다는 것을 알 수 있다.*/
select * from information_schema.table_constraints;


-- TODO: salary 컬럼에 0이상의 값들만 들어가도록 제약조건 추가
alter table emp2 add constraint ch_emp2_salary check (salary>=0);
select * from information_schema.table_constraints;


-- TODO: email 컬럼에 unique 제약조건 추가.
alter table emp2 add constraint uk_emp2_email unique(email);
desc emp2; /*확이내 보면, email에 unique 값이 들어가 있음을 알 수 있다.*/


-- TODO: emp_name 의 데이터 타입을 varchar(100) 으로 변환 -- not null이기 때문에 not null을 넣어봐야 한다.
alter table emp2 modify column emp_name varchar(100) not null;
desc emp2; /*desc를 통해 보면 not null 조건을 만족함을 알 수 있다.*/


-- TODO: job_id를 not null 컬럼으로 변경

alter table emp2 modify column job_id varchar(30) not null;
desc emp2;

/*복습!! 개념이 조금 어렵다.*/
-- TODO: job_id  를 null 허용 컬럼으로 변경
alter table emp2 modify column job_id varchar(30) null;
desc emp2;



/*drop constraint에 관한 내용을 잘 파악하자.*/
-- TODO: 위에서 지정한 uk_emp_email 제약 조건을 제거
alter table emp2 drop constraint uk_emp2_email;
desc emp2;

/*확인해보자! 진짜로 uk_emp2_email가 없지?*/
select * from information_schema.table_constraints
where table_name ='emp2';

-- TODO: 위에서 지정한 emp_salary_ck 제약 조건을 제거
alter table emp2 drop constraint ch_emp2_salary;

-- TODO: gender 컬럼제거(이건 쉽다.)
alter table emp2 drop column gender;
desc emp2;
-- TODO: email 컬럼 제거

alter table emp2 drop column email;
desc emp2;



