--P.198
SELECT ROUND(345.123, -2) ��� FROM DUAL;
SELECT ROUND(345.123, -1) ��� FROM DUAL;
SELECT ROUND(345.523, 0) ��� FROM DUAL;
SELECT ROUND(345.123, 1) ��� FROM DUAL;
SELECT ROUND(345.123, 2) ��� FROM DUAL;
SELECT ROUND(345.123, -2) ��� FROM DUAL;
SELECT ROUND(345.123, -1) ��� FROM DUAL;

SELECT TRUNC(345.123, 0) ��� FROM DUAL;
SELECT TRUNC(345.123, 1) ��� FROM DUAL;
SELECT TRUNC(345.123, 2) ��� FROM DUAL;
SELECT TRUNC(345.123, -1) ���1
     , TRUNC(345.123, -2) ���2 
FROM   DUAL;

--ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
--(�Ҽ�2°�ڸ� �츮�� �ݿø�, ����)
-- 1. ROUND('191.666666',2) �����?
-- ���⿡�� ",2"��� ���� �Ҽ��� 2°�ڸ����� ��Ƴ��´ٴ� ����
-- ���� 191.66�� ��Ƴ��µ� �� ���� 3��° �ڸ��� 6�̹Ƿ�
-- �ݿø� �Ǿ� 191.67�� ����� ������
SELECT MEM_MILEAGE
     , ROUND(MEM_MILEAGE / 12, 2) ��°�ڸ��츮��ݿø�
     , TRUNC(MEM_MILEAGE / 12, 2) ��°�ڸ��츮�����
FROM   MEMBER;
--��ǰ���̺��� ��ǰ��, ������( ���԰� / �ǸŰ� )��  ����(%)��
--(�ݿø� ���� �Ͱ� �Ҽ� ù°�ڸ� �츮�� �ݿø� ��) �˻��Ͻÿ� ?
--(Alias�� ��ǰ��, ������1, ������2)
-- ����(%)�� ������ 100�� ���Ѱ���
--�Ҽ��� ù°�ڸ��� �츮�� �ݿø� ->
--ROUND((PROD_COST / PROD_SALE)*100,1) ���⼭ ",1"��� �ǹ̴�
--�Ҽ��� ù°�ڸ��� �츰�ٴ� �ǹ��̰� �ι�°�ڸ����� �ݿø� ó���� ��
SELECT PROD_NAME
     , (PROD_COST / PROD_SALE)*100 ������1
     , ROUND((PROD_COST / PROD_SALE)*100,1) ������2
FROM   PROD;

--���� ������ ������ �߻��� ���ΰ�?
--�ֿ�? '1992-03-17'�� ������ �������� �ݸ�
-- 12000�� ������ �������̹Ƿ�
-- ���ڿ� ���� ������ ��� ���ڰ� �켱������ �����Ƿ�
-- ���ڰ� ���ڷ� �ڵ�����ȯ��. �׷��� '1992-03-17' ���ڿ��� ���
-- "-"���� ���� ���ڷ� �ڵ�����ȯ�� �� ����.
-- ���� '1992-03-17'�̶�� ���ڿ��� TO_DATE()�Լ��� ����Ͽ�
-- Date �������� �ٲپ��־�� "��¥ + ����"�� �Ǿ� ������ ����������.
SELECT '1992-03-17' + 12000
FROM   DUAL;

--���� : ���� �� ���� ��Ҵ°�? TO_DATE('1988-02-14')�Լ� �̿�
--��, ���� �Ϸ翡 3���� ����.
--      �Ҽ��� 2°�ڸ����� �츮�� �ݿø����� ó���Ͻÿ�.
--ALIAS : ������, ���ϼ�, �������, 
--��������(�ѳ��� 3000������ ó��)
SELECT TO_DATE('1988-02-14') ������
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) ���ϼ�
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) * 3 �������
     , ROUND((SYSDATE - TO_DATE('1988-02-14')),2) * 3 * 3000 ��������
FROM   DUAL;

SELECT TO_CHAR(TO_DATE('2021-01-27'),'YYYY-MM-DD HH24:MI:SS')
FROM   DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM   DUAL;

SELECT SYSDATE - TO_DATE('2021-01-26') �ϼ�
FROM   DUAL;

-- NEXT_DAY(SYSDATE, '������') : ���� ��¥�� �������� �ٰ����� ������ ��¥��?
-- LAST_DAY(SYSDATE)          : �ش� ���� ������ ��¥
SELECT NEXT_DAY(SYSDATE, '�ݿ���')
    ,  LAST_DAY(SYSDATE) 
FROM   DUAL;

--�̹����� ��ĥ�� ���Ҵ��� �˻��Ͻÿ�?
--ALIAS : ���ó�¥, �̴޸�������¥, �̹��޿�������¥
SELECT SYSDATE AS ���ó�¥
     , LAST_DAY(SYSDATE) AS �̴޸�������¥
     , LAST_DAY(SYSDATE) - SYSDATE AS �̹��޿�������¥
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
--Ʈ����� ���� �� ���泻�� �ݿ�
COMMIT;
SELECT * FROM TEMP;

--��Ű��(Schema) : ����
--���̺� ��Ű�� : �÷�, �ڷ���, ũ��, �������, Ű..
--������ 3���� ȸ���� �˻��Ͻÿ�
--(ALIAS : ȸ��ID(MEM_ID), 
-- ȸ����(MEM_NAME), ����(MEM_BIR))75/03/23
/*
"������ 3���� ȸ��"�̶�� ���� �����̶�� ����
�������� ���ǿ� �ش�Ǵ� ����? WHERE
���� ������ 3���� ȸ���� �˻��Ϸ��� �ش� ������ WHERE������ 
ó���������
*/
SELECT MEM_ID   AS ȸ��ID
     , MEM_NAME AS ȸ���� 
     , MEM_BIR  AS ����
     , EXTRACT(MONTH FROM MEM_BIR) AS ��
FROM   MEMBER
WHERE  MEM_BIR LIKE '__/03/__';
--WHERE  MEM_BIR LIKE '%/03/%';
--WHERE  SUBSTR(MEM_BIR,4,2) = '03';
--WHERE  EXTRACT(MONTH FROM MEM_BIR) = 3;

SELECT MEM_BIR FROM MEMBER;
--�� �غ���.. ��¥ �����Ͱ� '76/01/15'�� ������ �� �� ����
--LIKE ������ ����ص� �ǰ�, EXTRACT �Լ��� ����ص� �� 
-- �� �� EXTRACT ����� �����̹Ƿ� 3�̶�� ���ڷν� ���ϱ�
-- SUBSTR�Լ��� ����ص� �Ǵµ� EXTRACT�� �ٸ� ���� 
-- SUBSTR�Լ��� ����� ���ڶ�� ����

--����
--�԰��ǰ(BUYPROD) �߿� 3�� �� �԰�� ������ �˻��Ͻÿ�
--ALIAS : ��ǰ�ڵ�(BUY_PROD), �԰�����(BUY_DATE)
--, ���Լ���(BUY_QTY), ���Դܰ�(BUY_COST)
--EXTRACT ����ϱ�, SUBSTR ����ϱ�, LIKE ����ϱ�
SELECT BUY_PROD AS ��ǰ�ڵ�
     , BUY_DATE AS �԰�����
     , BUY_QTY  AS ���Լ���
     , BUY_COST AS ���Դܰ�
FROM   BUYPROD
WHERE  1 = 1
--AND    EXTRACT(MONTH FROM BUY_DATE) = 3
--AND    SUBSTR(BUY_DATE,4,2) = '03'
AND    BUY_DATE LIKE '%/03/%'
ORDER BY BUY_DATE;

/*
�԰����� �����͸� ���� "05/01/08"�̷� �������� �Ǿ�����
EXTRACT�� ����Ͽ� BUY_DATE�÷��� �����ͷκ��� ���� ������ �� ����
�� �� EXTRACT�Լ� ����� �����̹Ƿ� 3�̶�� ���ڿ� �񱳿����ؾ� ��
SUBSTR('05/01/08',4,2) => 4��� ���� 4��° ���ں��� �����Ѵٴ� �ǹ��̰�
2��� ���� 2���ڸ� �ǹ��ϹǷ� "01"�� �����. �� �� SUBSTR�Լ��� �����
�����̹Ƿ� '03'�̶�� �����������Ϳ� �񱳿����ؾ���.
LIKE�� ��� '%/03/%'�� ���ϸ� �� ����. �� �� %�� ���ϵ�ī��.
*/


--P.201
SELECT '[' || 'Hello' || ']' "����ȯ" 
     , '[' || CAST('Hello' AS CHAR(30)) || ']' "����ȯ" 
     , '[' || CAST('Hello' AS VARCHAR2(30)) || ']' "����ȯ" 
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
     , TO_CHAR(SYSDATE, 'AD YYYY, CC"����" ') 
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
    , '"���ȣ¯"YYYY"��"MM"��"DD"��" HH24:MI') 
FROM   DUAL;

--P.203
--��ǰ���̺��� ��ǰ�԰����� '2008-09-28 12:00:00' 
--�������� ������ �˻��Ͻÿ�.
--(Alias ��ǰ��(PROD_NAME), ��ǰ�ǸŰ�(PROD_SALE)
--, �԰���(PROD_INSDATE))
SELECT PROD_NAME    AS ��ǰ��
     , PROD_SALE    AS PROD_
     , TO_DATE(PROD_INSDATE,'YY/MM/DD') AS prodInsdate  --�԰���
FROM   PROD;

--2021-01-27 ���� ����
--ȸ���̸�(MEM_NAME)�� ����(MEM_BIR)�� ����ó�� ��µǰ� �ۼ��Ͻÿ�.(MEMBER)
--��������� 1976�� 1�� ����̰� �¾ ������  ����� 
--�̻��̴��� 1974�� 1�� ����̰� �¾ ������  ������ 
--�ſ�ȯ���� 1974�� 1�� ����̰� �¾ ������  ����� 
SELECT MEM_NAME || '����'
     , TO_CHAR(MEM_BIR, 'YYYY"��" MON" ����̰� �¾ ������ "DAY')
     , TO_CHAR(MEM_BIR, 'YYYY-MM-DD HH:MI:SS')
FROM   MEMBER;

--���տ�����(||) �����ϱ�..
--��ǰ�ڵ�(PROD_ID), ��ǰ��(PROD_NAME)
--��з��ڵ�� P101�̰�, ������ 000001�̴�. 
SELECT PROD_ID
     , PROD_NAME
     , '��з��ڵ�� ' || SUBSTR(PROD_ID,1,4) || '�̰�, ������ '
     || SUBSTR(PROD_ID,5) || '�̴�.'
FROM   PROD;

--�԰����̺�(BUYPROD)�� ����Ͽ� ������ ���� ����ϱ�
--P202000001 ��ǰ�� 2005�� 1�� 8�Ͽ� 18���� �԰��
SELECT BUY_PROD || ' ��ǰ�� '
     || TO_CHAR(BUY_DATE,'YYYY"�� "MM"�� "DD"�Ͽ� "')
     || BUY_QTY || '���� �԰��'
FROM   BUYPROD;

--����
--��ǰ �ǸŰ��� ������ ���� �������� ����Ͻÿ�
--��230,000 --�� : ��+����Ű
--ALIAS : ��ǰID(PROD_ID), ��ǰ��(PROD_NAME)
--, �ǸŰ�(PROD_SALE)
SELECT PROD_ID   ��ǰID
     , PROD_NAME ��ǰ��
     , TO_CHAR(PROD_SALE,'L999,999,999') �ǸŰ�
FROM   PROD;

--P.203
--��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, 
-- �Һ��ڰ���, �ǸŰ����� ����Ͻÿ�. 
-- (��, ������ õ���� ���� �� ��ȭǥ��)
SELECT PROD_ID    ��ǰ�ڵ�
     , PROD_NAME  ��ǰ��
     , TO_CHAR(PROD_COST,'L999,999,999')  ���԰���
     , TO_CHAR(PROD_PRICE,'L999,999,999') �Һ��ڰ���
     , TO_CHAR(PROD_SALE,'L999,999,999')  �ǸŰ���
FROM   PROD;


--P.203
--ȸ�����̺�(MEMBER)���� �̻���ȸ��(MEM_NAME='�̻���')��
--ȸ��Id 2~4 ���ڿ��� ���������� ġȯ�� �� 
--10�� ���Ͽ� ���ο� ȸ��ID�� �����Ͻÿ� ?
--(Alias�� ȸ��ID(MEM_ID), ����ȸ��ID)
SELECT SUBSTR(MEM_ID,1,1) 
     || TRIM(TO_CHAR(SUBSTR(MEM_ID,2)+10,'000')) ����ȸ��ID
FROM   MEMBER;

SELECT MEM_ID ȸ��ID
     , SUBSTR(MEM_ID,1,1)  ����ȸ��ID
     , SUBSTR(MEM_ID,2)
     , TO_CHAR(SUBSTR(MEM_ID,2) + 10,'099')
     , LPAD(SUBSTR(MEM_ID,2) + 10,3,'0')
     , SUBSTR((1000+TO_NUMBER(SUBSTR(MEM_ID,2))+10),2)
     , REPLACE(SUBSTR(MEM_ID,2) + 10,'11','011')
FROM   MEMBER
WHERE  MEM_NAME='�̻���';

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
--ȸ�����̺�(MEMBER)���� �ֹε�Ϲ�ȣ1(MEM_REGNO1)��
--��¥�� ġȯ�� �� �˻��Ͻÿ�
--(Alias�� ȸ����(MEM_NAME), �ֹε�Ϲ�ȣ1, 
--ġȯ��¥(MEM_REGNO1 Ȱ��)
SELECT MEM_NAME   ȸ����
     , MEM_REGNO1 �ֹε�Ϲ�ȣ1
     , TO_CHAR(TO_DATE(MEM_REGNO1),'YYYY-MM-DD') ġȯ��¥1
     , TO_CHAR(TO_DATE(MEM_REGNO1,'YYMMDD'),'YYYY-MM-DD') ġȯ��¥2
     , TO_CHAR(TO_DATE(MEM_REGNO1,'YYMMDD'),'"19"YY-MM-DD') ġȯ��¥3
FROM   MEMBER;

--��ٱ��� ���̺�(CART)���� ��ٱ��Ϲ�ȣ(CART_NO)��
--��¥�� ġȯ�� �� ������ ���� ����ϱ�
--2005�� 3�� 14��
--ALIAS : ��ٱ��Ϲ�ȣ, ��ǰ�ڵ�, �Ǹ���, �Ǹż�
SELECT CART_NO   ��ٱ��Ϲ�ȣ
     , CART_PROD ��ǰ�ڵ�
     , TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'),'YYYY"��"MM"��"DD"��"')   �Ǹ���
     , CART_QTY  �Ǹż���
FROM   CART;

--P.204(2021-01-29)
--�ŷ�ó���̺��� �ŷ�ó��, ����� ��ȸ
--P.204
--�ŷ�ó���̺��� �ŷ�ó��, ����� ��ȸ
SELECT BUYER_NAME AS �ŷ�ó
     , BUYER_CHARGER AS �����
FROM   BUYER;

--�ŷ�ó ����� ������  '�� ' �� �����͸� �˻�
SELECT BUYER_NAME AS �ŷ�ó
     , BUYER_CHARGER AS �����
FROM   BUYER
WHERE  1 = 1
AND    BUYER_CHARGER LIKE '��%'
--AND    SUBSTR(BUYER_CHARGER,1,1) = '��'
;

--�ŷ�ó ����� ������  '�� ' �̸� NULL�� ����
SELECT BUYER_NAME      AS "�ŷ�ó" 
     , BUYER_CHARGER   AS "�����"
FROM   BUYER
WHERE  BUYER_CHARGER LIKE '��%';

--������Ʈ �ش뿩
UPDATE BUYER 
SET    BUYER_CHARGER = NULL 
WHERE  BUYER_CHARGER LIKE '��%';

SELECT * FROM BUYER;

--TCL(Transaction Control Language)
COMMIT;

--�ŷ�ó ����� ������  '��' �̸� White Space�� ����
SELECT BUYER_NAME AS "�ŷ�ó" 
     , BUYER_CHARGER   AS "�����"
FROM   BUYER
WHERE  BUYER_CHARGER LIKE '��%';

UPDATE BUYER 
SET    BUYER_CHARGER = ''
WHERE  BUYER_CHARGER LIKE '��%';

COMMIT;

SELECT * FROM BUYER;

--P.205
SELECT BUYER_NAME       AS "�ŷ�ó"
     , BUYER_CHARGER    AS "�����"
FROM   BUYER
WHERE  BUYER_CHARGER = NULL;

SELECT BUYER_NAME       AS "�ŷ�ó"
     , BUYER_CHARGER    AS "�����"
FROM   BUYER
WHERE  BUYER_CHARGER IS NULL;

SELECT BUYER_NAME       AS "�ŷ�ó"
     , BUYER_CHARGER    AS "�����"
FROM   BUYER
WHERE  BUYER_CHARGER IS NOT NULL;

SELECT BUYER_NAME       AS "�ŷ�ó"
     , BUYER_CHARGER    AS "�����"
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
--���￡ �������� ȸ���� ���ϸ��� �����͸�
--NULL�� ó���ϱ�.(PC10)
SELECT MEM_NAME
      ,MEM_ADD1
      ,MEM_MILEAGE
FROM MEMBER
WHERE MEM_ADD1 LIKE '%����%';

UPDATE MEMBER
SET MEM_MILEAGE = NULL
WHERE MEM_ADD1 LIKE '%����%';

COMMIT;
--ȸ�� ������ '��'�� �����ϸ� ���ϸ����� NULL�� ����(PC21)
SELECT  MEM_NAME,
        MEM_MILEAGE
FROM    MEMBER
WHERE   1 = 1
--AND     MEM_NAME >= '��' AND MEM_NAME <= '��'
AND     SUBSTR(MEM_NAME,1,1) >= '��' AND SUBSTR(MEM_NAME,1,1) <= '��'
;

UPDATE  MEMBER
SET     MEM_MILEAGE = ''
WHERE   MEM_NAME >= '��' AND MEM_NAME <= '��';

COMMIT;

-- ��üȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻��Ͻÿ�
--(Alias�� ����, ���ϸ���, ���渶�ϸ��� )(PC06)
SELECT MEM_NAME AS ����
    ,  MEM_MILEAGE AS ���ϸ���
    ,  NVL(MEM_MILEAGE, 0) + 100 AS ���渶�ϸ���
    ,  NVL2(MEM_MILEAGE, MEM_MILEAGE, 0) + 100 AS ���渶�ϸ���
FROM MEMBER;

--ȸ�� ���ϸ����� ������ '���� ȸ��', Null�̸� 
--'������ ȸ��' ����   �˻��Ͻÿ� ? (PC05)
--(NVL2 ���, Alias�� ����, ���ϸ���, ȸ������ )
SELECT MEM_NAME ����,
        MEM_MILEAGE ���ϸ���,
        NVL2(MEM_MILEAGE, '����ȸ��' , '������ȸ��') ȸ������
FROM MEMBER;




/*-------------------------------------------------
--P.������ ����
/*
 Sequence�� ����, ����, ������ �ǹ�.
 Sequence��ü�� �ڵ������� ��ȣ�� �����ϱ� ���� ��ü. 
 Sequence��ü�� ���̺�� �������̹Ƿ� ���� ������ ��밡��.
 Sequence �� �̿��ϴ� ��� 
? Primary Key�� ������ �ĺ�Ű�� ���ų� PK�� Ư���� �ǹ� �ְ� 
 ������ �ʾƵ� �Ǵ� ���
? �ڵ����� �������� ��ȣ�� �ʿ��� ���
*/
--������ ����
--START WITH : ���۹�ȣ
--INCREMENT BY : ����
CREATE SEQUENCE LPROD_SEQ --OR REPLACE ����
INCREMENT BY 1
START WITH 1
;

DROP SEQUENCE LPROD_SEQ;
  
--������ 1����
SELECT SUBSTR(1000 + LPROD_SEQ.NEXTVAL,2) FROM DUAL;

--�����ȣ Ȯ��
SELECT LPROD_SEQ.CURRVAL FROM DUAL;
  
--�����
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
VALUES(TESTSEQ_SEQ.NEXTVAL,'��1');

INSERT INTO TESTSEQ(TS_ID, TS_NAME) 
VALUES(TESTSEQ_SEQ.NEXTVAL,'��2');

INSERT INTO TESTSEQ(TS_ID, TS_NAME) 
VALUES(TESTSEQ_SEQ.NEXTVAL,'��3');
  
SELECT * FROM TESTSEQ;

commit;

--������ ��������
--AOA ���̺� ����
--( NO NUMBER NOT NULL
--, NAME VARCHAR2(30)
--, BIR  VARCHAR2(20))
--NO�÷��� PRIMARY KEY�� CONSTRAINT�ϱ�
CREATE TABLE AOA(
      NO NUMBER NOT NULL
    , NAME VARCHAR2(30)
    , BIR  VARCHAR2(20)
    , CONSTRAINT PK_AOA PRIMARY KEY(NO)
);

CREATE SEQUENCE AOA_SEQ
INCREMENT BY 1
START WITH 1;

--�������� ����Ͽ� ������ �����͸� �Է�
--1, ����, 1991-01-08 2, �ʾ�   3, ����   4, ����  5, ����
SELECT *
FROM   AOA;

/*
Sequence ���� 
   CREATE SEQUENCE sequence_name
	   [ START WITH  n ]
[ INCREMENT BY  n ]
[ MAXVALUE n | NOMAXVALUE ]
[ MINVALUE  n | NOMINVALUE ]
[ CYCLE | NOCYCLE ]
[ CACHE n | NOCACHE ]
[ ORDER | NOORDER ]

? Sequence�� ���Ǵ� ���
  - SELECT���� SELECT �� (��, SUBQUERY, VIEW�� �ƴ�)
  - INSERT ���� SELECT ��
  - INSERT ���� VALUES ��
  - UPDATE���� SET ��

 ? Sequence�� ���ѵǴ� ���
   - SELECT, DELETE, UPDATE ������ ��������
   - VIEW��  QUERY����
   - DISTINCT �� �ִ� SELECT ��
   - GROUP BY, ORDER BY �� �ִ� SELECT ��
   - SET ������(UNION, INTERSECT, MINUS)�� �ִ� SELECT �� 
   - SELECT ���� WHERE �� 
   - CREATE / ALTER TABLE ���� �÷��� DEFAULT ��
   - CHECK ��������

*/

SELECT DECODE(9
            , 10, 'A'
            , 9, 'B'
            , 8, 'C'
            , 'D')
FROM DUAL;
--p.207
--��ǰ �з� ��  ���� �� ���ڰ�  'P1' �̸� �ǸŰ��� 10%�λ��ϰ�
--'P2' �̸� �ǸŰ��� 15%�λ��ϰ�,  �������� ���� �ǸŰ��� 
--�˻��Ͻÿ� ? 
--(DECODE �Լ� ���, Alias�� ��ǰ��, �ǸŰ�, �����ǸŰ� )
SELECT PROD_NAME ��ǰ��
     , PROD_SALE �ǸŰ�
     , DECODE(SUBSTR(PROD_LGU,1,2)
            ,'P1',PROD_SALE * 1.1
            ,'P2',PROD_SALE * 1.15
            ,PROD_SALE) �����ǸŰ�
FROM   PROD;

--��������翡���� 3���� ������(MEM_BIR) ȸ����
--������� ���ϸ����� 10% �λ����ִ� �̺�Ʈ��
--�����ϰ��� �Ѵ�. ������ 3���� �ƴ� ȸ����
--¦���� ��츸 5% �λ� ó���Ѵ�.
--�̸� ���� SQL�� �ۼ��Ͻÿ�.
--ALIAS : ȸ��ID, ȸ����, ���ϸ���, ���渶�ϸ���

