/*
�ۼ��� : �ڼ���
������ : 2022-07-11
������Ʈ�� : ���θ�(����)
07.07 - ����Ű ����
07.11 - TBL_MEMBER ���̺��� M_AUTHCODE �÷� �߰�
*/

--1. ȸ�����̺� (MEMBER)
CREATE TABLE TBL_MEMBER (
    M_ID                   VARCHAR2(15)                 CONSTRAINT PK_MEMBER PRIMARY KEY, -- ȸ�� id
    M_NAME              VARCHAR2(30)                NOT NULL, -- ȸ�� �̸�
    M_PASSWD           VARCHAR2(60)                 NOT NULL, --ȸ�� ��й�ȣ
    M_POSTCODE         CHAR(5)                           NOT NULL, --�����ȣ
    M_ADDR               VARCHAR2(100)                NOT NULL, --�⺻�ּ�
    M_ADDR_D             VARCHAR2(100)              NOT NULL, --�� �ּ�
    M_TEL                    VARCHAR2(15)                   NOT NULL, --��ȭ��ȣ
    M_EMAIL                VARCHAR2(50)                 UNIQUE NOT NULL, --�̸���
    M_EMAIL_ACCEPT    CHAR(1)                               NOT NULL, --�̸��� ���� ����
    M_POINT                 NUMBER  DEFAULT 0           NOT NULL, --������
    M_REGDATE             DATE    DEFAULT SYSDATE    NOT NULL, --������
    M_UPDATEDATE       DATE    DEFAULT SYSDATE     NOT NULL, --������
    M_LASTDATE            DATE    DEFAULT SYSDATE    NOT NULL, --�ֱ� ���ӽð�
    M_AUTHCODE      CHAR(1) DEFAULT 'N'
);
--M_ID, M_NAME, M_PASSWD, M_POSTCODE, M_ADDR, M_ADDR_D, M_TEL, M_EMAIL, M_EMAIL_ACCEPT, M_POINT, M_REGDATE, M_UPDATEDATE, M_LASTDATE, M_AUTHCODE
--m_id, m_name, m_passwd, m_postncode, m_addr, m_addr_d, m_tel, m_email, m_email_accept, m_point, m_regdate, m_updatedate, m_lastdate, m_authcode

--2. ī�װ� ���̺�(CATEGORY)
CREATE TABLE TBL_CATEGORY(
    CT_CODE     NUMBER  CONSTRAINT PK_CATEGORY  PRIMARY KEY, --���� ī�װ��ڵ�
    CT_P_CODE   NUMBER, --�θ� ī�װ� �ڵ�
    CT_NAME     VARCHAR2(50)    NOT NULL --ī�װ���
);
ALTER TABLE TBL_CATEGORY ADD CONSTRAINT FK_CT_P_CODE FOREIGN KEY(CT_P_CODE) REFERENCES TBL_CATEGORY(CT_CODE);
--ct_code, ct_p_code, ct_name
--ACBF
--1�� ī�װ� : ����(1), ����(2), �ƿ���(3), �Ǽ��縮(4), ��Ʈ(5), Ȩ����(6), ��Ȱ�Ѻ�(7), ���(8)

--���� 
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1, NULL, '����');
--���� 2�� ī�װ� : Ƽ����, ��Ʈ, ����, �ܿ��, ������, ȯ�����
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1001, 1, 'Ƽ����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1002, 1, '��Ʈ');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1003, 1, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1004, 1, '�ܿ��');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1005, 1, '������');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1006, 1, 'ȯ�����');

--����
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2, NULL, '����');
--���� 2�� ī�װ� : ����, �ݹ���, ����, ������, �ܿ��, ������, ȯ�����
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2001, 2, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2002, 2, '�ݹ���');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2003, 2, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2004, 2, '������');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2005, 2, '�ܿ��');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2006, 2, '������');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2007, 2, 'ȯ�����');

--�ƿ���
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3, NULL, '�ƿ���');
--�ƿ��� 2�� ī�װ� : ����, ��Ʈ, �����, ����
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3001, 3, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3002, 3, '��Ʈ');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3003, 3, '�����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3004, 3, '����');

--�Ǽ��縮
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4, NULL, '�Ǽ��縮');
-- �Ǽ��縮 2�� ī�װ� : ����, ����, ��Ʈ, ��Ÿ, �Ź�, �Ȱ�
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4001, 4, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4002, 4, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4003, 4, '��Ʈ');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4004, 4, '��Ÿ');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4005, 4, '�Ź�');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4006, 4, '�Ȱ�');

--��Ʈ
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5, NULL, '��Ʈ');
--��Ʈ 2�� ī�װ� : ����, ����, ����, ��Ÿ
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5001, 5, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5002, 5, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5003, 5, '����');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5004, 5, '��Ÿ');

--Ȩ����
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6, NULL, 'Ȩ����');
--Ȩ���� 2�� ī�װ� : ���ڸ�, �ӿ�
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6001, 6, '���ڸ�');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6002, 6, '�ӿ�');

--��Ȱ�Ѻ� 2�� ī�װ� : X ������ �߰� x
--��� 2�� ī�װ� : X ������ �߰� x
SELECT * FROM TBL_CATEGORY;
COMMIT;


--3. ��ǰ ���̺�(PRODUCT)
CREATE TABLE TBL_PRODUCT(
    P_NUM               NUMBER                      CONSTRAINT PK_PRODUCT   PRIMARY KEY, --��ǰ ��ȣ
    F_CT_CODE           NUMBER,                                         --1�� ī�װ� �ڵ�
    S_CT_CODE           NUMBER,                                          --2�� ī�װ� �ڵ�
    P_NAME              VARCHAR2(50)                NOT NULL,    --��ǰ��
    P_COST              NUMBER                          NOT NULL,     --��ǰ����
    P_DISCOUNT       NUMBER                          NOT NULL,    --��ǰ�� ������
    P_COMPANY       VARCHAR2(20)                  NOT NULL,     --��ǰ ���߻�
    P_DETAIL            VARCHAR2(4000)               NOT NULL,    --��ǰ ������
    P_IMAGE              VARCHAR2(100)                   NOT NULL, --��ǰ �̹���
    P_IMAGE_FOLDER              VARCHAR2(50)        NOT NULL, --��ǰ �̹��� ���� ����(��¥)
    P_AMOUNT          NUMBER                            NOT NULL, --��ǰ ���� ����
    P_BUY_OK             CHAR(1) DEFAULT 'Y'         NOT NULL,   --��ǰ ���� ���� ����
    P_REGDATE           DATE    DEFAULT SYSDATE     NOT NULL,   --��ǰ ��ϳ�¥
    P_UPDATEDATE      DATE    DEFAULT SYSDATE     NOT NULL  --��ǰ���� ������¥
);
CREATE SEQUENCE SEQ_PRODUCT;
drop sequence SEQ_PRODUCT;
--p_num, f_ct_code, s_ct_code, p_name, p_cost, p_discount, p_detail, p_image, p_amount, p_buy_ok, p_regdate, p_updatedate, p_company?

INSERT INTO TBL_PRODUCT(p_num, F_CT_CODE, S_CT_CODE, P_NAME, P_COST, P_DISCOUNT, P_COMPANY, P_DETAIL, P_IMAGE, P_IMAGE_FOLDER, P_AMOUNT, P_BUY_OK, P_REGDATE, P_UPDATEDATE)
    SELECT SEQ_PRODUCT.NEXTVAL, F_CT_CODE, S_CT_CODE, P_NAME, P_COST, P_DISCOUNT, P_COMPANY, P_DETAIL, P_IMAGE, P_IMAGE_FOLDER, P_AMOUNT, P_BUY_OK, SYSDATE, SYSDATE
        FROM TBL_PRODUCT;

--4. ��ٱ���(CART)
CREATE TABLE TBL_CART(
    CART_CODE              NUMBER             CONSTRAINT PK_CART  PRIMARY KEY, --��ٱ��� �ڵ�
    P_NUM                     NUMBER            NOT NULL,   --��ǰ��ȣ
    M_ID                        VARCHAR2(15)    NOT NULL,   --ȸ�� ID 
    CART_AMOUNT           NUMBER            NOT NULL    --���ż���

);
CREATE SEQUENCE SEQ_CART;
--cart_code, p_num, m_id, cart_amount?

--5. �ֹ� ���̺� (T_ORDER)
CREATE TABLE TBL_ORDER (
    ORD_CODE              NUMBER              CONSTRAINT  PK_T_ORDER    PRIMARY KEY, -- �ֹ���ȣ
    M_ID                    VARCHAR2(15)       NOT NULL,   --ȸ�� ID 
    ORD_NAME              VARCHAR2(30)        NOT NULL,   --배송받는 사람 이름
    ORD_POSTCODE               CHAR(5)                  NOT NULL,     --배송받는 사람 우편번호
    ORD_ADDR              VARCHAR2(100)       NOT NULL,       --�޴� ��� �⺻�ּ�
    ORD_ADDR_D            VARCHAR2(100)       NOT NULL,       --�޴� ��� ���ּ�
    ORD_TEL                   VARCHAR2(15)                  NOT NULL,       --배송받는 사람 전화번호
    ORD_TOTALCOST         NUMBER                  NOT NULL,       --주문 총 금액
    ORD_DATE                  DATE    DEFAULT SYSDATE,               --�ֹ��� ��¥
    ORD_MESSAGE     VARCHAR2(100)         --배송 메시지
);
--ord_code, m_id, ord_name, ord_post, ord_addr, ord_addr_d, ord_tel, ord_totalcost, ord_date, ord_message
--ORD_CODE, M_ID, ORD_NAME, ORD_POST, ORD_ADDR, ORD_ADDR_D, ORD_TEL, ORD_TOTALCOST, ORD_DATE, ORD_DEFAULT_ADDR

--6. �ֹ� �� ���̺�(T_ORDER_D)
CREATE TABLE TBL_ORDER_D(
    ORD_CODE              NUMBER,                         --�ֹ���ȣ
    P_NUM               NUMBER,                             --��ǰ��ȣ
    ORD_AMOUNT        NUMBER          NOT NULL,   --�ֹ�����
    ORD_COST              NUMBER          NOT NULL,   --�ֹ� ����
    PRIMARY KEY(ORD_CODE, P_NUM),
    CONSTRAINT FK_ORD_P_NUM FOREIGN KEY(P_NUM) REFERENCES TBL_PRODUCT(P_NUM)
);
ALTER TABLE TBL_ORDER_D ADD CONSTRAINT FK_ORD_CODE FOREIGN KEY(ORD_CODE) REFERENCES TBL_ORDER(ORD_CODE);
--ord_code, p_num, ord_amount, ord_cost?

--7. �Խ���(BOARD)
CREATE TABLE TBL_BOARD(
B_NUM NUMBER     CONSTRAINT PK_BOARD  PRIMARY KEY,    --�Խñ� ��ȣ(������)
M_ID VARCHAR2(15) NOT NULL,   --ȸ��id(�Խñ� �ۼ���)
B_TITLE VARCHAR2(100) NOT NULL,   --�Խñ� ����
B_CONTENT     VARCHAR2(4000) NOT NULL,   --�Խñ� ����
B_REGDATE DATE DEFAULT SYSDATE NOT NULL,    --�Խñ� ��ϳ�¥
    CONSTRAINT FK_BOARD_M_ID FOREIGN KEY(M_ID) REFERENCES TBL_MEMBER(M_ID)
);
CREATE SEQUENCE SEQ_BOARD;
--b_num, m_id, b_title, b_content, b_regdate?

--8. ����
CREATE TABLE TBL_REVIEW(
R_NUM NUMBER     CONSTRAINT PK_REVIEW  PRIMARY KEY, --����� ��ȣ
M_ID VARCHAR2(15) NOT NULL,   --ȸ�� id
P_NUM NUMBER NOT NULL,   --��ǰ��ȣ
R_CONTENT VARCHAR2(200) NOT NULL,   --���䳻��
R_SCORE NUMBER NOT NULL,   --���� ����
R_REGDATE DATE DEFAULT SYSDATE NOT NULL,    --���� �ۼ���
    CONSTRAINT FK_REVIEW_M_ID FOREIGN KEY(M_ID) REFERENCES TBL_MEMBER(M_ID),
    CONSTRAINT FK_REVIEW_P_NUM FOREIGN KEY(P_NUM) REFERENCES TBL_PRODUCT(P_NUM)
);
--r_num, m_id, p_num, r_content, r_score, r_regdate?

--9. ������ ���̺� (ADMIN)
CREATE TABLE TBL_ADMIN(
ADMIN_ID VARCHAR2(15)    CONSTRAINT PK_ADMIN  PRIMARY KEY,    --������ id
ADMIN_PW VARCHAR2(60) NOT NULL,   --������ ��й�ȣ
ADMIN_NAME VARCHAR2(100) NOT NULL,   --�����ڸ�
ADMIN_LASTDATE DATE DEFAULT SYSDATE NOT NULL    --���ӽð�
);

--admin_id, admin_pw, admin_name, admin_lastdate
--ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_LASTDATE
--������ ���� ���� - ���̵�: admin,��й�ȣ: 1234(��ȣȭ�� ��й�ȣ �����ؿ�), �̸�: ������
INSERT INTO TBL_ADMIN (admin_id, admin_pw, admin_name, admin_lastdate)
    VALUES('admin', '$2a$10$RFjRcMcQVPZ9s3OVmwuUUOrJ34pEbGtp.2jB8QJv/56YpfpUE470q', '������', sysdate);
commit;