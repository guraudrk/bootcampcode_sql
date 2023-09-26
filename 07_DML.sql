/* *********************************************************************
INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 사실 이거는 설명을 보는 것 보다는 예시 코드를 한번 보면 된다.
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.
   

 - 조회결과(select)를 INSERT 하기 (subquery 이용) ----------------위의 구문에서 values 대신 subquery를 넣는 것이다.
   - INSERT INTO 테이블명 (컬럼 [, 컬럼])  SELECT 구문
	 - INSERT할 컬럼과 조회한(subquery) 컬럼의 개수와 타입이 맞아야 한다.
	 - 모든 컬럼에 다 넣을 경우 컬럼 설정은 생략할 수 있다.
************************************************************************ */

/*
dml - insert,delete,update 등이 있다.
dql - select 등이 있다.

update는 데이터의 값을 바꾸는 것이다.
select는 데이터의 값을 알려달라는 것이다.

이러한 일련의 데이터 관리 과정을 crud라고 한다.

근데 select 구절은 구절 자체가 복잡하다.
select을 제대로 쓰기 위해서는 select from where group by having 등을 써야 한다.
*/

/*값을 집어 넣는 예시*/
use hr_join;
insert into emp(emp_id,emp_name,job_id,mgr_id,hire_date,salary,comm_pct,dept_id)
values('500','홍길동','AC_ACCOUNT',100,'2023-09-07',5000.23,null,100);
/*insert가 완료가 되면 관련 메세지가 나온다.*/

/*어떤 값은 넣고 어떤 값은 넣지 않으려면 이렇게 insert 할 항목들을 다 설정하는 것이 좋다.*/
insert into emp(emp_id,emp_name,mgr_id,hire_date,salary)
values (502,'박직원',102,'2023-08-10',2500);
/*근데 insert를 1번 했는데 한번 더 하려고 하면 분명히 오류가 난다.*/


select * from emp
order by emp_id desc;
/*잘 보면 '홍길동'이 데이터에 추가가 된 것을 볼 수 있다.*/


/*테이블 만들기-------emp 중에서 일부만 지정을 한다.
-- 직원들 중 10,20,30 번 부서의 소속된 직원들의 id, 이름, 급여를 저장하는 테이블이다.
*/
create table emp_copy(
emp_id int,
emp_name varchar(20),
salary decimal(7,2)
);


/*테이블을 만들었으니, 기존 데이터인 emp의 정보를 조회해보자.*/
select emp_id,emp_name,salary
from emp
where dept_id in (10,20,30)
order by emp_id;
/*근데 이렇게 일일이 하면 매우 귀찮을 것이다.*/


/*그래서 insert에도 subquery를 쓴다. 근데 자주 쓰이는 것은 아니다.*/
insert into emp_copy(emp_id,emp_name,salary)
select emp_id,emp_name,salary
from emp
where dept_id in (10,20,30)
order by emp_id;

/*emp_copy에 데이터가 들어간 것을 알 수 있다.*/
select * from emp_copy;

-- 에러나는 것
insert into emp(emp_id,emp_name,mgr_id,hire_date)
values (502,'박직원',102,'2023-08-10'); -- not null 컬럼에 값을 안넣는 경우. 이런 경우에는 에러가 난다.

insert into emp(emp_id,emp_name,mgr_id,hire_date)
values (503,'박직원',700,'2023-08-10',2500);
-- mgr_id는 emp.emp_id를 참조하는 fk 컬럼. emp.emp_id에 없는 값을 넣으려고 해서 에러가 났다.


insert into emp(emp_id,emp_name,mgr_id,hire_date)
values (503,'박직원',700,'2023-08-10',2500000);
/*salary의 data type이 decimal(7,2) xxxxx.00 이므로, 숫자가 6자 이상이면 초과가 된다.*/




-- TODO 부서별 직원의 급여에 대한 통계 테이블 생성. 
-- emp의 다음 조회결과를 insert. 집계: 합계, 평균, 최대, 최소, 분산, 표준편차
/*테이블 만들기*/
create table salary_stat(
dept_id int,
salary_sum decimal(15,2),
salary_avg decimal(10,2),
salary_max decimal(10,2),
salary_min decimal(10,2),
salary_var decimal(10,2),
salary_std decimal(10,2)
);

/*밑의 insert를 다 하고, select를 다시 한번 해보자.*/
select * from salary_stat;

insert into salary_stat
select dept_id,sum(salary),round(avg(salary),2),max(salary),min(salary),round(variance(salary),2),round(stddev(salary),2)
from emp
group by dept_id;


-- 여러 행을 삭제 또는 수정하는 것을 막거나, 해제하는 설정
-- Edit > Preferences > SQL Editor 에서 맨 아래의 부분을 체크 해제하면, 한번에 여러 데이터를 업데이트 하는 것을 할 수 있다.

/*

auto commit 설정을 해제.
commit:insert,delete,update된 데이터를 실제 물리 디비에 영구적으로 적용한다.
그러므로 commit을 하지 않으면 물리 디비에 영구적으로 적용되지가 않는다.


*/ 

select @@autocommit; 
/*1이 나오면 autocommit -insert/update/delete 쿼리가 실행되고 바로 적용된다.
0이 나오면 manual commit이다.
이는 i/u/d 쿼리가 실행이 되어도 바로 적용하지 않고 commit 명령을 수동으로 실행해야 적용된다.*/

/*commit은 적용을 하는 것이고 rollback은 마지막 commit 상태로 복원하는 것이다.*/

SET AUTOCOMMIT = 1;
select @@autocommit; /*윗줄을 실행시키고 바로 이 줄을 실행시키면, 값이 0으로 바뀜을 알 수 있다.*/

use hr;


/*이 코드 부분이 잘 안된다. 나중에 잘 해보자.*/
select * from emp;
delete from emp where dept_name = 'Executive';

rollback; /*rollback을 하면 다시 살아난다.*/




/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */
set autocommit = 0;
select @@autocommit;

use hr_join;
/*예시가 그렇게 어렵지는 않다.*/
-- 직원 ID가 200인 직원의 급여를 5000으로 변경

update emp /*업데이트할 셋*/
set salary = 5000
where emp_id =200;

select * from emp where emp_id=200; /*emp_id가 200인 놈만 salary가 5000이 되었다.*/
commit; /*이렇게 commit을 하면 rollback이 안된다.*/


-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
update emp 
set salary = 1.1*salary /*만약 where절이 없다면, emp_id와 상관없이 모든 절에 다 적용이 된다.*/
where emp_id=200;

select * from emp where emp_id=200;/*조회를 해 보면, salary가 10퍼센트 올라갔음을 알 수 있다.*/
commit; /*모든 것을 다 끝내면 commit을 한다.*/


-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
update emp
set comm_pct=0.2, salary=salary+3000, mgr_id=100
where dept_id=100;

select * from emp where dept_id=100; /*값을 출력해 보면 변경이 잘 되었음을 알 수 있다.*/
/*처리가 잘 되었음을 알았으면 commit을 하자.*/
commit;


-- 부서 ID가 100인 직원의 커미션 비율을 null 로 변경.
update emp 
set comm_pct=null
where dept_id=100;

select * from emp where dept_id=100;
/*여기서도. 변경이 잘 되었다면 commit을 한다.*/
commit;



-- TODO: 부서 ID가 100인 직원들의 급여를 100% 인상

update emp
set salary = salary*2
where dept_id=100;
rollback;
select * from emp where dept_id=100;
commit;

-- TODO: IT 부서의 직원들의 급여를 3배 인상
update emp
set salary = salary*3
where dept_id = (select *  from dept where dept_name='IT'); /*서브쿼리를 이렇게 쓸 수 있다. 참고바람!*/

select * from dept where dept_name='IT';
/*조회하는 쿼리문이다.*/
select dept_id from dept where dept_name='IT';


-- TODO: EMP 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.
update emp
set mgr_id = null,
	hire_date = curdate(),
    comm_pct=0.5;
    
select * from emp; /*데이터가 다 바뀐 것을 알 수 있다.*/


/* *********************************************************************
DELETE : 테이블의 행을 삭제
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
   
   
   아, 그리고, 삭제에 대한 설정들 (cascade 등)을 잘 처리하는 것이 좋다.
************************************************************************ */


-- 부서테이블에서 부서_ID가 200인 부서 삭제
delete from dept where dept_id =200;
select * from dept;
rollback; /*이렇게 하면 다시 살아난다.*/
select * from dept where dept_id =200;
commit;
/*사실, delete 자체가 자주 쓰이는 것은 아니다.*/


use hr_join;
-- 부서테이블에서 부서_ID가 10인 부서 삭제
delete from dept where dept_id=10;
select * from dept where dept_id=10;

-- TODO: 부서 ID가 없는 직원들을 삭제
delete from emp where dept_id is null;

/*데이터 조회.*/
select * from emp where dept_id is null; /*위의 delete문을 한 뒤 조회하면 데이터가 잘 안나온다.*/


-- TODO: 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제. 

delete from emp where job_id = 'SA_MAN' and salary<12000;

/*일단 데이터 조회. 위의 구문을 실행 하고 나면 당연히 삭제가 되어 있다.*/
select * from emp where job_id = 'SA_MAN' and salary<12000;

-- TODO: comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제

select * from emp where comm_pct is null and job_id='IT_PROG';





/*테이블의 데이터를 모두 삭제*/
truncate table emp; -- 이걸 하고 나서 하면 다시 rollback되지 않는다.

delete from emp;
select count(*) from emp;
rollback;


