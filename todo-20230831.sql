use hr;

-- TODO: EMP 테이블에서 2007년 이후 입사한 직원들의  ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
-- 참고: date/datatime에서 년도만 추출: year(값). ex) year('2020-10-10') => 2020
select emp_id,emp_name,hire_date
from emp
where year(hire_date)>2007;
-- TODO: EMP 테이블에서 2004년에 입사한 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
select emp_id,emp_name,hire_date
from emp
where year(hire_date)=2004;
/*where hire_date between '2004-01-01' and '2004-12-31'*/
/*order by 3을 통해 2004년 안에서도 그 입사 순서를 알 수 있다.*/

-- TODO: EMP 테이블에서 2005년 ~ 2007년 사이에 입사(hire_date)한 직원들의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 조회.
select emp_id,emp_name,hire_date
from emp
where year(hire_date)>=2005 and  year(hire_date)<=2007;
/*where hire_date between '2005-01-01' and '2007-12-31'*/
/*order by 3을 통해 그 안에서도 날짜순서대로 데이터를 잘 조회할 수 있다.*/



-- TODO: EMP 테이블에서 직원의 ID(emp_id)가 110, 120, 130 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회
select emp_id,emp_name,job
from emp
where emp_id=110 or emp_id=120 or emp_id=130;
/*where emp_id in (110,120,130);    뭐 이런 식으로 쓸 수도 있다.*/



-- TODO: EMP 테이블에서 부서(dept_name)가 'IT', 'Finance', 'Marketing' 인 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,emp_name,dept_name
from emp
where dept_name='IT' or dept_name='Finance' or dept_name='Marketing';
/*where dept_name in ('IT','Finance','Marketing')*/


-- TODO: EMP 테이블에서 'Sales' 와 'IT', 'Shipping' 부서(dept_name)가 아닌 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,emp_name,dept_name
from emp
where dept_name<>'IT' and dept_name<>'Sales' and dept_name<>'Shipping';
/*where dept_name not in ('Sales','IT','Shipping')*/

-- TODO EMP 테이블에서 업무(job)에 'SA'가 들어간 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회
select emp_id,emp_name,job
from emp
where job like '%SA%';

-- TODO: EMP 테이블에서 업무(job)가 'MAN'로 끝나는 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회
select emp_id,emp_name,job
from emp
where job like '%MAN';

-- TODO. EMP 테이블에서 커미션이 없는(comm_pct가 null인)  모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회
select emp_id,emp_name,salary,comm_pct
from emp
where comm_pct is null; /*=null을 이용하면 안된다.*/

-- TODO: EMP 테이블에서 커미션을 받는 모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회
select emp_id,emp_name,salary,comm_pct
from emp
where comm_pct is not null;

-- TODO: EMP 테이블에서 관리자 ID(mgr_id)가 없는(상사가 없는) 직원의 ID(emp_id), 이름(emp_name), 업무(job), 소속부서(dept_name)를 조회
select emp_id,emp_name,job,dept_name
from emp
where mgr_id is null;

-- TODO : EMP 테이블에서 연봉(salary * 12) 이 200,000 이상인 직원들의 모든 정보를 조회.
select *
from emp
where salary*12>=200000;


-- TODO: EMP 테이블에서 부서(dept_name)가 'Sales'이고 업무(job)가 'SA_MAN'이고 급여가 $13,000 이하인 
-- 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary), 부서(dept_name)를 조회
select emp_id,emp_name,job,salary,dept_name
from emp
where dept_name='Sales' and job='SA_MAN' and salary<=13000;

-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서(dept_name)가 'Shipping' 이고 2005년이후 입사한 
-- 직원들의  ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date),부서(dept_name)를 조회
select emp_id,emp_name,job,hire_date,dept_name
from emp
where job like '%MAN%' and dept_name='Shipping' and year(hire_date)>=2005;


-- TODO: EMP 테이블에서 입사년도가 2004년인 직원들과 (입사년도와 상관없이) 급여가 $20,000 이상인 
--  직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date), 급여(salary)를 조회.
select emp_id,emp_name,hire_date,salary
from emp
where year(hire_date)=2004 or salary>=20000;



-- TODO : EMP 테이블에서, 부서이름(dept_name)이  'Executive'나 'Shipping' 이면서 급여(salary)가 6000 이상인 사원의 모든 정보 조회. 
select * 
from emp
where (dept_name='Executive' or dept_name='Shipping') and salary>=6000;
/*where dept_name in ('Executive','Shipping') and salary>=6000 뭐 이런 식으로 써야 한다.*/
-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서이름(dept_name)이 'Marketing' 이거나 'Sales'인 
-- 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)를 조회
select emp_id,emp_name,job,dept_name
from emp
where (dept_name='Marketing' or dept_name='Sales') and job like'%MAN%';
/*where dept_name in ('Marketing','Sales') and job like '%MAN%'와 같이도 쓸 수 있다.*/

-- TODO: EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중 급여(salary)가 $10,000 이하이 거나 2008년 이후 입사한 
--  직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date), 급여(salary)를 조회
select emp_id,emp_name,job,hire_date,salary
from emp
where (salary<=10000 or year(hire_date)>=2008) and job like'%MAN%';
/*and보다 or를 먼저 묶어줘야 한다.*/

-- TODO: 급여(salary)가 $5,000을 넘는 직원의 ID(emp_id), 이름(emp_name), 급여(salary)를 급여가 높은 순서부터 조회
select emp_id,emp_name,salary
from emp
where salary>5000
order by salary desc;
/*높은 순서대로 보는 거니까 desc!*/


-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 입사일(hire_date) 순서로 조회.
select emp_id,emp_name,job,hire_date
from emp
order by hire_date desc;

-- TODO: EMP 테이블에서 ID(emp_id), 이름(emp_name), 급여(salary), 입사일(hire_date)을 
-- 급여(salary) 오름차순으로 정렬하고 급여(salary)가 같은 경우는 먼저 입사한(hire_date) 순서로 정렬.
select emp_id,emp_name,salary,hire_date
from emp
order by salary asc,hire_date asc;

/*둘다 오름차순이기 때문에 둘 다 asc를 생략을 해도 되긴 해!*/
