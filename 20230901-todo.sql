use hr;

--  TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary),부서(dept_name)를 조회. 
--  단 직원이름(emp_name)은 모두 대문자, 부서(dept_name)는 모두 소문자로 출력.
select emp_id,upper(emp_name),salary,lower(dept_name) from emp;

-- TODO: 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 15자가 안되는 이름의 경우  공백을 앞에 붙여 조회. 
select lpad(emp_name,15,' ') as '15자리 깔맞춤' from emp;
-- TODO: EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회alter
select emp_name,char_length(emp_name) as '글자수'
from emp
where char_length(emp_name)>=10;

-- TODO: EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
-- (단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)
select emp_id,emp_name,salary,ceil(salary*1.15) as "SAL_RAISE"
from emp;

-- TODO: 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 
-- (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)
select emp_id,emp_name,salary,ceil(salary*1.15) as "SAL_RAISE",salary*1.15-salary as "difference"
from emp;

--  TODO: EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
-- (단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)
select emp_id,emp_name,comm_pct,round(comm_pct*1.08,2) as 'comm_raise'
from emp
where comm_pct is not null;

/*is not null같은 조건을 반드시 넣도록 하자!*/

-- TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일전', 입사일, '입사일로 부터 10일 후' 의 날짜를 조회. 
select adddate(hire_date,interval 10 day) as '10일전',adddate(hire_date,interval -10 day) as '10일 후', hire_date as '입사일'
from emp
where dept_name='IT';

-- TODO: 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월전과 입사일(hire_date), 6개월후 날짜를 조회.
select emp_name, adddate(hire_date,interval 6 month) as '6개월후',adddate(hire_date,interval -6 month) as '6개월전'
from emp
where dept_name='Purchasing';

-- TODO ID(emp_id)가 200인 직원의 이름(emp_name), 입사일(hire_date)를 조회. 입사일은 yyyy년 mm월 dd일 형식으로 출력.
select emp_name,date_format(hire_date,'%Y년 %m월 %d일') as 입사일
from emp
where emp_id=200;

-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회. 근무개월수 내림차순으로 정렬.
/*timestampdiff 함수는 pdf 파일에만 있던 것이기 때문에ㅋㅋㅋㅋㅋ 맞추기가 조금은 어려운 문제였다.*/
select emp_name,timestampdiff(month,hire_date,now()) as '근무개월수'
from emp;


-- TODO: ID(emp_id)가 100인 직원이 입사한 요일을 조회
select dayofweek(hire_date) "입사요일(숫자)",
case dayofweek(hire_date) when 1 then '일요일'
when 2 then '월요일'
when 3 then '화요일'
when 4 then '수요일'
when 5 then '목요일'
when 6 then '금요일'
when 7 then '토요일'
end as '입사요일'
from emp
where emp_id=100;


/*다른 방법!!
정말 좋은 방법이다 ㅇㅅㅇ*/
select dayofweek(hire_date) as '입사요일',
	   substring('일월화수목금토',dayofweek(hire_date),1),
       concat(substring('일월화수목금토',dayofweek(hire_date),1),'요일')
from emp;

-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '부서미배치'를 출력.
select emp_id,emp_name,job,ifnull(dept_name,'부서미배치')
from emp;
/*ifnull을 이 때 쓴다.*/


-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0이 조회되록 한다.
select emp_id,emp_name,salary,ifnull(salary * comm_pct,'0')
from emp;


/*이런 식으로 해도 된다.
salary * ifnull(comm_pct,0) as "comission"*/


-- TODO: EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회.  
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회
/*다른건 몰라도 이 구문은 정말 잘 파악해 보자. 복습 필수!!*/
select emp_id,emp_name,job,
case job when 'AD_PRES' then '대표'
when 'FI_ACCOUNT' then '회계'
when 'PU_CLERK' then '구매' end '업무'
from emp
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');



-- TODO: EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회.
-- 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력
select dept_name, salary,
case dept_name when 'IT' then salary*0.1
when 'Shipping' then salary*0.2
when 'Finance' then salary*0.3
else 0 end '급여 인상분'
from emp;




-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
-- 단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.
/*이런 문제는 case 뒤에 컬럼명을 쓸 수 없다.*/
select emp_id,emp_name,salary, 
case when salary<5000 then salary*0.3
when salary>=5000 and salary<10000  then salary*0.2
when salary>=10000 then salary*0.1
end '인상된 급여'
from emp;
