/* **************************************************************************
집계(Aggregation) 함수와 GROUP BY, HAVING
************************************************************************** */
use hr;
/* ******************************************************************************************
집계함수, 그룹함수, 다중행 함수
- 인수(argument)는 컬럼.
  - sum(): 전체합계
  - avg(): 평균
  - min(): 최소값
  - max(): 최대값
  - stddev(): 표준편차
  - variance(): 분산
  - count(): 개수
        - 인수: 
            - 컬럼명: null을 제외한 값들의 개수.
            -  *: 총 행수 - null과 관계 없이 센다.
  - count(distinct 컬럼명): 고유값의 개수.
  
- count(*) 를 제외한 모든 집계함수들은 null을 제외하고 집계한다. 
	- (avg, stddev, variance는 주의)
	-avg(), variance(), stddev()은 전체 개수가 아니라 null을 제외한 값들의 평균, 분산, 표준편차값이 된다.=>avg(ifnull(컬럼, 0))
- 문자타입/일시타입: max(), min(), count()에만 사용가능
	- 문자열 컬럼의 max(): 사전식 배열에서 가장 마지막 문자열, min()은 첫번째 문자열. 
	- 일시타입 컬럼은 오래된 값일 수록 작은 값이다.

******************************************************************************************* */

-- EMP 테이블에서 급여(salary)의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 총직원수를 조회 
select sum(salary),avg(salary),min(salary),max(salary), stddev(salary), variance(salary),count(emp_id)
from emp;


-- EMP 테이블에서 가장 최근 입사일(hire_date)과 가장 오래된 입사일을 조회
select max(hire_date),min(hire_date)
from emp;


-- EMP 테이블의 부서(dept_name) 의 개수를 조회
/*distinct의 사용법을 잘 보도록 하자.*/
select count(distinct dept_name) as '부서의 개수'
from emp;

-- EMP 테이블에서 job 종류의 개수 조회
select count(distinct job) as '직업의 종류'
from emp;

select count(emp_id) from emp;

-- TODO:  커미션 비율(comm_pct)이 있는 직원의 수를 조회
select count(comm_pct) as '커미션 비율이 있는 직원 수'
from emp;
/*이렇게 하면 null값은 뺀다.*/


-- TODO: 커미션 비율(comm_pct)이 없는 직원의 수를 조회
select count(emp_id)-count(comm_pct) as '커미션 비율이 없는 직원 수'
from emp;
/*count(emp_id)대신 *을 써도 된다.*/


/*다른 해결 방법*/
select count(ifnull(comm_pct,1)) /*comm_pct 부분이 null이라면 그것을 1로 바꾼다.*/
from emp
where comm_pct is null;

-- TODO: 가장 큰 커미션비율(comm_pct)과 과 가장 적은 커미션비율을 조회
select max(comm_pct),min(comm_pct)
from emp;

-- TODO:  커미션 비율(comm_pct)의 평균을 조회. 소수점 이하 2자리까지 출력
select round(avg(comm_pct),2)from emp;

-- TODO: 직원 이름(emp_name) 중 사전식으로 정렬할때 가장 나중에 위치할 이름을 조회.
select max(emp_name) from emp;

-- TODO: 급여(salary)에서 최고 급여액과 최저 급여액의 차액을 출력
select max(salary)-min(salary) from emp;
-- TODO: 가장 긴 이름(emp_name)이 몇글자 인지 조회.
select max(char_length(emp_name)) as '가장 긴 이름' from emp;

-- TODO: EMP 테이블의 업무(job) 종류가 몇개 있는 조회. 고유값들의 개수
select count(distinct job) as '테이블의 업무의 종류' from emp;

-- TODO: EMP 테이블의 부서(dept_name)가 몇종류가 있는지 조회. 고유값들의 개수
select count(distinct dept_name) '테이블의 부서의 종류' from emp;


select * from emp;

/* **************
group by 절-----집계함수와 관련이 있다.
- 특정 컬럼(들)의 값별로 행들을 나누어 집계할 때 기준컬럼을 지정하는 구문.
	- 예) 업무별 급여평균. 부서-업무별 급여 합계. 성별 나이평균
- 구문: group by 컬럼명 [, 컬럼명]
	- 컬럼: 범주형 컬럼을 사용 - 부서별 급여 평균, 성별 급여 합계
	- select의 where 절 다음에 기술한다.
	- select 절에는 group by 에서 선언한 컬럼들만 집계함수와 같이 올 수 있다.
    
    
    '나눠서 계산해라, 나눠서 집계해라' 라는 것이 바로 groupby이다.
    기준은 바로 컬럼이다.
****************/

/*위의 설명은 약간 어려운 감이 있으니 예시 코드를 보면서 개념을 이해하도록 하자!*/
-- 업무(job)별 급여의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 직원수를 조회

select job,sum(salary),round(avg(salary),2) as "avg(salary)",min(salary),max(salary),round(stddev(salary)) as "stddev(salary)",variance(salary) as "variance(salary)",count(*)
from emp
group by job; /*기준은 바로 job. 이걸 기준으로 select 구문의 데이터들을 보여주세요!*/
/*중요한 것은 select 절에 job을 포함해야 한다는 것이다.*/
/*group by에 집어넣지 않은 것은 select에 넣으면 안된다.*/


-- 입사연도 별 직원들의 급여 평균. /*여기서도 year(hire_date)를 적는 것은 중요하다.*/
select year(hire_date) as "입사년도",avg(salary)
from emp
group by year(hire_date)
order by 1;
/*마지막에, order by 1을 적으면 금상첨화이다.*/


-- 부서명(dept_name) 이 'Sales'이거나 'Purchasing' 인 직원들의 업무별 (job) 직원수를 조회
select job,count(*) as '직원수' -- 3.집계
from emp -- 0.테이블선택
where dept_name in ('Sales','Purchasing') -- 1.이 조건이 True인 행을 조회한다.
group by job; -- 2.job별로 그룹을 나눈다.
/*이 예시는 where절이 들어간다. 이를 잘 숙지하도록 하자.*/



-- 부서(dept_name), 업무(job) 별 최대, 평균급여(salary)를 조회.
/*마지막에 order by도 잊지 말자.*/
select dept_name,job,max(salary),avg(salary)
from emp
group by dept_name,job
order by 1;








/*이 부분은 코드를 잘 복습하도록 하자. 정말 잘 복습을 해야 한다!!!
group by 절에도 case문이 들어갈 수 있다.*/
-- 급여(salary) 범위별 직원수를 출력. 급여 범위는 10000 미만,  10000이상 두 범주.
/*case문에서는 end as가 반드시 마지막에 나와야 한다.*/
select  case when salary<10000 then '10000달러 미만' else '10000달러 이상' end as '급여 범위',count(*) as '직원수'
from emp
group by case when salary<10000 then '10000달러 미만' else '10000달러 이상' end;








-- TODO: 부서별(dept_name) 직원수를 조회
select ifnull(dept_name,'부서 없음'),count(emp_name)
from emp
group by dept_name;



-- TODO: 업무별(job) 직원수를 조회. 직원수가 많은 것부터 정렬.
select job as '업무',count(emp_name) as '직원수'
from emp
group by job
order by count(emp_name) desc;  /*내림차순이므로 desc를 쓴다.*/


-- TODO: 부서명(dept_name), 업무(job)별 직원수, 최고급여(salary)를 조회. 부서이름으로 오름차순 정렬.
select dept_name,job,count(emp_name),max(salary)
from emp
group by dept_name,job
order by dept_name;



/*복습 필수!*/
-- TODO: EMP 테이블에서 입사연도별(hire_date) 총 급여(salary)의 합계을 조회. 
-- (급여 합계는 정수부에 자리구분자 , 를 넣고 $를 붙이시오. ex: $2,000,000)
select year(hire_date),concat('$',format(sum(salary),2)) as '급여합계'
from emp
group by year(hire_date)
order by 1;


-- TODO: 같은해 입사해서 같은 업무를 한 직원들의 평균 급여(salary)을 조회
/*group by에도 상위 분류와 하위 분류가 있음을 명심하라.*/
select year(hire_date),job,format(avg(salary),2) as '평균 급여'
from emp
group by year(hire_date),job /*group by도 상위 분류와 하위 분류 등이 있다.*/
order by 1;


-- TODO: 부서별(dept_name) 직원수 조회하는데 부서명(dept_name)이 null인 것은 제외하고 조회.
select dept_name,count(emp_name)
from emp
where dept_name is not null /*where 절을 통해 null인 것을 거르는 것이 중요하다.*/
group by dept_name
order by 1;


/*복습 필수!! 코드가 길지만 이를 잘 파악해야 한다.*/
-- TODO 급여 범위별 직원수를 출력. 급여 범위는 5000 미만, 5000이상 10000 미만, 10000이상 20000미만, 20000이상. 
-- case 문 이용
select case when salary<5000 then '5000미만'
when salary between 5000 and 9999.99999 then '5000이상 10000 미만' 
when salary between 10000 and 19999.99999 then '10000이상 20000미만'
else '20000이상' end as '급여범위',count(emp_name)
from emp
group by case when salary<5000 then '5000미만' 
when salary between 5000 and 9999.99999 then '5000이상 10000 미만' 
when salary between 10000 and 19999.99999 then '10000이상 20000미만'
else '20000이상' end;
                      
/* **************************************************************
having 절
- group by 로 나뉜 그룹을 filtering 하기 위한 조건을 정의하는 구문.
- group by 다음 order by 전에 온다.
- group by에 대한 것의 필터링이라고 보면 된다.
- group by의 기준에 어긋나는 것은 아예 집계 대상에서 빠지는 것이다.
- 먼저 group by를 통해 기준을 나누고, having을 통해 그것들을 거르는 것이다.
- 그렇기 때문에 having 절은 group by와 직간접적으로 연관이 있다고 볼 수 있다.
- 구문
    having 제약조건  
		- 연산자는 where절의 연산자를 사용한다. 
		- 피연산자는 집계함수(의 결과)
		
** where절은 행을 filtering한다.
   having절은 group by 로 묶인 그룹들을 filtering한다.
************************************************************** */

/*예시 코드들을 잘 보면서 복습을 잘 하도록 하자.*/
-- 직원수가 10 이상인 부서의 부서명(dept_name)과 직원수를 조회
select dept_name,count(*) as '직원수'  
/*group by와 having 절에서 거른 결과로 select절에서 조회한 것이다. 헛갈리지 말것!*/
from emp
group by dept_name
having count(emp_name)>=10;

-- 직원수가 10명 이상인 부서의 부서명과 그 부서 직원들의 평균 급여를 조회.
select dept_name,avg(salary) as '평균급여'  
/*group by와 having 절에서 거른 결과로 select절에서 조회한 것이다. 헛갈리지 말것!*/
from emp
group by dept_name
having count(*)>=10;

/*복습하자!*/
-- TODO: 20명 이상이 입사한 년도와 (그 해에) 입사한 직원수를 조회.
select year(hire_date),count(*)
from emp
group by year(hire_date)
having count(*)>=20;

-- TODO: 10명 이상의 직원이 담당하는 업무(job)명과 담당 직원수를 조회
select job,count(emp_name)
from emp 
group by job
having count(*)>=10 /* *대신에 emp_name 같은 것을 넣어도 된다.*/
order by 1;


/*복습 필수!!*/
-- TODO: 평균 급여가(salary) $5000 이상인 부서의 이름(dept_name)과 평균 급여(salary), 직원수를 조회
select dept_name,round(avg(salary),2),count(emp_name) as '직원수'
from emp
group by dept_name
having avg(salary)>5000;

-- TODO: 평균급여가 $5,000 이상이고 총급여가 $50,000 이상인 부서의 부서명(dept_name), 평균급여와 총급여를 조회
select dept_name,round(avg(salary),2) as "평균급여",format(sum(salary),2) as "급여합계"
from emp
group by dept_name
having avg(salary)>=5000 and sum(salary)>=50000
order by 2,3; /*order by를 통해 순서를 정렬하는 것도 잊지 말자!*/

-- TODO 직원이 2명 이상인 부서들의 이름과 급여의 표준편차를 조회
select dept_name as '부서들의 이름',stddev(salary) as '급여의 표준편차',avg(salary) as '급여의 평균'
from emp
group by dept_name
having count(*)>=2; /*요놈을 가장 먼저 하는 것이다.*/


/*복습 철저!!! 이 문제도 조금은 어렵다.
where절에 적어야 할 것과 having 절에 적어야 할 것이 나뉘어져 있다.*/
-- TODO  커미션이 있는 직원들의 입사년도별 평균 급여를 조회. 단 평균 급여가 $9,000 이상인 년도분만 조회.
select year(hire_date),avg(salary) as '평균급여'
from emp
where comm_pct is not null /*커미션이 있어야 하니, is not null이다.*/
group by year(hire_date)
having avg(salary)>=9000;

/* ***************************************************************************************
# with rollup : group by 뒤에 붙인다.
 - group by로 묶어 집계할 때 총계나 중간 집계(group by 컬럼이 여러개일경우) 를 계산한다.
 - 구문 : group by 컬럼명[, .. ] with rollup
 - ex) group by job with rollup
 
 
# grouping(컬럼명 [, 컬럼명]) : select 절에서 사용.
- group by  컬럼명 with rollup 으로 집계했을 때 grouping(컬럼명)의 컬럼이 집계시 값들을 그룹으로 나누는데 사용되었으면 0 사용되지 않았으면 1을 반환한다. 
  1이 반환 된 경우는 그 행의 결과는 총계이거나 중간소계임을 말한다.
  
- grouping(컬럼1, 컬럼2, 컬럼3) 과 같이 여러개 컬럼을 지정한 경우
	집계에 모든 세개의 컬럼이 다 사용되었으면 0
    앞의 두개만 사용되었으면 1
    앞의 한개만 사용되었으면 3
    세개 다 사용되지 않았으면 7
    
    컬럼1      컬럼2       컬럼3
     2**2  +  2**1    +  2**0      각각 참여하면 0, 참여 안하면 1을 곱해서 더한다.

* ***************************************************************************************/

/*
sql문의 실행 순서

select ------5순위
from -----1순위
where -----2순위
group by -----3순위
having -----4순위
order by -------6순위


이 순서는 뭐 달달 외우고 있음 좋다만...

근데 생각을 깊게 해 보면 자연스레 체득하고 있는 것이다.

*/


/*아래와 같은 예시들을 잘 보도록 하자.*/


-- EMP 테이블에서 업무(job)별 급여(salary)의 평균과 평균의 총계도 같이나오도록 조회.
select job,round(avg(salary),2) as '평균급여'
from emp
group by job with rollup;
/*with rollup은 평균급여들에 대한 전체적인 집계라고 보면 된다. 근데 이름 부분이 null이다.*/

/*ifnull을써서 이름을 따로 정해 줄 수 있다.*/
select ifnull(job,'총평균') as 'job',round(avg(salary),2) as '평균급여'
from emp
group by job with rollup;


-- EMP 테이블에서 부서(dept)별 급여(salary)의 평균과 평균의 총계도 같이나오도록 조회.
/*이 구문은 if절도 잘 쓰면 좋다.*/
select dept_name as '부서명', if(grouping(dept_name)=0,dept_name,'총평균'),round(avg(salary),2) as '평균급여'
from emp
group by dept_name with rollup;
/*근데 이 예시를 보면 알겠지만, null인 놈이 2놈이 있다.
그래서 쓰는 것이 바로 grouping이다.
결과를 보면 계속 0이 나오다가 마지막에 1이 나온다.
0은 나눠진 그룹에 대한 연산을 의미하고, 1은 특정 그룹이 아닌 전체를 연산한 것을 의미한다.
0은 컬럼명으로 나뉜 데이터들을 집계한 경우에 반환되고, 1은 아닌 경우에 반환된다.
*/

-- EMP 테이블에서 부서(dept_name), 업무(job) 별 salary의 합계와 직원수를 소계와 총계가 나오도록 조회
select dept_name,job,grouping(dept_name,job) as '구분',sum(salary) as '급여합계', count(*) as '직원수'
from emp
group by dept_name,job with rollup;
/*dept_name은 대분류이고, job은 소분류이다.*/
/*with rollup의 알고리즘: 먼저 소분류의 한 종류에 대한 rollup이 이뤄지고,
그런 다음 전체에 대한 rollup이 이뤄진다.*/
/*grouping의 결과:0과 1이 나오다가 가장 마지막에는 3이 나온다.
숫자가 나오는 방식은 위의 설명에 잘 정리해 놓았다. 잘 보시길!*/



/*이런 식으로 더 심화적으로 들어갈 수 있다.*/
select dept_name,job,case grouping(dept_name,job) when 0 then concat(ifnull(dept_name,'미배치'),'-',job) when 1 then dept_name when 3 then '총계' end as '구분',sum(salary) as '급여합계', count(*) as '직원수'
from emp
group by dept_name,job with rollup;



/*with rollup에 대한 예제들은 다시 한번 복습을 잘 하도록 하자.*/


-- # 총계/소계 행의 경우 :  총계는 '총계', 중간집계는 '소계' 로 출력

-- TODO: 부서별(dept_name) 별 최대 salary와 최소 salary를 조회
select dept_name,grouping(dept_name), -- 0:group 별 집계, 1:전체 집계
 max(salary), min(salary),max(salary)-min(salary) as '최대 최소 급여 차이'
from emp 
group by dept_name with rollup; /*가장 마지막에 전체에 대해서 계산한 값을 구한다.*/


-- TODO: 상사_id(mgr_id) 별 직원의 수와 총계를 조회하시오.
select if(grouping(mgr_id)=0,mgr_id,'총계') as mgr_id, count(*)
from emp
group by mgr_id with rollup;
/*참고로 null인 사람이 1명 있을 것인데, 이는 사 장 이다.*/


# SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


/*이 문제는 mysql 버전이 업그레이드가 되면서 잘 안되는 문제인 것 같다.*/
/*코드가 잘 안되더라도 이해바람.*/
-- TODO: 입사연도(hire_date의 year)별 직원들의 수와 연봉 합계 그리고 총계가 같이 출력되도록 조회.
select if(grouping(year(hire_date))=1, 
	   '총계',year(hire_date)) as "입사년도",
       count(*) as '직원수',
	   format(sum(salary),0) as '급여 합계'
from emp
group by year(hire_date) with rollup;



/*복습 철저! 만약 안되면, 그건 mysql 버전 탓이다.*/
-- TODO: 부서(dept_name), 입사년도별 평균 급여(salary) 조회. 부서별 집계와 총집계가 같이 나오도록 조회

select case grouping(dept_name, year(hire_date)) when 0 then concat(dept_name,'-', year(hire_date))
												 when 1 then dept_name
												 when 3 then '총계' end as "구분", avg(salary)
from    emp
group by dept_name, year(hire_date) with rollup;

