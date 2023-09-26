/* ****************************************************
집합 연산자 (결합 쿼리)
- 둘 이상의 select 결과를 합치는 연산
- 구문
 select문  집합연산자 select문 [집합연산자 select문 ...] [order by 정렬컬럼 정렬방식]
 
 
 
 - 한마디로, 두 select 값들 사이에 집합연산자를 넣는 것이다.
 
-연산자
  - UNION: 두 select 결과를 하나로 결합한다. 단 중복되는 행은 제거한다. 
  - UNION ALL : 두 select 결과를 하나로 결합한다. 중복되는 행을 포함한다. 
  - 이 둘의 차이가 미세하지만 꽤 크다. 이 규칙이 쓰이는 부분이 있을지도?
  
 - 규칙
  
  - 연산대상 select 문의 컬럼 수가 같아야 한다. 
  - 연산대상 select 문의 컬럼의 타입이 같아야 한다.
  - 연산 결과의 컬럼이름은 첫번째 select문의 것을 따른다.
  - order by 절은 구문의 마지막에 넣을 수 있다.
  
*******************************************************/



-- emp 테이블의 salary 최대값와 salary 최소값, salary 평균값 조회
select max(salary),min(salary),avg(salary) from emp;


/*3개의 select 문을 합치니 3행 1열 짜리가 나온다.*/
/*Label을 추가하는 방법을 잘 숙지하자!*/
select '합계' as "Label", max(salary) as '집계결과' from emp
union
select '최소값',min(salary) from emp
union
select '평균', round(avg(salary),2) from emp;



-- full outer join 정의
-- 간단히 말해서, left랑 right를 합쳐서 full outer join을 하는 것이다.
-- inner join하면 빠질 애들, outer join하면 빠질 애들 둘 다를 볼 수 있다.
-- 그걸 하기 위해서는 union을 쓸 필요가 있다.



/*중복된 것을 거르고 싶다면 union을 하고, 중복된 것을 거르고 싶지 않다면 union all을 쓴다. 쓰는 것이 그때그때 다르다.*/
select * from emp e left join dept d on e.dept_id = d.dept_id
union all
select * from emp e right join dept d on e.dept_id = d.dept_id
order by salary desc;



-- with rollup(복습하기!!)
-- with rollup을 활용해서 데이터를 더 간단히 할 수 있다.
-- 어떻게 할지 모르겠는 경우에는 union all을 쓰면 된다.
select dept_id, sum(salary) as '급여합계'
from emp
group by dept_id with rollup
union all
select '총집계', sum(salary) from emp;

