-- 주석. sql문 실행 ->control + enter
/* 코드 사이에 블록을 넣고 싶을 때 */
-- 사용자 계정 생성:이름은 마음대로 생성해도 된다.


-- local 접속 계정을 만든다. 명령문이 끝날 때는 ;을 찍는다.

create user 'playdata'@localhost identified by '1111'; /*password는 1111이다.*/

-- 원격접속 계정을 만든다. 
create user 'playdata'@'%' identified by '1111';


-- 등록된 사용자계정 조회
select user, host from mysql.user;

-- Error Code: 1396은 이미 계정이 존재할 때 나오는 에러이다. 계정이 이미 존재하는데 또 만들었다는 거지.

-- 계정에 권한 부여

grant all privileges on *.* to 'playdata'@localhost; /*all privilages를 계정('playdata'@localhost)에 grant하겠다!*/
grant all privileges on *.* to 'playdata'@'%';

