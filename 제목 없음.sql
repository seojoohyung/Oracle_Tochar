--P.198
SELECT ROUND(345.123, -2) 결과 FROM DUAL;
SELECT ROUND(345.123, -1) 결과 FROM DUAL;
SELECT ROUND(345.523, 0) 결과 FROM DUAL;
SELECT ROUND(345.123, 1) 결과 FROM DUAL;
SELECT ROUND(345.123, 2) 결과 FROM DUAL;
SELECT ROUND(345.123, -2) 결과 FROM DUAL;
SELECT ROUND(345.123, -1) 결과 FROM DUAL;

SELECT TRUNC(345.123, 0) 결과 FROM DUAL;
SELECT TRUNC(345.123, 1) 결과 FROM DUAL;
SELECT TRUNC(345.123, 2) 결과 FROM DUAL;
SELECT TRUNC(345.123, -1) 결과1
     , TRUNC(345.123, -2) 결과2 
FROM   DUAL;

--회원 테이블의 마일리지를 12로 나눈 값을 검색
--(소수2째자리 살리기 반올림, 절삭)
-- 1. ROUND('191.666666',2) 결과는?
-- 여기에서 ",2"라는 것은 소수점 2째자리까지 살아남는다는 것임
-- 따라서 191.66이 살아남는데 그 다음 3번째 자리가 6이므로
-- 반올림 되어 191.67로 결과를 도출함
SELECT MEM_MILEAGE
     , ROUND(MEM_MILEAGE / 12, 2) 둘째자리살리기반올림
     , TRUNC(MEM_MILEAGE / 12, 2) 둘째자리살리기버림
FROM   MEMBER;
--상품테이블의 상품명, 원가율( 매입가 / 판매가 )을  비율(%)로
--(반올림 없는 것과 소수 첫째자리 살리기 반올림 비교) 검색하시오 ?
--(Alias는 상품명, 원가율1, 원가율2)
-- 비율(%)는 비율에 100을 곱한값임
--소수점 첫째자리를 살리는 반올림 ->
--ROUND((PROD_COST / PROD_SALE)*100,1) 여기서 ",1"라는 의미는
--소수점 첫째자리를 살린다는 의미이고 두번째자리에서 반올리 처리가 됨
SELECT PROD_NAME
     , (PROD_COST / PROD_SALE)*100 원가율1
     , ROUND((PROD_COST / PROD_SALE)*100,1) 원가율2
FROM   PROD;

--다음 쿼리는 오류가 발생할 것인가?
--왜여? '1992-03-17'은 문자형 데이터인 반면
-- 12000은 숫자형 데이터이므로
-- 숫자와 문자 연산의 경우 숫자가 우선순위가 높으므로
-- 문자가 숫자로 자동형변환함. 그런데 '1992-03-17' 문자열의 경우
-- "-"으로 인해 숫자로 자동형변환될 수 없다.
-- 따라서 '1992-03-17'이라는 문자열을 TO_DATE()함수를 사용하여
-- Date 형식으로 바꾸어주어야 "날짜 + 숫자"가 되어 연산이 가능해진다.
SELECT '1992-03-17' + 12000
FROM   DUAL;

--문제 : 나는 몇 일을 살았는가? TO_DATE('1988-02-14')함수 이용
--단, 밥은 하루에 3번을 먹음.
--      소수점 2째자리까지 살리는 반올림으로 처리하시오.
--ALIAS : 내생일, 산일수, 밥먹은수, 
--밥먹은비용(한끼에 3000원으로 처리)
SELECT TO_DATE('1988-02-14') 내생일
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) 산일수
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) * 3 밥먹은수
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) * 3 * 3000 밥먹은비용
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('2021-01-27'),'YYYY-MM-DD HH24:MI:SS')
FROM   DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM   DUAL;

SELECT SYSDATE - TO_DATE('2021-01-26') 일수
FROM   DUAL;

-- NEXT_DAY(SYSDATE, '월요일') : 오늘 날짜를 기준으로 다가오는 월요일 날짜는?
-- LAST_DAY(SYSDATE)          : 해당 월의 마지막 날짜
SELECT NEXT_DAY(SYSDATE, '금요일')
    ,  LAST_DAY(SYSDATE) 
FROM   DUAL;

--이번달이 며칠이 남았는지 검색하시오?
--ALIAS : 오늘날짜, 이달마지막날짜, 이번달에남은날짜
SELECT SYSDATE AS 오늘날짜
     , LAST_DAY(SYSDATE) AS 이달마지막날짜
     , LAST_DAY(SYSDATE) - SYSDATE AS 이번달에남은날짜
FROM   DUAL;

CREATE TABLE TEMP(
    TEMP_ID VARCHAR2(10),
    REGISTER_ID VARCHAR2(50),
    REGIST_TS TIMESTAMP,
    UPDATER_ID VARCHAR2(50),
    UPDATE_TS TIMESTAMP,
    CONSTRAINT PK_TEMP PRIMARY KEY(TEMP_ID)
);
INSERT INTO TEMP(TEMP_ID, REGISTER_ID, REGIST_TS, UPDATER_ID, UPDATE_TS)
VALUES('P101','admin',SYSTIMESTAMP,'admin',SYSTIMESTAMP);
--트랜잭션 종료 및 변경내역 반영
COMMIT;
SELECT * FROM TEMP;

--스키마(Schema) : 구조
--테이블 스키마 : 컬럼, 자료형, 크기, 제약사항, 키..
--생일이 3월인 회원을 검색하시오
--(ALIAS : 회원ID(MEM_ID), 
-- 회원명(MEM_NAME), 생일(MEM_BIR))75/03/23
/*
"생일이 3월인 회원"이라는 것은 조건이라는 것임
쿼리에서 조건에 해당되는 절은? WHERE
따라서 생일이 3월인 회원을 검색하려면 해당 조건을 WHERE절에서 
처리해줘야함
*/
SELECT MEM_ID   AS 회원ID
     , MEM_NAME AS 회원명 
     , MEM_BIR  AS 생일
     , EXTRACT(MONTH FROM MEM_BIR) AS 월
FROM   MEMBER
WHERE  MEM_BIR LIKE '__/03/__';
--WHERE  MEM_BIR LIKE '%/03/%';
--WHERE  SUBSTR(MEM_BIR,4,2) = '03';
--WHERE  EXTRACT(MONTH FROM MEM_BIR) = 3;

SELECT MEM_BIR FROM MEMBER;
--를 해보면.. 날짜 데이터가 '76/01/15'와 같음을 알 수 있음
--LIKE 구문을 사용해도 되고, EXTRACT 함수를 사용해도 됨 
-- 이 때 EXTRACT 결과는 숫자이므로 3이라는 숫자로써 비교하기
-- SUBSTR함수를 사용해도 되는데 EXTRACT와 다른 점은 
-- SUBSTR함수의 결과는 문자라는 것임

--문제
--입고상품(BUYPROD) 중에 3월 에 입고된 내역을 검색하시오
--ALIAS : 상품코드(BUY_PROD), 입고일자(BUY_DATE)
--, 매입수량(BUY_QTY), 매입단가(BUY_COST)
--EXTRACT 사용하기, SUBSTR 사용하기, LIKE 사용하기
SELECT BUY_PROD AS 상품코드
     , BUY_DATE AS 입고일자
     , BUY_QTY  AS 매입수량
     , BUY_COST AS 매입단가
FROM   BUYPROD
WHERE  1 = 1
--AND    EXTRACT(MONTH FROM BUY_DATE) = 3
--AND    SUBSTR(BUY_DATE,4,2) = '03'
AND    BUY_DATE LIKE '%/03/%'
ORDER BY BUY_DATE;

/*
입고일자 데이터를 보면 "05/01/08"이런 형식으로 되어있음
EXTRACT를 사용하여 BUY_DATE컬럼의 데이터로부터 월을 추출할 수 있음
이 때 EXTRACT함수 결과는 숫자이므로 3이라는 숫자와 비교연산해야 함
SUBSTR('05/01/08',4,2) => 4라는 것은 4번째 글자부터 시작한다는 의미이고
2라는 것은 2글자를 의미하므로 "01"이 추출됨. 이 때 SUBSTR함수의 결과는
문자이므로 '03'이라는 문자형데이터와 비교연산해야함.
LIKE의 경우 '%/03/%'와 비교하면 될 것임. 이 때 %는 와일드카드.
*/


--P.201
SELECT '[' || 'Hello' || ']' "형변환" 
     , '[' || CAST('Hello' AS CHAR(30)) || ']' "형변환" 
     , '[' || CAST('Hello' AS VARCHAR2(30)) || ']' "형변환" 
FROM   DUAL;

SELECT '2018/03/29' + 10
FROM   DUAL;

SELECT CAST('2018/03/29' AS DATE) + 10
FROM   DUAL;

SELECT CAST('1997/12/25' AS DATE) 
FROM   DUAL;

--***
SELECT '2017/01/23' + 1
FROM   DUAL;

SELECT '2017/01/23'
     , TO_DATE('2017/01/23') + 1
     , CAST('2017/01/23' AS DATE) + 1
FROM   DUAL;

--P.202
SELECT SYSDATE
     , TO_CHAR(SYSDATE, 'AD YYYY, CC"세기" ') 
FROM   DUAL;

SELECT TO_DATE('2021-01-27')
FROM   DUAL;

SELECT TO_DATE('2021-01-27','YYYY-MM-DD')
FROM   DUAL;

--***
SELECT TO_CHAR('2017-01-23','YYYY.MM.DD HH24:MI')
FROM   DUAL;
--***
SELECT TO_CHAR(TO_DATE('2008-12-25','YYYY-MM-DD'),'YYYY.MM.DD HH24:MI:SS')
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('2008-12-25'),'YYYY.MM.DD HH24:MI:SS')
FROM   DUAL;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI') 
FROM   DUAL;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE)
    , '"명민호짱"YYYY"년"MM"월"DD"일" HH24:MI') 
FROM   DUAL;

--P.203
--상품테이블에서 상품입고일을 '2008-09-28 12:00:00' 
--형식으로 나오게 검색하시오.
--(Alias 상품명(PROD_NAME), 상품판매가(PROD_SALE)
--, 입고일(PROD_INSDATE))
SELECT PROD_NAME    AS 상품명
     , PROD_SALE    AS PROD_
     , TO_DATE(PROD_INSDATE,'YY/MM/DD') AS prodInsdate  --입고일
FROM   PROD;

--2021-01-27 수업 시작
--회원이름(MEM_NAME)과 생일(MEM_BIR)로 다음처럼 출력되게 작성하시오.(MEMBER)
--김은대님은 1976년 1월 출생이고 태어난 요일은  목요일 
--이쁜이님은 1974년 1월 출생이고 태어난 요일은  월요일 
--신용환님은 1974년 1월 출생이고 태어난 요일은  목요일 
SELECT MEM_NAME || '님은'
     , TO_CHAR(MEM_BIR, 'YYYY"년" MON" 출생이고 태어난 요일은 "DAY')
     , TO_CHAR(MEM_BIR, 'YYYY-MM-DD HH:MI:SS')
FROM   MEMBER;

--결합연산자(||) 연습하기..
--상품코드(PROD_ID), 상품명(PROD_NAME)
--대분류코드는 P101이고, 순번은 000001이다. 
SELECT PROD_ID
     , PROD_NAME
     , '대분류코드는 ' || SUBSTR(PROD_ID,1,4) || '이고, 순번은 '
     || SUBSTR(PROD_ID,5) || '이다.'
FROM   PROD;

--입고테이블(BUYPROD)을 사용하여 다음과 같이 출력하기
--P202000001 상품은 2005년 1월 8일에 18개가 입고됨
SELECT BUY_PROD || ' 상품은 '
     || TO_CHAR(BUY_DATE,'YYYY"년 "MM"월 "DD"일에 "')
     || BUY_QTY || '개가 입고됨'
FROM   BUYPROD;

--문제
--상품 판매가를 다음과 같은 형식으로 출력하시오
--￦230,000 --￦ : ㄹ+한자키
--ALIAS : 상품ID(PROD_ID), 상품명(PROD_NAME)
--, 판매가(PROD_SALE)
SELECT PROD_ID   상품ID
     , PROD_NAME 상품명
     , TO_CHAR(PROD_SALE,'L999,999,999') 판매가
FROM   PROD;

--P.203
--상품테이블에서 상품코드, 상품명, 매입가격, 
-- 소비자가격, 판매가격을 출력하시오. 
-- (단, 가격은 천단위 구분 및 원화표시)
SELECT PROD_ID    상품코드
     , PROD_NAME  상품명
     , TO_CHAR(PROD_COST,'L999,999,999')  매입가격
     , TO_CHAR(PROD_PRICE,'L999,999,999') 소비자가격
     , TO_CHAR(PROD_SALE,'L999,999,999')  판매가격
FROM   PROD;


--P.203
--회원테이블(MEMBER)에서 이쁜이회원(MEM_NAME='이쁜이')의
--회원Id 2~4 문자열을 숫자형으로 치환한 후 
--10을 더하여 새로운 회원ID로 조합하시오 ?
--(Alias는 회원ID(MEM_ID), 조합회원ID)
SELECT SUBSTR(MEM_ID,1,1) 
     || TRIM(TO_CHAR(SUBSTR(MEM_ID,2)+10,'000')) 조합회원ID
FROM   MEMBER;

SELECT MEM_ID 회원ID
     , SUBSTR(MEM_ID,1,1)  조합회원ID
     , SUBSTR(MEM_ID,2)
     , TO_CHAR(SUBSTR(MEM_ID,2) + 10,'099')
     , LPAD(SUBSTR(MEM_ID,2) + 10,3,'0')
     , SUBSTR((1000+TO_NUMBER(SUBSTR(MEM_ID,2))+10),2)
     , REPLACE(SUBSTR(MEM_ID,2) + 10,'11','011')
FROM   MEMBER
WHERE  MEM_NAME='이쁜이';

--P.203
--ORA-01722: invalid number
SELECT '2017-01-24' + 3 
FROM   DUAL;

SELECT TO_DATE('2017-01-24','YYYY-MM-DD') + 3 
FROM   DUAL;

SELECT TO_DATE('2017-01-24') + 3 
FROM   DUAL;

--ORA-01722: invalid number *****
SELECT TO_CHAR('2017-01-24','YYYY-MM-DD HH:MI:SS') 
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('2017-01-24')
            ,'YYYY-MM-DD HH:MI:SS') 
FROM   DUAL;

--ORA-01722: invalid number *****
SELECT TO_CHAR('2017-01-24','YYYY-MM-DD HH:MI:SS') 
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('2017-01-24','YYYY-MM-DD')
            ,'YYYY-MM-DD HH:MI:SS') 
FROM   DUAL;

SELECT '200803101234' + 3
FROM   DUAL;

SELECT TO_DATE('200803101234','YYYYMMDDHHMI')
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('200803101234','YYYY-MM-DD HH:MI')
                ,'YYYY-MM-DD HH24:MI') 
FROM   DUAL;

--P.204
--회원테이블(MEMBER)에서 주민등록번호1(MEM_REGNO1)을
--날짜로 치환한 후 검색하시오
--(Alias는 회원명(MEM_NAME), 주민등록번호1, 
--치환날짜(MEM_REGNO1 활용)
SELECT MEM_NAME   회원명
     , MEM_REGNO1 주민등록번호1
     , TO_CHAR(TO_DATE(MEM_REGNO1),'YYYY-MM-DD') 치환날짜1
     , TO_CHAR(TO_DATE(MEM_REGNO1,'YYMMDD'),'YYYY-MM-DD') 치환날짜2
     , TO_CHAR(TO_DATE(MEM_REGNO1,'YYMMDD'),'"19"YY-MM-DD') 치환날짜3
FROM   MEMBER;

--장바구니 테이블(CART)에서 장바구니번호(CART_NO)를
--날짜로 치환한 후 다음과 같이 출력하기
--2005년 3월 14일
--ALIAS : 장바구니번호, 상품코드, 판매일, 판매수
SELECT CART_NO   장바구니번호
     , CART_PROD 상품코드
     , TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'),'YYYY"년"MM"월"DD"일"')   판매일
     , CART_QTY  판매수량
FROM   CART;

--P.204(2021-01-29)
--거래처테이블에서 거래처명, 담당자 조회
--P.204
--거래처테이블에서 거래처명, 담당자 조회
SELECT BUYER_NAME AS 거래처
     , BUYER_CHARGER AS 담당자
FROM   BUYER;

--거래처 담당자 성씨가  '김 ' 인 데이터를 검색
SELECT BUYER_NAME AS 거래처
     , BUYER_CHARGER AS 담당자
FROM   BUYER
WHERE  1 = 1
AND    BUYER_CHARGER LIKE '김%'
--AND    SUBSTR(BUYER_CHARGER,1,1) = '김'
;

--거래처 담당자 성씨가  '김 ' 이면 NULL로 갱신
SELECT BUYER_NAME      AS "거래처" 
     , BUYER_CHARGER   AS "담당자"
FROM   BUYER
WHERE  BUYER_CHARGER LIKE '김%';

--업데이트 쌔대여
UPDATE BUYER 
SET    BUYER_CHARGER = NULL 
WHERE  BUYER_CHARGER LIKE '김%';

SELECT * FROM BUYER;

--TCL(Transaction Control Language)
COMMIT;

--거래처 담당자 성씨가  '성' 이면 White Space로 갱신
SELECT BUYER_NAME AS "거래처" 
     , BUYER_CHARGER   AS "담당자"
FROM   BUYER
WHERE  BUYER_CHARGER LIKE '성%';

UPDATE BUYER 
SET    BUYER_CHARGER = ''
WHERE  BUYER_CHARGER LIKE '성%';

COMMIT;

SELECT * FROM BUYER;

--P.205
SELECT BUYER_NAME       AS "거래처"
     , BUYER_CHARGER    AS "담당자"
FROM   BUYER
WHERE  BUYER_CHARGER = NULL;

SELECT BUYER_NAME       AS "거래처"
     , BUYER_CHARGER    AS "담당자"
FROM   BUYER
WHERE  BUYER_CHARGER IS NULL;

SELECT BUYER_NAME       AS "거래처"
     , BUYER_CHARGER    AS "담당자"
FROM   BUYER
WHERE  BUYER_CHARGER IS NOT NULL;

SELECT BUYER_NAME       AS "거래처"
     , BUYER_CHARGER    AS "담당자"
FROM   BUYER
WHERE  NOT(BUYER_CHARGER IS NULL);

SELECT * FROM BUYER;

SELECT NULL + 10
     , NULL * 10
FROM   DUAL;

SELECT NVL(NULL,0)+10 
     , 10*NVL(NULL,1) 
     , NULL / 0
FROM   DUAL;

SELECT ROUND(DBMS_RANDOM.VALUE(1,25))
FROM   DUAL;
--서울에 거주중인 회원의 마일리지 데이터를
--NULL로 처리하기.(PC10)
SELECT MEM_NAME
      ,MEM_ADD1
      ,MEM_MILEAGE
FROM MEMBER
WHERE MEM_ADD1 LIKE '%서울%';

UPDATE MEMBER
SET MEM_MILEAGE = NULL
WHERE MEM_ADD1 LIKE '%서울%';

COMMIT;
--회원 성씨가 'ㅂ'을 포함하면 마일리지를 NULL로 갱신(PC21)
SELECT  MEM_NAME,
        MEM_MILEAGE
FROM    MEMBER
WHERE   1 = 1
--AND     MEM_NAME >= '바' AND MEM_NAME <= '빟'
AND     SUBSTR(MEM_NAME,1,1) >= '바' AND SUBSTR(MEM_NAME,1,1) <= '빟'
;

UPDATE  MEMBER
SET     MEM_MILEAGE = ''
WHERE   MEM_NAME >= '바' AND MEM_NAME <= '빟';

COMMIT;

-- 전체회원 마일리지에 100을 더한 수치를 검색하시오
--(Alias는 성명, 마일리지, 변경마일리지 )(PC06)
SELECT MEM_NAME AS 성명
    ,  MEM_MILEAGE AS 마일리지
    ,  NVL(MEM_MILEAGE, 0) + 100 AS 변경마일리지
    ,  NVL2(MEM_MILEAGE, MEM_MILEAGE, 0) + 100 AS 변경마일리지
FROM MEMBER;

--회원 마일리지가 있으면 '정상 회원', Null이면 
--'비정상 회원' 으로   검색하시오 ? (PC05)
--(NVL2 사용, Alias는 성명, 마일리지, 회원상태 )
SELECT MEM_NAME 성명,
        MEM_MILEAGE 마일리지,
        NVL2(MEM_MILEAGE, '정상회원' , '비정상회원') 회원상태
FROM MEMBER;




/*-------------------------------------------------
--P.시퀀스 보충
/*
 Sequence는 연속, 열거, 순서의 의미.
 Sequence객체는 자동적으로 번호를 생성하기 위한 객체. 
 Sequence객체는 테이블과 독립적이므로 여러 곳에서 사용가능.
 Sequence 를 이용하는 경우 
? Primary Key를 설정할 후보키가 없거나 PK를 특별히 의미 있게 
 만들지 않아도 되는 경우
? 자동으로 순서적인 번호가 필요한 경우
*/
--시퀀스 생성
--START WITH : 시작번호
--INCREMENT BY : 증감
CREATE SEQUENCE LPROD_SEQ --OR REPLACE 없음
INCREMENT BY 1
START WITH 1
;

DROP SEQUENCE LPROD_SEQ;
  
--시퀀스 1증가
SELECT SUBSTR(1000 + LPROD_SEQ.NEXTVAL,2) FROM DUAL;

--현재번호 확인
SELECT LPROD_SEQ.CURRVAL FROM DUAL;
  
--사용방법
CREATE TABLE TESTSEQ(
  TS_ID   NUMBER NOT NULL ,
  TS_NAME VARCHAR2(10),
  CONSTRAINT PK_TESTSEQ PRIMARY KEY(TS_ID)
);

CREATE SEQUENCE TESTSEQ_SEQ
INCREMENT BY 1
START WITH 1;

SELECT * FROM USER_SEQUENCES;  

--ORA-08002: sequence TESTSEQ_SEQ.CURRVAL is not yet defined in this session
SELECT TESTSEQ_SEQ.CURRVAL FROM DUAL;

SELECT TESTSEQ_SEQ.NEXTVAL FROM DUAL;

--1
SELECT TESTSEQ_SEQ.CURRVAL FROM DUAL;

INSERT INTO TESTSEQ(TS_ID, TS_NAME) 
VALUES(TESTSEQ_SEQ.NEXTVAL,'글1');

INSERT INTO TESTSEQ(TS_ID, TS_NAME) 
VALUES(TESTSEQ_SEQ.NEXTVAL,'글2');

INSERT INTO TESTSEQ(TS_ID, TS_NAME) 
VALUES(TESTSEQ_SEQ.NEXTVAL,'글3');
  
SELECT * FROM TESTSEQ;

commit;

--시퀀스 연습문제
--AOA 테이블 생성
--( NO NUMBER NOT NULL
--, NAME VARCHAR2(30)
--, BIR  VARCHAR2(20))
--NO컬럼을 PRIMARY KEY로 CONSTRAINT하기
CREATE TABLE AOA(
      NO NUMBER NOT NULL
    , NAME VARCHAR2(30)
    , BIR  VARCHAR2(20)
    , CONSTRAINT PK_AOA PRIMARY KEY(NO)
);

CREATE SEQUENCE AOA_SEQ
INCREMENT BY 1
START WITH 1;

--시퀀스를 사용하여 다음의 데이터를 입력
--1, 지민, 1991-01-08 2, 초아   3, 설현   4, 유나  5, 혜정
SELECT *
FROM   AOA;

/*
Sequence 구문 
   CREATE SEQUENCE sequence_name
	   [ START WITH  n ]
[ INCREMENT BY  n ]
[ MAXVALUE n | NOMAXVALUE ]
[ MINVALUE  n | NOMINVALUE ]
[ CYCLE | NOCYCLE ]
[ CACHE n | NOCACHE ]
[ ORDER | NOORDER ]

? Sequence가 사용되는 경우
  - SELECT문의 SELECT 절 (단, SUBQUERY, VIEW가 아닌)
  - INSERT 문의 SELECT 절
  - INSERT 문의 VALUES 절
  - UPDATE문의 SET 절

 ? Sequence가 제한되는 경우
   - SELECT, DELETE, UPDATE 에서의 서브쿼리
   - VIEW의  QUERY구문
   - DISTINCT 가 있는 SELECT 문
   - GROUP BY, ORDER BY 가 있는 SELECT 문
   - SET 연산자(UNION, INTERSECT, MINUS)가 있는 SELECT 문 
   - SELECT 문의 WHERE 절 
   - CREATE / ALTER TABLE 에서 컬럼의 DEFAULT 값
   - CHECK 제약조건

*/

SELECT DECODE(9
            , 10, 'A'
            , 9, 'B'
            , 8, 'C'
            , 'D')
FROM DUAL;
--p.207
--상품 분류 중  앞의 두 글자가  'P1' 이면 판매가를 10%인상하고
--'P2' 이면 판매가를 15%인상하고,  나머지는 동일 판매가로 
--검색하시오 ? 
--(DECODE 함수 사용, Alias는 상품명, 판매가, 변경판매가 )
SELECT PROD_NAME 상품명
     , PROD_SALE 판매가
     , DECODE(SUBSTR(PROD_LGU,1,2)
            ,'P1',PROD_SALE * 1.1
            ,'P2',PROD_SALE * 1.15
            ,PROD_SALE) 변경판매가
FROM   PROD;

--대전측기사에서는 3월에 생일인(MEM_BIR) 회원을
--대상으로 마일리지를 10% 인상해주는 이벤트를
--시행하고자 한다. 생일이 3월이 아닌 회원은
--짝수인 경우만 5% 인상 처리한다.
--이를 위한 SQL을 작성하시오.
--ALIAS : 회원ID, 회원명, 마일리지, 변경마일리지

