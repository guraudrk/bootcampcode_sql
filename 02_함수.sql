/* ***********************************************
단일행 함수 : 행별로 처리하는 함수. 문자/숫자/날짜/변환 함수 
	- 단일행은 selec, where절에 사용가능
다중행 함수 : 여러행을 묶어서 한번에 처리하는 함수 => 집계함수, 그룹함수라고 한다.
	- 다중행은 where절에는 사용할 수 없다. (sub query 이용)
* ***********************************************/

/* ***************************************************************************************************************
함수 - 문자열관련 함수
 char_length(v) - v의 글자수 반환
 concat(v1, v2[, ..]) - 값들을 합쳐 하나의 문자열로 반환
 format(숫자, 소수부 자릿수) - 정수부에 단위 구분자 "," 를 표시하고 지정한 소수부 자리까지만 문자열로 만들어 반환
 upper(v), lower(v) - v를 모두 대문자/소문자 로 변환
 insert(기준문자열, 위치, 길이, 삽입문자열): 기준문자열의 위치(1부터 시작)에서부터 길이까지 지우고 삽입문자열을 넣는다.
 replace(기준문자열, 원래문자열, 바꿀문자열):기준문자열의 원래문자열을 바꿀문자열로 바꾼다.
 left(기준문자열, 길이), right(기준문자열, 길이): 기준문자열에서 왼쪽(left), 오른쪽(right)의 길이만큼의 문자열을 반환한다.
 substring(기준문자열, 시작위치, 길이): 기준문자열에서 시작위치부터 길이 개수의 글자 만큼 잘라서 반환한다. 길이를 생략하면 마지막까지 잘라낸다.
 substring_index(기준문자열, 구분자, 개수): 기준문자열을 구분자를 기준으로 나눈 뒤 개수만큼 반환. 개수: 양수 – 앞에서 부터 개수,  음수 – 뒤에서 부터 개수만큼 반환
 ltrim(문자열), rtrim(문자열), trim(문자열): 문자열에서 왼쪽(ltrim), 오른쪽(rtrim), 양쪽(trim)의 공백을 제거한다. 중간공백은 유지
 trim(방향  제거할문자열  from 기준문자열): 기준문자열에서 방향에 있는 제거할문자열을 제거한다.
								    방향: both (앞,뒤), leading (앞), trailing (뒤)
 lpad(기준문자열, 길이, 채울문자열), rpad(기준문자열, 길이, 채울문자열): 기준문자열을 길이만큼 늘린 뒤 남는 길이만큼 채울문자열로 왼쪽(lpad), 오른쪽(rpad)에 채운다.
													      기준문자열 글자수가 길이보다 많을 경우 나머지는 자른다.
 *************************************************************************************************************** */
use hr; /*이거는 꼭 해놔야 한다!*/



/*1.char_length 함수를 거시기한다.*/
select char_length('부자이장한'); -- 글자수 반환.


select * from emp
/*이름이 일정 글자 수 이상인 사람을 조회하고 싶다면??*/
where char_length(emp_name)>=7;
/*이렇게 하면,  emp_name의 값들을 하나하나 따져서 비교 한 뒤 맞는 놈만 출력을 한다.*/



-- EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 이름 글자수를 조회
 select emp_name, upper(emp_name),lower(emp_name),char_length(emp_name)
 from emp;
 
 /*2.upper,lower,format,concat*/
 
 select upper('abcDEFgh'),lower('abcDEFgh'); #뭐 그냥 봐도 알겠지??
 
 select format(123456789,0); /*0은 소수점 몇 자리까지 보여줄지를 보여준다.*/
 select format(123456789.987654,2); /*소수점 둘째자리까지!! 물론 반올림.*/
 select format(123456789.987654,0); /*정수만! 물론 반올림.*/
 select concat('홍길동','님');
 
 
 
 /*3.insert,replace*/
 /*insert와 replace는 방식을 비슷하지만 까딱하다간 서로 혼동할 수 있다.*/
 
 
 select insert('aaaaaaaa',2,3,'안녕'); -- 두번째글자부터 3글자를 '안녕'으로 변경한다.
 select replace('123456789','234','안녕'); -- 234문자열을 '안녕'으로 변경한다.
 
 
 /*4.substring--------n번째부터 나머지를 반환한다!!!*/
 /*'어디에 쓸꼬?' 하겠지만, '연도-월-일'  에서 월이나 일을 출력하는 일에 쓰인다.*/
 select substring('1234567890',4); -- 4번째 글자부터 나머지를 반환하겠다!
 select substring('1234567890',4,2); -- 4번째 글자부터 두글자 나머지를 반환하겠다!
 select substring_index('aaa-bbb-ccc-ddd-eee','-',3);
 -- 문자열을 '-' 구분자를 기준으로 나눈 뒤 앞에서 3개를 반환!
 -- 이 함수는 약간 어려움을 느낄 수 있다.
  select substring_index('aaa-bbb-ccc-ddd-eee','-',-3); /*이거는 뒤에서부터!*/
 
 
 /*5.left,right*/
 select left('1234567890',5); -- 왼쪽에서 5글자 반환.
 select right('1234567890',5); -- 오른쪽에서 5글자 반환.
 
 
 /*6.trim,rtrim*/
 select char_length(trim('          aaa           '));-- 좌우공백제거
 select char_length(rtrim('            aaa         ')); -- 오른쪽 공백을 제거
 /*왼쪽 공백을 제거하는 것은 ltrim!!*/
 
 select trim(both '-' from '-----------aaaa-----------') as "b";
 -- both 지울 문자열 from 대상 문자열 
  
 select trim(leading '-' from '-----------aaaa-----------') as "b";  #앞에 있는거만 지움
 select trim(trailing '-' from '-----------aaaa-----------') as "b";  #뒤에 있는거만 지움
 
 
 /*7.lpad:10글자로 맞춘다. 모자랄 경우에는 왼쪽에 ' '을 붙인다.*/
 /*글자수를 어떻게 설정하느냐에 따라서 결과가 상당히 달라지므로 그 점을 유의하도록 하자!*/
 select lpad('test',10,' ') as 'b';
 select rpad('test',10,' ') as 'b'; /*여기는 오른쪽에.....*/
 select lpad(3,2,'0'); /*결과는 03으로 나온다.*/
 select rpad('aaaaaaaaaaaa',3,' '); /*근데 이건 3글자를 넘어가는데? 그러면 아예 잘라버린다.*/
 
  
 
--  TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary),부서(dept_name)를 조회. 
--  단 직원이름(emp_name)은 모두 대문자, 부서(dept_name)는 모두 소문자로 출력.

#select emp_id, lower(emp_name),lower(dept_name),salary from emp;

-- TODO: 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 15자가 안되는 이름의 경우  공백을 앞에 붙여 조회. 

    
-- TODO: EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회


/* **************************************************************************
함수 - 숫자관련 함수
 abs(값): 절대값 반환
 round(값, 자릿수): 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값: 0-0이하에서 반올림이므로 정수로 반올림)
 truncate(값, 자릿수): 자릿수이하에서 절삭-버림(자릿수: 양수 - 실수부, 음수 - 정수부, 기본값: 0)
 ceil(값): 값보다 큰 정수중 가장 작은 정수. 소숫점 이하 올린다. 
 floor(값): 값보다 작은 정수중 가장 작은 정수. 소숫점 이하를 버린다. 내림
 sign(값): 숫자 n의 부호를 정수로 반환(1-양수, 0, -1-음수)
 mod(n1, n2): n1 % n2

************************************************************************** */

/*여러가지 예시들*/
select abs(10),abs(-10);
select round(1.23456); -- 소수점 이하에서 반올림
select round(1.23789,2); -- 소숫점 2자리 이하에서 반올림
select round(188.123,-1); -- 자리: 음수 ----> 정수위치.
select ceil(50.9999); /*올림!*/
select floor(50.9999); /*내림!*/
select truncate(1234.567,2); -- 절삭(내림) /*소수점 둘째자리 이하에서 자름.*/
select truncate(1234.567,2); -- 절삭(내림) /*소수점 첫째자리 이하에서 자름.*/
select truncate(1234.567,-1); -- 절삭(내림) /*둘째자리에서 자름. 음수이기 때문에 정수 쪽으로 간다.*/


select sign(-10),sign(0),sign(10);

-- TODO: EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
-- (단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)


-- TODO: 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 
-- (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)


--  TODO: EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
-- (단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)



/* ***************************************************************************************************************
함수 - 날짜관련 계산 및 함수
date/time/datetime: +, - 사용 => 마지막 항목(date:일, time: 초, datetime: 초)의 값을 +/- => 계산 결과가 정수형으로 반환된다.
# 예:2023-09-01 ===>20230901 + 5



now(): 현재 datetime
curdate(): 현재 date
curtime(): 현재 time
year(날짜), month(날짜), day(날짜): 날짜 또는 일시의 년, 월, 일 을 반환한다.
hour(시간), minute(시간), second(시간), microsecond(시간): 시간 또는 일시의 시, 분, 초, 밀리초를 반환한다.
date(), time(): datetime 에서 날짜(date), 시간(time)만 추출한다.

날짜 연산
adddate/subdate(DATETIME/DATE/TIME,  INTERVAL 값  단위)
	날짜에서 특정 일시만큼 더하고(add) 빼는(sub) 함수.
    단위: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER(분기-3개월), YEAR

datediff(날짜1, 날짜2): 날짜1 – 날짜2한 일수를 반환
timediff(시간1, 시간2): 시간1-시간2 한 시간을 계산해서 반환 (뺀 결과를 시:분:초 로 반환)
dayofweek(날짜): 날짜의 요일을 정수로 반환 (1: 일요일 ~ 7: 토요일)

date_format(일시, 형식문자열): 일시를 원하는 형식의 문자열로 반환
*************************************************************************************************************** */

-- 실행시점의 일/시를 조회하는 함수

select now(); -- 일시 --->datetime이 반환이 된다.
select curdate(); -- 날짜만 반환을 해준다.----->date
select curtime(); -- 시간 -> time(11:14:19 뭐 이런식으로 반환한다.)

-- 날짜 타입에서 년 월 일 조회
select year(now()),month(now()), day(curdate());

-- 시간 타입에서 시 분 초 조회 /*microsecond는 밀리초 반환.*/
# select hour(now()),minute(curtime()),second(curtime()),microsecond(curtime);


select date(now()); -- datetime ->date
select time(now()); -- datetime을 time 타입으로 바꿔준다.


-- 날짜 연산

select adddate(now(), interval 2 day); /*now로부터 2(2일,2달,2년 등)만큼 떨어져 있는 날짜를....*/
/*위의 코드와 같은 경우는 지금으로부터 2일 후의 것을 출력해달라고 하는 것이다.*/

select adddate(curdate(),interval 2 quarter); /*2분기 후의 날짜를 출력한다.*/

select adddate(curdate(),interval -2 year); /*이거는 날짜를 빼는 거다.*/

select subdate(curdate(),interval 2 year); /*이거도 날짜를 빼는 거다.*/



/*curtime도 있다. 이건 뭐 날짜의 개념이 아니라 시간의 개념이다.*/

select adddate(curtime(),interval 10 hour);
select adddate(curtime(),interval 10 minute);


select datediff(curdate(),'2023-08-30'); /*20230830일부터 오늘까지의 날짜의 차이는?*/
select datediff('2023-08-30',curdate()); /*20230830일부터 오늘까지의 날짜의 차이는? 어? 근데 앞의 거랑 반대인데?------그래서 음수를 반환한다.*/
select timediff(curtime(),'11:20:10'); /*curtime과 11:20:10을 뺀다. 차이나는 시간:분:초를 반환한다.*/


# select dayofweek(now()); /*일요일이면 1, 월요일이면 2.........뭐 이런식이다.*/




select date_format(now(),'%Y년 %m월 %d일 %H시 %i분 %S초 %p %W'); /*이렇듯 필요한 형식대로 하면 된다.*/

select date_format(curdate(),'%m%d%Y%w'); /*글자를 대문자로 하는가 소문자로 하는가도 잘 살펴야 한다.*/






-- TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일전', 입사일, '입사일로 부터 10일 후' 의 날짜를 조회. 


-- TODO: 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월전과 입사일(hire_date), 6개월후 날짜를 조회.


-- TODO ID(emp_id)가 200인 직원의 이름(emp_name), 입사일(hire_date)를 조회. 입사일은 yyyy년 mm월 dd일 형식으로 출력.


-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회. 근무개월수 내림차순으로 정렬.


-- TODO: ID(emp_id)가 100인 직원이 입사한 요일을 조회



/* *************************************************************************************
함수 - 조건 처리함수
ifnull (기준컬럼(값), 기본값): 기준컬럼(값)이 NULL값이면 기본값을 출력하고 NULL이 아니면 기준컬럼 값을 출력
if (조건수식, 참, 거짓): 조건수식이 True이면 참을 False이면 거짓을 출력한다.
nullif(컬럼1, 컬럼2): 컬럼1과 컬럼2가 같으면 NULL을 반환, 다르면 컬럼1을 반환
coalesce(ex1, ex2, ex3, .....) ex1 ~ exn 중 null이 아닌 첫번째 값 반환.
************************************************************************************* */

select ifnull(null,'없음');
select ifnull(comm_pct,'no comission')from emp;

select if(salary > 10000,'평균이상','평균미만') from emp;

select nullif(10,10); -- 두 값이 같으면 null
select nullif(100,1); -- 두 값이 다르면 앞의 값을 반환.
-- nullif(2022년 판매 개수,2021년 판매 개수) /*뭐 이런걸 할 때 거시기를 한다.*/


select coalesce(null,null,null,10,20,30); -- 값이 나열되었을 때 null이 아닌 첫번째 값을 반환한다.
# 근데 딱 봐도 알겠지만 사용빈도가 그렇게 높은 것은 아니다.






-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '부서미배치'를 출력.


-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0이 조회되록 한다.




/* *************************************
CASE 문
case문 동등비교
case 컬럼 when 비교값 then 출력값
              [when 비교값 then 출력값]
              [else 출력값]
              end
              
case문 조건문
case when 조건 then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end

************************************* */

/*sql에서 조건문을 쓰게 해줄 수 있게 해주는 것이 바로 case이다.*/



/*
if dept_name==null:
    return '부서없음'
elif dept_name=='IT':
    return '전산실'
elif dept_name=='Finance':
    return '회계부'
else:
    return dept_name    
*/

/*예시*/
/*case를 먼저 정의하고, when-then을 끊임없이 나열한다.*/
/*end가 나오면 case문이 끝이 났다는 의미이다.*/
select case dept_name when 'IT' then '전산실'
when 'Finance' then '회계부'
when 'Sales' then '영업부'
else ifnull(dept_name,"부서없음") /*null이면 그냥 자기 값을 리턴하라는 것이다.*/
/*ifnull을 통해서, null이라면 '부서없음'이라는 값을 출력하게 하자.*/
end as "부서명"
from emp
order by 1; /*order by를 쓸수도 있다.*/

/*만약 이 3가지가 다 아니라면 다 null이 나온다ㅎㅎ
하지만 else를 정의를 하면 정의한 대로 값이 나온다.*/



/*타입 변환*/
/*내가 형 변환 메소드를 쓰지 않았는데도 결과는 형 변환이 되었다. 이게 바로 타입 변환이다.*/
select '1000'+'2000';
select curdate()+10;


/*명시적인 형변환*/
select convert(curdate(),signed);
select convert(20230901,date);
select convert(102030,time);

/*cast함수로도 데이터타입을 바꿀 수 있다.
convert와 cast의 차이는 문법의 차이이다.*/
select cast(102030 as time);

-- EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회
select salary, case when salary>='10000' then '1등급'
else '2등급' end "salary 등급"
from emp;
/*그러니까, '동등비교'와 '조건문'의 차이를 이 예시와 바로 위의 예시를 통해서 알 수 있다.*/

-- TODO: EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회.  
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회



-- TODO: EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회.
-- 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력




-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
-- 단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.


--  case 를 이용한 정렬
--  직원들의 모든 정보를 조회한다. 단 정렬은 업무(job)가 
-- 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' 순서대로 먼저나오도록 한다. (나머지 JOB은 상관없음)
/*이 코드는 반드시 여러번 보도록 하자!*/

select * from emp
order by case job when  'ST_CLERK' then 1
			  when  'IT_PROG' then 2
              when 'PU_CLERK' then 3
              when 'SA_MAN' then 4
              else job end;


-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회. 근무개월수 내림차순으로 정렬.
select emp_name,timestampdiff(month,now(),hire_date)
from emp;