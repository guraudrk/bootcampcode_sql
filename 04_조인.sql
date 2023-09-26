use hr_join; /*지금부터는 요놈을 쓸 것이다!*/
use hr;
/*막간 상식

inner join 이나 outer join 중에 어떤 것을 선택할지 고민이 된다면, 
outer join을 선택하자. 더 많이 봐서 나쁠 것은 없다.

*/

-- 1.id가 100인 직원 정보 조회. 아래와 같은 쿼리문을 작성하면 정보가 잘 나온다.

select *
from emp
where emp_id =150;


-- 2.dept_id가 80이니까

select * from dept where dept_id=80;


-- 3.근데 위와 같이 하기 위해서는..... 하나를 알려고 할 때 마다 쿼리문을 작성해야 한다는 맹점이 있다. ㅜㅜ
-- mgr_id를 통해 상사의 정보를 얻고 싶을 때도 굳이 쿼리문을 작성해야 한다. 아래와 같이 말이다.

select * from emp where emp_id = 145;

-- 4.1명을 찾으려면 이 방법도 좋은데, 사람이 점점 많아지면 어쩔겨? 딱 봐도 비효율적이다.


-- 5.하지만 걱정하지 마시라. 이와 같은 맹점을 해결하기 위해 join이 있다.
-- join에 대한 자세한 설명은 join부분에 있으니 잘 참고하자!










/*
foreign key-외래 키

제약 조건 중 하나이다.
테이블과 테이블 간의 관계성과 관련이 있는 키이다.
한 테이블이 다른 테이블의 컬럼 값을 참조하는 것이다.
a라는 테이블은 b라는 테이블을 참조한다 했을 때 

그 참조하는 테이블의 primary key 값만을 참조할 수 있다.
그래야만 참조 시 혼동을 방지할 수 있기 때문이다.


그래서, 우리는 primary key만을 참조할 수 있게 
foreign key의 컬럼을 잘 통제해야 한다.
그렇기 때문에, 테이블 a와 테이블 b간의 관계가 생기며
이를 관계형 데이터베이스라고 명명한다.


이런 과정을 더 쉽게 하기 위해 join이라는 놈이 필요하다.

join은 select를 할 때 하는 것이다. delete,update는 테이블 단위로 데이터를 조회하지만 select는 일부만 조회하는 것이기 때문이다.

그 이유는 수정하기 쉽게 하기 위함이고, 더 근본적인 이유는 중복된 정보를 막기 위함이다.


참조하는 테이블과 참조당하는 테이블간의 관계를 자식테이블,부모테이블이라고 일컫기도 한다.

참조하는 놈이 자식 테이블, 참조 당하는 놈이 부모 테이블이다.



관계성을 보여주는 기호도 있다. 유의!!(보통은 화살표로 표현을 한다.)
기호에는 여러가지가 있는데, 각자의 의미가 있다.

0은 관계가 발견되지 않았다는 것이고

1과 비슷한 기호는 부모자식간에 1개만 관계를 맺는 것이다.(매우 중요한 요소이겠지?)

그리고 여러 갈래의 줄이 그어질 수도 있는데, 이는 n이다.


pdf에 나온 기호는

'이 데이터는 다른 테이블의 데이터와 관계가 아예 없을 수도 있고, 1개와 관계를 맺을 수도 있고, n개와 관계를 맺을수도 있습니다.' 라는 의미가 강하다.

이 화살표의 방향은 부모가 자식에게 향하는 것은 되지만,

자식이 부모에게 향하되, n개를 가리키는 기호가 나올 수는 없다.

(물론, 자식 테이블에서 부모 테이블과 관계를 맺지 않을 수는 있다.)


*/


/*
foreign key column 

이 값은 바깥 테이블의 primary key값을 가진다.
그렇기 때문에 아무 값이나 갖지는 못한다.

데이터의 중복 문제 때문에 데이터들을 2개의 테이블로 나눠서 관리한다.


자식 데이터는 부모 데이터와 관계가 0개 혹은 1개 있으며(0개가 가능한 것은 null을 허용하는 것이다.)
부모 데이터는 자식 데이터와 관계가 n개가 있을 수 있다. 이는 매우 당연한 것이다.


부모 데이터와 자식 데이터간의 관계는 0과1과n개의 선들로 표현된다.


또한, 자식 테이블로 인해 참조가 되는 놈은 삭제가 되지 못한다.
애초에 부모 테이블에 있는 데이터는 삭제 자체가 어렵다.

지우는 방법은

참조하는 행을 지운다거나, 컬럼의 값만 지운다는 것이다.
근데 이걸 하나하나 찾아다니면서 삭제하는 것이 쉽지 않다.

그래서 설정하는 것이 on이라는 설정이다.
이 설정은 데이터가 삭제 시 그걸 어떻게 관리를 하나 설정하는 것이다.
(그 설정은 delete cascade 같은 것들이 있다.)


delete cascade는 부모 테이블의 참조 시 자식까지 함께 삭제하는 것이다.

on 설정을 설정하지 않는 것은 
'나의 데이터를 함부로 지워지지 않게 하겠다' 라는 의미이다.


반면, on update도 있다.
이는 참조하는 부모테이블의 참조 컬럼값이 변경이 되면 어떻게 처리할 것인지 설정하는 것이다.

*/


/*foreign key 제약조건

table drop시 foreign key 제약조건 제거
부모 테이블 drop 전에 mysql의 foreign key가 적용이 되지 않도록 설정해야 한다.
참조관계를 설정하지 않겠다는 것이다.

set foreign_key_checks=0; 와 같이 쓸 수 있다.

*/



/* ********************************************************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다. 
- 이 때, 실제로(물리적으로)합치는 것이 아니라 논리적으로 합치는 것이다.
- 합칠 때, on 절 뒤에다 공통의 것을 합쳐야 한다. 이 말이 무슨 말인지는 예시 코드를 보면 알 수 있다.
- 합친 table
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블. 조회해야하는 주 정보(main information) 테이블
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블. 조회하는 주정보의 부가정보(sub information) 제공 테이블
 
 - 소스테이블과 타겟테이블은 join을 하는 사람이 임의로 정하는 것이다.
 
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join(equal연산을 쓰는 것) , non-equi join
- 조인의 종류(보통 inner join과 outer join을 쓴다. 각각이 어떻게 작동하는지는 예시를 보면 알 수 있을 것이다.)
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다.  (만족하지 못하는 행은 아예 지워버린다. 이게 핵심.)
    - Outer Join(join의 결과가 false가 되게 하는 놈도 보여주는 놈이 바로 outer join이다.)
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join, Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. (값을 합치는 조건이 하나도 없이 그냥 무지성으로 매칭하는 것이다.)
        - 근데 논리적으로 틀릴 가능성이 높다. 
        
        
	- join 구문은 from 절에서 사용을 많이 한다.
******************************************************************************** */        
/* **********************
크로스조인
SELECT * 
  FROM t1 CROSS JOIN t2;
* **********************/

select *
from emp cross join dept; /*emp,dept를 서로 합치고 모든 컬럼을 보여달라는 이야기!*/
/*실제로 데이터가 맞는지 아닌지는 그닥 상관하지 않는다. ㅋㅋ*/

/*실제로 개수는 이 둘의 데이터의 수를 곱한 만큼 나온다.*/
select count(*) from dept;
select count(*) from emp;
select 27*107;

/* ****************************************
-- INNER JOIN
FROM  테이블a INNER JOIN 테이블b ON 조인조건  (+inner join C 조건)

- inner는 생략 할 수 있다.
**************************************** */


/*백문이 불여일견! 직접 한번 구문을 보도록 하자!*/
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- emp에는 dept_name이 없으니 이 때 join을 쓴다.
select emp.emp_id, emp.emp_name, emp.hire_date, dept.dept_name /*join을 했다면, 이런 식으로 명시적으로 명시를 해줘야 한다!*/
from emp INNER JOIN dept ON emp.dept_id=dept.dept_id; /*on의 가장 뒤에는 조건을 써 넣는다. 보통은 공통된 부분을 정의를 한다.*/
/*emp의 dept_id와 dept의 dept_id가 같은 놈을 합친다. */


/*이름을 간소화하는 코드. 좋은 코드다! 이러한 별칭을 alias라고 한다.*/
select e.emp_id, e.emp_name, e.hire_date, d.dept_name 
from emp e INNER JOIN dept d ON e.dept_id=d.dept_id;

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_name as 'name', e.hire_date as 'hire_date', d.dept_name as 'dept_name'
from emp e join dept d on e.dept_id=d.dept_id/*inner join의 inner는 생략 가능하다.*/
where e.emp_id = 100; /*여기서 직원의 id가 100인 직원의 직원 정보를 찾는 것이다.*/



-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
/*한번에 테이블을 3번 합쳐야 한다!*/
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id=j.job_id join dept d on e.dept_id = d.dept_id; 
/*테이블을 합칠 때 마다 각기 다른 조건을 붙임으로써 정확성을 지킨다.*/



-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select d.dept_id, d.dept_name, d.loc, e.emp_name
from dept d inner join emp e on d.dept_id = e.dept_id
where d.dept_id =30;
/*'dept 30에 다니는 놈들은 이런 놈들입니다'*/

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 급여 등급 오름차순으로 정렬
select e.emp_id,e.emp_name,e.salary,concat(s.grade,'등급') as "grade"
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;
desc salary_grade;



-- TODO 직원 id(emp.emp_id)가 200번대(200 ~ 299)인 직원들의  
-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.

select e.emp_id,e.emp_name,e.salary,d.dept_name,d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.emp_id between 200 and 299
order by 1 desc;


-- TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name),
-- 업무(emp.job_id), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select e.emp_id, e.emp_name, d.loc,e.job_id,d.dept_name
from emp e join dept d on e.dept_id=d.dept_id
where e.job_id='FI_ACCOUNT'
order by 1 desc;

-- TODO 커미션을(emp.comm_pct) 받는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name),
-- 급여(emp.salary), 커미션비율(emp.comm_pct), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.

select e.emp_id,e.emp_name,e.salary,e.comm_pct,d.dept_name,d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.comm_pct is not null
order by 1 desc;

-- TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 

select d.dept_id,d.dept_name,d.loc,e.emp_id,e.emp_name,e.job_id
from emp e join dept d on e.dept_id=d.dept_id
where d.loc='New York';

-- TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select e.emp_id,e.emp_name,e.job_id,j.job_title
from emp e join job j on e.job_id=j.job_id;

	    
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 
-- 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.emp_id, e.emp_name,e.salary,j.job_title,d.dept_name
from emp e join job j on e.job_id=j.job_id
		   join dept d on e.dept_id=d.dept_id 
where e.emp_id='200';



-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 
-- 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 직원이름 내림차순으로 정렬
select d.dept_name,d.loc,e.emp_name,j.job_title
from emp e join job j on e.job_id=j.job_id
		   join dept d on e.dept_id=d.dept_id 
where d.dept_name='Shipping'
order by e.emp_name desc;

-- TODO: 'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 
-- 이름(emp.emp_name), 입사일(emp.hire_date)를 조회 입사일은 'yyyy년 mm월 dd일' 형식으로 출력
/*형식에 맞게 출력하는 것이 중요하다.*/
select e.emp_id,e.emp_name,date_format(e.hire_date,'%Y년 %m월 %d일') as '입사일'
from dept d join emp e on e.dept_id=d.dept_id 
where d.loc='San Francisco';


/*어렵다. 복습 철저!!*/
/*null인 놈들도 보기 위해서는 left join을 하는 것이 좋다.*/
-- TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬. 
select d.dept_name,avg(e.salary)
from dept d left join emp e on e.dept_id=d.dept_id
group by d.dept_id
order by 2 desc;



/*어렵다. 복습!!*/
-- TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 
-- 급여(emp.salary), 급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬

select e.emp_id,e.emp_name,j.job_title,e.salary,s.grade,d.dept_name
from emp e join job j on e.job_id=j.job_id join dept d on e.dept_id=d.dept_id join salary_grade s
on e.salary between s.low_sal and s.high_sal
order by s.grade desc;



/*약간 헛갈렸다. 복습 철저!*/
-- TODO salary 등급(salary_grade.grade)이 1인 직원들이 부서별로 몇명있는지 조회. 직원수가 많은 부서 순서대로 정렬.
select d.dept_name as '부서 이름',count(e.emp_id) as '직원수'
from salary_grade s join emp e on e.salary between s.low_sal and s.high_sal join dept d on d.dept_id=e.dept_id
where s.grade=1
group by d.dept_name
order by 2 desc; 


/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
- 직관적으로 이야기해서, 자기 자신을 참고하는 것이다.
- 아래의 예시를 통해서 잘 파악하도록 하자.
**************************************************** */


-- 직원 ID가 101인 직원의 직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회

select e.emp_id, e.emp_name, m.emp_name as '상사이름'
from emp e join emp m on e.mgr_id = m.emp_id
where e.emp_id=101;
/*두개의 emp가 있는데, 각자 다른 것에 대해 다룬다고 '간주'를 하면 편하다.*/



/* ****************************************************************************
외부 조인 (Outer Join)
- 불충분 조인
    - 조인 연산 조건을 만족하지 않는 행도 포함해서 합친다
    - 왜 굳이 조건을 만족하지 않는 것도 합치냐면, 조건에 포함되지 않는 것도 보여줘야 할 경우가 있기 때문이다.
종류
 left  outer join: 구문상 소스 테이블이 왼쪽
 right outer join: 구문상 소스 테이블이 오른쪽
 full outer join:  둘다 소스 테이블 (Mysql은 지원하지 않는다. - union 연산을 이용해서 구현)

- 구문
from 테이블a [LEFT | RIGHT] OUTER JOIN 테이블b ON 조인조건 
-left와 right는 어떤 것의 데이터를 다 보여줄 것인지에 관한 것이다. 
-left라고 쓰면 왼쪽에 있는 놈들만 다 나오게 하는 것이다.
- OUTER는 생략 가능!!



-여담
-left랑 right 중에서 뭐가 편할까?
-A:left가 더 편하다. 먼저 오잖아.
**************************************************************************** */

-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. dept_name의 내림차순으로 정렬한다.===========>outer join을 해서 보이도록 하자.
select count(*) /*107개가 전부 다 잘 나온다!*/
from emp e left join dept d on e.dept_id = d.dept_id;
/*문제에서 '부서가 없는 직원의 정보도 나오도록 조회'라고 쓰여져 있으니, left join을 쓴다.*/



/*복습 철저!!*/
-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)
select e.emp_id, e.emp_name,e.dept_id, d.dept_name, d.loc
from emp e left outer join dept d on e.dept_id = d.dept_id and d.dept_id=80;
/*on에서 조건을 2가지를 조회한다.*/

        
-- TODO: 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 
--  직원의 ID(emp.emp_id),이름(emp.emp_name), 업무명(job.job_title) 을 조회. 업무명이 없을 경우 '미배정' 으로 조회
select e.emp_id,e.emp_name,ifnull(j.job_title,'백수') as '업무명'
from emp e left outer join job j on e.job_id=j.job_id
where e.emp_id in (100,110,120,130,140);

-- TODO: 부서 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.
-- count(*) : 행수
/*outer join이기 때문에 직원수가 없는 놈까지 다 나온다.*/
select d.dept_id,d.dept_name,ifnull(count(e.emp_id),'0') as '직원수'
from dept d left outer join emp e on d.dept_id=e.dept_id
group by d.dept_id
order by count(e.emp_id) desc;


/*입사일의 형식, 상사에 관한 문제는 다시 한번 복습할것!!*/
-- TODO: EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 모든 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy/mm/dd 형식으로 출력
select e.emp_id,e.emp_name,m.emp_name,date_format(e.hire_date,'%Y년 %m월 %d일') as '입사일'
from emp e left outer join emp m on e.mgr_id=m.emp_id
where e.dept_id=90;
 
/*복습 철저!! 이 문제가 가장 어렵다! 복습을 잘하자!*/
-- TODO 2003년~2005년 사이에 입사한 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
-- 한번 left outer join을 하면, 끝날 때 까지 계속 left outer join을 하면 된다.

select e.emp_id,e.emp_name,j.job_title,e.salary,e.hire_date,m.emp_name as '상사이름',m.hire_date,d.dept_name,d.loc
from emp e left outer join dept d on e.dept_id=d.dept_id left join job j on j.job_id=e.job_id left join emp m on e.mgr_id=m.emp_id
where year(e.hire_date) between 2003 and 2005;













