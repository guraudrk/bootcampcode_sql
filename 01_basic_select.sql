/* *************************************
SQL: 대소문자 구분 안함. (값은 구분)

SELECT 기본 구문 - 연산자, 컬럼 별칭
select 컬럼명, 컬럼명 [, .....]  => 조회할 컬럼 지정. *: 모든 컬럼
from   테이블명                 => 조회할 테이블 지정.



*************************************** */
use hr;
-- EMP 테이블의 모든 컬럼의 모든 항목을 조회.



-- EMP 테이블의 직원 ID(emp_id), 직원 이름(emp_name), 업무(job) 컬럼의 값을 조회.
select emp_id,emp_name,job from emp;

-- EMP 테이블의 업무(job) 어떤 값들로 구성되었는지 조회. - 동일한 값은 하나씩만 조회되도록 처리.
select distinct job -- dept_name 
from emp; /*distinct라고 하면 중복된 놈을 거른다.*/

-- EMP 테이블의 부서명(dept_name)이 어떤 값들로 구성되었는지 조회 - 동일한 값은 하나씩만 조회되도록 처리.
select distinct dept_name
from emp; /*데이터의 양이 역시 적다.*/


-- EMP 테이블에서 emp_id는 직원ID, emp_name은 직원이름, hire_date는 입사일, salary는 급여, dept_name은 소속부서 별칭으로 조회한다.


/*아래와 같은 구문을 잘 보자.*/
select emp_id as '직원ID',emp_name as "직원 이름",hire_date as 입사일,salary as 급여,dept_name as 소속부서
/*별칭을 쓸 때 띄어쓰기를 쓰고 싶다면 ""로 덮는다.*/
from emp;



--  별칭에 컬럼명으로 못사용하는 문자(공백)를 쓸 경우 " "로 감싼다. 


/* **************************************
연산자 
- 산술 연산자 
	- +, -, *, /, %, mod, div
- date/time/datetime 
    - +, - : 마지막 항목(date:일, time: 초, datetime: 초)의 값을 +/- => 계산 결과가 정수형으로 반환된다. (ex:20100102)
- 여러개 값을 합쳐 문자열로 반환
	- concat(값, 값, ...) 
- 피연산자가 null인경우 결과는 null
- 연산은 그 컬럼의 모든 값들에 일률적으로 적용된다.
- 같은 컬럼을 여러번 조회할 수 있다.
************************************** */
select 10 + 5,10-5,10*5,10/4; /*직접 결과를 봐봐라. 상당히 흥미로울 것이다.*/
select 10 div 4; -- 몫 나누기
select 10 % 4, 10 mod 4; -- 나머지

/*concat의 활용----서로 붙이는 것이다.*/
-- select concat('a','b','c','d') /*abcd를 서로 붙인다.*/
select concat('30','살');

select concat('부자','이장한') as '자명한 사실';

/* 함 정 카 드
null이라는 것의 의미가 '모르는 값'이기 때문에, 
10+null 같은 경우의 결과는 걍 안나온다ㅋㅋㅋㅋㅋㅋㅋㅋ*/

select 10 * 5 + 2 + 10 + null;


-- EMP 테이블에서 직원의 이름(emp_name), 급여(salary) 그리고  급여 + 1000 한 값을 조회.
-- 아래와 같이 코드를 짜면 결과가 하나하나 다 적용이 된다.
select emp_name,salary,salary+1000 /**/
from emp;


--  TODO: EMP 테이블의 업무(job)이 어떤 값들로 구성되었는지 조회 - 동일한 값은 하나씩만 조회되도록 처리
select distinct job from emp;

-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션_PCT(comm_pct), 급여에 커미션_PCT를 곱한 값을 조회.
select emp_id,emp_name,salary,comm_pct,salary*comm_pct
from emp;

-- TODO:  EMP 테이블에서 급여(salary)을 연봉으로 조회. (곱하기 12)
select salary*12 as 연봉 from emp;

-- TODO: EMP 테이블에서 직원이름(emp_name)과 급여(salary)을 조회. 급여 앞에 $를 붙여 조회.
select emp_name,concat("$",salary) as 급여
from emp;
/*concat 메소드를 써야 문제가 잘 해결이 된다. 명심!!!*/


/* *************************************
where 절을 이용한 행 선택 
************************************* */
-- EMP 테이블에서 직원_ID(emp_id)가 110인 직원의 이름(emp_name)과 부서명(dept_name)을 조회

 
-- EMP 테이블에서 'Sales' 부서에 속하지 않은 직원들의 ID(emp_id), 이름(emp_name),  부서명(dept_name)을 조회.
/*이런 문제들은 복습을 잘 해보자. where절은 꽤 생각을 해야 하는 문제이다.
=과 !=의 차이를 잘 보도록 하자.
또한, 이 꺾쇠(<>)도 별 차이가 없다.*/
select emp_id,emp_name,dept_name
from emp
-- where dept_name != 'Sales';
where dept_name <> 'Sales';

-- EMP 테이블에서 급여(salary)가 $10,000를 초과인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
-- 크기 비교, ==와 != 등의 것들은 다른 프로그래밍 단어와 상당히 비슷하다.
select emp_id,emp_name,salary
from emp
where salary > 10000;

 
-- EMP 테이블에서 커미션비율(comm_pct)이 0.2~0.3 사이인 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
/*'이상'과 '이하'이다.
쿼리문에서도 and를 쓸 수 있다는 점을 잘 파악하도록 하자.*/
select emp_id,emp_name,comm_pct
from emp
where 0.2<=comm_pct and comm_pct<=0.3;
-- where comm_pct between 0.2 and 0.3;
/*between 구문을 쓰는 것도 좋다!!*/





-- EMP 테이블에서 커미션을 받는 직원들 중 커미션비율(comm_pct)이 0.2~0.3 사이가 아닌 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
select emp_id,emp_name,comm_pct
from emp
where comm_pct not between 0.2 and 0.3; 
# comm_pct < 0.2 or comm_pct > 0.3


-- EMP 테이블에서 업무(job)가 'IT_PROG' 거나 'ST_MAN' 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.
select emp_id,emp_name,job
from emp
where job='IT_PROG' or job='ST_MAN';
-- where job in ('IT_PROG','ST_MAN') 
/*in 구문을 쓰는 것도 간단하고 좋다.*/



-- EMP 테이블에서 업무(job)가 'IT_PROG' 나 'ST_MAN' 가 아닌 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.

select emp_id,emp_name,job
from emp
where job <> 'IT_PROG'
and job <>'ST_MAN';

-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하는 직원의  ID(emp_id), 이름(emp_name)을 조회.
select emp_id,emp_name
from emp
where emp_name like 'S%';
/*S다음에 뭔가가 나와야 한다는 것을 보여주는 것이 바로 %이다.*/
/*%:0개 이상의 모든 글자이다.*/


-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하지 않는 직원의  ID(emp_id), 이름(emp_name)을 조회
select emp_id,emp_name
from emp
where emp_name not like 'S%';

-- EMP 테이블에서 직원 이름(emp_name)이 en으로 끝나는 직원의  ID(emp_id), 이름(emp_name)을 조회
select emp_id,emp_name
from emp
where emp_name like '%en';
/*%와 like의 쓰임새에 대해 잘 생각해 볼 수 있는 구문이다.*/


-- EMP 테이블에서 직원 이름(emp_name)의 세 번째 문자가 “e”인 모든 사원의 이름을 조회
select emp_id, emp_name
from emp
where emp_name like '__e%';
/*_는 글자 1개를 표현해준다.*/

-- EMP 테이블에서 직원의 이름에 '%' 가 들어가는 직원의 ID(emp_id), 직원이름(emp_name) 조회
-- 패턴문자를 조회조건에서 사용해야 하는 경우 escape 구문을 이용해 패턴문자를 검색문자로 표시하는 특수문자를 지정한다.
select emp_id, emp_name
from emp
where emp_name like '%#%%' escape '#';
/*위와 같은 문제는 하나의 %를 패턴문자가 아닌 그냥 문자로 표현하는 것을 보여줘야 한다.*/





-- EMP 테이블에서 부서명(dept_name)이 null인 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,emp_name,dept_name 
from emp
where dept_name is null;


-- 부서명(dept_name) 이 NULL이 아닌 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name) 조회
select emp_id,emp_name,dept_name 
from emp
where dept_name is not null;

-- TODO: EMP 테이블에서 업무(job)가 'IT_PROG'인 직원들의 모든 컬럼의 데이터를 조회. 
select *
from emp
where job='IT_PROG';

-- TODO: EMP 테이블에서 업무(job)가 'IT_PROG'가 아닌 직원들의 모든 컬럼의 데이터를 조회. 
select *
from emp
where job !='IT_PROG';

-- TODO: EMP 테이블에서 이름(emp_name)이 'Peter'인 직원들의 모든 컬럼의 데이터를 조회
select * from emp where emp_name='Peter';

-- TODO: EMP 테이블에서 급여(salary)가 $10,000 이상인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,emp_name,salary from emp where salary>10000;

-- TODO: EMP 테이블에서 급여(salary)가 $3,000 미만인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select mp_id,emp_name,salary
from emp
where salary<3000;

-- TODO: EMP 테이블에서 급여(salary)가 $3,000 이하인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select mp_id,emp_name,salary
from emp
where salary<=3000;

-- TODO: 급여(salary)가 $4,000에서 $8,000 사이에 포함된 직원들의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select mp_id,emp_name,salary
from emp
where salary>4000 and salary<8000;
/*between을 이용해서 쓸 수도 있다.*/

-- TODO: 급여(salary)가 $4,000에서 $8,000 사이에 포함되지 않는 모든 직원들의  ID(emp_id), 이름(emp_name), 급여(salary)를 표시
select emp_id,emp_name,salary
from emp
where salary not between 4000 and 8000;



-- TODO: EMP 테이블에서 2007년 이후 입사한 직원들의  ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
-- 참고: date/datatime에서 년도만 추출: year(값). ex) year('2020-10-10') => 2020
select emp_id,emp_name,hire_date
from emp
where year(hire_date)>=2007;
/*select year(now()) 뭐 이렇게 하면 올해의 연도를 뽑아낼 수 있다.*/
-- TODO: EMP 테이블에서 2004년에 입사한 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.


-- TODO: EMP 테이블에서 2005년 ~ 2007년 사이에 입사(hire_date)한 직원들의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 조회.


-- TODO: EMP 테이블에서 직원의 ID(emp_id)가 110, 120, 130 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회


-- TODO: EMP 테이블에서 부서(dept_name)가 'IT', 'Finance', 'Marketing' 인 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.


-- TODO: EMP 테이블에서 'Sales' 와 'IT', 'Shipping' 부서(dept_name)가 아닌 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.


-- TODO EMP 테이블에서 업무(job)에 'SA'가 들어간 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회


-- TODO: EMP 테이블에서 업무(job)가 'MAN'로 끝나는 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회


-- TODO. EMP 테이블에서 커미션이 없는(comm_pct가 null인)  모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회


-- TODO: EMP 테이블에서 커미션을 받는 모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회


-- TODO: EMP 테이블에서 관리자 ID(mgr_id)가 없는(상사가 없는) 직원의 ID(emp_id), 이름(emp_name), 업무(job), 소속부서(dept_name)를 조회


-- TODO : EMP 테이블에서 연봉(salary * 12) 이 200,000 이상인 직원들의 모든 정보를 조회.



/* *************************************
 WHERE 조건이 여러개인 경우
 AND OR
 
 and 연산이 있고 or 연산이 있다면, and 연산을 먼저 한다.
 그리고, 중간중간에 적당히 묶어주면 결과가 다를 수 있다.
 예컨데, or를 먼저 실행시키고 싶다면 or에 괄호를 묶어줘야 한다.
 
 참 and 참 -> 참: 조회 결과 행
 거짓 or 거짓 -> 거짓: 조회 결과 행이 아님.
 
 연산 우선순위 : and > or
 
 where 조건1 and 조건2 or 조건3
 1. 조건 1 and 조건2
 2. 1결과 or 조건3
 
 or를 먼저 하려면 where 조건1 and (조건2 or 조건3)
 **************************************/
  
--  EMP 테이블에서 업무(job)가 'SA_REP' 이고 급여(salary)가 $9,000인 직원의 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select emp_id,emp_name,job,salary
from emp
where job = 'SA_REP'
and salary=9000;


--  EMP 테이블에서 업무(job)가 'FI_ACCOUNT' 거나 급여(salary)가 $8,000 이상인 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select emp_id,emp_name,job,salary
from emp
where job = 'FI_ACCOUNT'
or salary >=8000;

-- TODO: EMP 테이블에서 부서(dept_name)가 'Sales'이고 업무(job)가 'SA_MAN'이고 급여가 $13,000 이하인 
-- 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary), 부서(dept_name)를 조회


-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서(dept_name)가 'Shipping' 이고 2005년이후 입사한 
-- 직원들의  ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date),부서(dept_name)를 조회



-- TODO: EMP 테이블에서 입사년도가 2004년인 직원들과 (입사년도와 상관없이) 급여가 $20,000 이상인 
--  직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date), 급여(salary)를 조회.



-- TODO : EMP 테이블에서, 부서이름(dept_name)이  'Executive'나 'Shipping' 이면서 급여(salary)가 6000 이상인 사원의 모든 정보 조회. 


-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서이름(dept_name)이 'Marketing' 이거나 'Sales'인 
-- 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)를 조회



-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중 급여(salary)가 $10,000 이하이 거나 2008년 이후 입사한 
--  직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date), 급여(salary)를 조회



/* *******************************************************************
order by를 이용한 정렬
- order by절은 select문의 마지막에 온다.
- order by 정렬기준컬럼 정렬방식 [, ...]
    - 정렬기준컬럼 지정 단위: 컬럼이름, 컬럼의순번(select절의 선언 순서)
     select salary, hire_date from emp ...
	 에서 salary 컬럼 기준 정렬을 설정할 경우. 
     order by salary 또는 1
    - 정렬방식
        - ASC : 오름차순, 기본방식(생략가능)
        - DESC : 내림차순
		
문자열 오름차순 : 숫자 -> 대문자 -> 소문자 -> 한글     
Date 오름차순 : 과거 -> 미래
null 오름차순 : null이 먼저 나온다.

ex)
order by salary asc, emp_id desc
- salary로 전체 정렬을 하고 salary가 같은 행은 emp_id로 정렬.
******************************************************************* */

--  직원들의 전체 정보를 직원 ID(emp_id)가 큰 순서대로 정렬해 조회
select * from emp
order by emp_id desc;
/*이렇게 정렬을 하면 직원 id가 큰 순서대로 정렬을 할 수 있다!*/


--  직원들의 id(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 
--  업무(job) 순서대로 (A -> Z) 조회하고 업무(job)가 같은 직원들은 급여(salary)가 높은 순서대로 2차 정렬해서 조회.

/*2차 정렬을 해서 조회하는 것이 매우 중요하다.*/

select emp_id,emp_name,job,salary
from emp
order by job asc,salary desc,emp_name desc; /*asc는 디폴트이기 때문에 생략이 가능하다.*/
/*job이 1순위이고 salary가 2순위이다. 그 다음 emp_name이 3차정렬이다.*/
/*각각을 인덱스로 거시기를 해도 좋다.(예:3,4)*/




-- 부서명을 부서명(dept_name)의 오름차순으로 정렬해 조회하시오.
select dept_name
from emp
order by dept_name;
/*null부터 볼 수 있다는 사실을 잘 알아두자.*/



-- TODO: 급여(salary)가 $5,000을 넘는 직원의 ID(emp_id), 이름(emp_name), 급여(salary)를 급여가 높은 순서부터 조회



-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 입사일(hire_date) 순서로 조회.


-- TODO: EMP 테이블에서 ID(emp_id), 이름(emp_name), 급여(salary), 입사일(hire_date)을 
-- 급여(salary) 오름차순으로 정렬하고 급여(salary)가 같은 경우는 먼저 입사한(hire_date) 순서로 정렬.




/*todo들의 해답은 todo-20230831에 있다.*/