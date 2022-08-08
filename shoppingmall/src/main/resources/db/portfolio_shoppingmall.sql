/*
작성자 : 박수아
편집일 : 2022-07-11
프로젝트명 : 쇼핑몰(개인)
07.07 - 참조키 설정
07.11 - TBL_MEMBER 테이블의 M_AUTHCODE 컬럼 추가
*/

--1. 회원테이블 (MEMBER)
CREATE TABLE TBL_MEMBER (
    M_ID                   VARCHAR2(15)                 CONSTRAINT PK_MEMBER PRIMARY KEY, -- 회원 id
    M_NAME              VARCHAR2(30)                NOT NULL, -- 회원 이름
    M_PASSWD           VARCHAR2(60)                 NOT NULL, --회원 비밀번호
    M_POSTCODE         CHAR(5)                           NOT NULL, --우편번호
    M_ADDR               VARCHAR2(100)                NOT NULL, --기본주소
    M_ADDR_D             VARCHAR2(100)              NOT NULL, --상세 주소
    M_TEL                    VARCHAR2(15)                   NOT NULL, --전화번호
    M_EMAIL                VARCHAR2(50)                 UNIQUE NOT NULL, --이메일
    M_EMAIL_ACCEPT    CHAR(1)                               NOT NULL, --이메일 수신 여부
    M_POINT                 NUMBER  DEFAULT 0           NOT NULL, --적립금
    M_REGDATE             DATE    DEFAULT SYSDATE    NOT NULL, --가입일
    M_UPDATEDATE       DATE    DEFAULT SYSDATE     NOT NULL, --수정일
    M_LASTDATE            DATE    DEFAULT SYSDATE    NOT NULL, --최근 접속시간
    M_AUTHCODE      CHAR(1) DEFAULT 'N'
);
--M_ID, M_NAME, M_PASSWD, M_POSTNUM, M_ADDR, M_ADDR_D, M_TEL, M_EMAIL, M_EMAIL_ACCEPT, M_POINT, M_REGDATE, M_UPDATEDATE, M_LASTDATE, M_AUTHCODE
--m_id, m_name, m_passwd, m_postnum, m_addr, m_addr_d, m_tel, m_email, m_email_accept, m_point, m_regdate, m_updatedate, m_lastdate, m_authcode

--2. 카테고리 테이블(CATEGORY)
CREATE TABLE TBL_CATEGORY(
    CT_CODE     NUMBER  CONSTRAINT PK_CATEGORY  PRIMARY KEY, --현재 카테고리코드
    CT_P_CODE   NUMBER, --부모 카테고리 코드
    CT_NAME     VARCHAR2(50)    NOT NULL --카테고리명
);
ALTER TABLE TBL_CATEGORY ADD CONSTRAINT FK_CT_P_CODE FOREIGN KEY(CT_P_CODE) REFERENCES TBL_CATEGORY(CT_CODE);
--ct_code, ct_p_code, ct_name
--ACBF
--1차 카테고리 : 상의(1), 하의(2), 아우터(3), 악세사리(4), 수트(5), 홈웨어(6), 생활한복(7), 운동복(8)

--상의 
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1, NULL, '상의');
--상의 2차 카테고리 : 티셔츠, 니트, 셔츠, 겨울용, 여름용, 환절기용
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1001, 1, '티셔츠');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1002, 1, '니트');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1003, 1, '셔츠');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1004, 1, '겨울용');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1005, 1, '여름용');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (1006, 1, '환절기용');

--하의
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2, NULL, '하의');
--하의 2차 카테고리 : 팬츠, 반바지, 데님, 슬랙스, 겨울용, 여름용, 환절기용
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2001, 2, '팬츠');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2002, 2, '반바지');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2003, 2, '데님');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2004, 2, '슬랙스');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2005, 2, '겨울용');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2006, 2, '여름용');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (2007, 2, '환절기용');

--아우터
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3, NULL, '아우터');
--아우터 2차 카테고리 : 자켓, 코트, 가디건, 점퍼
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3001, 3, '자켓');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3002, 3, '코트');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3003, 3, '가디건');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (3004, 3, '점퍼');

--악세사리
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4, NULL, '악세사리');
-- 악세사리 2차 카테고리 : 모자, 가방, 벨트, 기타, 신발, 안경
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4001, 4, '모자');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4002, 4, '가방');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4003, 4, '벨트');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4004, 4, '기타');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4005, 4, '신발');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (4006, 4, '안경');

--수트
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5, NULL, '수트');
--수트 2차 카테고리 : 자켓, 팬츠, 셔츠, 기타
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5001, 5, '자켓');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5002, 5, '팬츠');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5003, 5, '셔츠');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (5004, 5, '기타');

--홈웨어
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6, NULL, '홈웨어');
--홈웨어 2차 카테고리 : 파자마, 속옷
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6001, 6, '파자마');
INSERT INTO TBL_CATEGORY (CT_CODE, CT_P_CODE, CT_NAME) VALUES (6002, 6, '속옷');

--생활한복 2차 카테고리 : X 데이터 추가 x
--운동복 2차 카테고리 : X 데이터 추가 x
SELECT * FROM TBL_CATEGORY;
COMMIT;


--3. 상품 테이블(PRODUCT)
CREATE TABLE TBL_PRODUCT(
    P_NUM               NUMBER                      CONSTRAINT PK_PRODUCT   PRIMARY KEY, --상품 번호
    F_CT_CODE           NUMBER,                                         --1차 카테고리 코드
    S_CT_CODE           NUMBER,                                          --2차 카테고리 코드
    P_NAME              VARCHAR2(50)                NOT NULL,    --상품명
    P_COST              NUMBER                          NOT NULL,     --상품가격
    P_DISCOUNT       NUMBER                          NOT NULL,    --상품의 할인율
    P_COMPANY       VARCHAR2(20)                  NOT NULL,     --상품 개발사
    P_DETAIL            VARCHAR2(4000)               NOT NULL,    --상품 상세정보
    P_IMAGE              VARCHAR2(100)                   NOT NULL, --상품 이미지
    P_IMAGE_FOLDER              VARCHAR2(50)        NOT NULL, --상품 이미지 저장 폴더(날짜)
    P_AMOUNT          NUMBER                            NOT NULL, --상품 남은 수량
    P_BUY_OK             CHAR(1) DEFAULT 'Y'         NOT NULL,   --상품 구매 가능 여부
    P_REGDATE           DATE    DEFAULT SYSDATE     NOT NULL,   --상품 등록날짜
    P_UPDATEDATE      DATE    DEFAULT SYSDATE     NOT NULL  --상품정보 수정날짜
);
CREATE SEQUENCE SEQ_PRODUCT_NUM;
drop sequence SEQ_CART;
--p_num, f_ct_code, s_ct_code, p_name, p_cost, p_discount, p_detail, p_image, p_amount, p_buy_ok, p_regdate, p_updatedate, p_company
P_NUM, F_CT_CODE, S_CT_CODE, P_NAME, P_COST, P_DISCOUNT, P_DETAIL, P_IMAGE, P_AMOUNT, P_BUY_OK, P_REGDATE, P_UPDATEDATE, P_COMPANY
p_image, P_IMAGE_FOLDER
INSERT INTO TBL_PRODUCT(p_num, F_CT_CODE, S_CT_CODE, P_NAME, P_COST, P_DISCOUNT, P_COMPANY, P_DETAIL, P_IMAGE, P_IMAGE_FOLDER, P_AMOUNT, P_BUY_OK, P_REGDATE, P_UPDATEDATE)
    SELECT SEQ_PRODUCT.NEXTVAL, F_CT_CODE, S_CT_CODE, P_NAME, P_COST, P_DISCOUNT, P_COMPANY, P_DETAIL, P_IMAGE, P_IMAGE_FOLDER, P_AMOUNT, P_BUY_OK, SYSDATE, SYSDATE
        FROM TBL_PRODUCT;

--4. 장바구니(CART)
CREATE TABLE TBL_CART(
    CART_CODE              NUMBER             CONSTRAINT PK_CART  PRIMARY KEY, --장바구니 코드
    P_NUM                     NUMBER            NOT NULL,   --상품번호
    M_ID                        VARCHAR2(15)    NOT NULL,   --회원 ID 
    CART_AMOUNT           NUMBER            NOT NULL    --구매수량

);
CREATE SEQUENCE SEQ_CART_code;

--cart_code, p_num, m_id, cart_amount?

--아이디, 상품번호, 상품수량, 이미지
CREATE TABLE TBL_ORDER_PRODUCT (
    
);
--5. 주문 테이블 (T_ORDER)
CREATE TABLE TBL_ORDER (
    ORD_CODE              NUMBER              CONSTRAINT  PK_T_ORDER    PRIMARY KEY, -- 주문번호
    M_ID                    VARCHAR2(15)       NOT NULL,   --회원 ID 
    ORD_NAME              VARCHAR2(30)        NOT NULL,   --받는 사람 이름
    ORD_POSTCODE               CHAR(5)                  NOT NULL,     --받는 사람 우편번호
    ORD_ADDR              VARCHAR2(100)       NOT NULL,       --받는 사람 기본주소
    ORD_ADDR_D            VARCHAR2(100)       NOT NULL,       --받는 사람 상세주소
    ORD_TEL                   VARCHAR2(15)                  NOT NULL,       --받는 사람 전화번호
    ORD_TOTALCOST         NUMBER                  NOT NULL,       --총 주문 금액
    ORD_DATE                  DATE    DEFAULT SYSDATE,                 --주문한 날짜
    ORD_DEFAULT_ADDR    CHAR(1) DEFAULT 'N'         --기본 배송지로 저장 유무
);
create sequence SEQ_ORDER_CODE;
--ord_code, m_id, ord_name, ord_post, ord_addr, ord_addr_d, ord_tel, ord_totalcost, ord_date
Insert into TBL_ORDER(ord_code, M_ID, ORD_NAME, ORD_POSTCODE, ORD_ADDR, ORD_ADDR_D, ORD_TEL, ORD_TOTALCOST, ORD_DATE, ORD_DEFAULT_ADDR)
values(1, 'user01', 'geeewon', '12345', 'seoul', 'dobong', '010-1111-1111', 10000, sysdate, 'N');
insert into TBL_ORDER(ord_code, M_ID, ORD_NAME, ORD_POSTCODE, ORD_ADDR, ORD_ADDR_D, ORD_TEL, ORD_TOTALCOST, ORD_DATE, ORD_DEFAULT_ADDR)
values(2, 'user01', 'geeewon', '12345', 'seoul', 'dobong', '010-1111-2222', 10000, '2022/07/09', 'N');
insert into TBL_ORDER(ord_code, M_ID, ORD_NAME, ORD_POSTCODE, ORD_ADDR, ORD_ADDR_D, ORD_TEL, ORD_TOTALCOST, ORD_DATE, ORD_DEFAULT_ADDR)
values(3, 'user01', 'geeewon', '12345', 'seoul', 'dobong', '010-1111-2222', 10000, '2022/08/09', 'N');

select * from TBL_ORDER
where m_id = 'user01' and
--6. 주문 상세 테이블(T_ORDER_D)
CREATE TABLE TBL_ORDER_D(
    ORD_CODE              NUMBER,                         --주문번호
    P_NUM               NUMBER,                             --상품번호
    ORD_AMOUNT        NUMBER          NOT NULL,   --주문수량
    ORD_COST              NUMBER          NOT NULL,   --주문 가격
    ORD_STATUS  VARCHAR2(20)    DEFAULT '상품준비중' NOT NULL,
    PAY_STATUS VARCHAR2(20),
    CS_STATUS VARCHAR2(20)
);
ALTER TABLE TBL_ORDER_D ADD CONSTRAINT FK_ORD_CODE FOREIGN KEY(ORD_CODE) REFERENCES TBL_ORDER(ORD_CODE);
--ord_code, p_num, ord_amount, ord_cost?


/* 220808
1) 주문 테이블
    - 주문상태 컬럼 : 상품 준비중 / 베송 준비 중 / 배송 보류 / 배송 대기 / 배송 중 / 배송 완료
    - 결제 상태 컬럼: 입금 전 / 추가 입금 대기 / 입금 완료(수동) / 입금 완료(자동) / 결제 완료
    -cs 상태 : 취소 / 교환 / 반품 / 환불
2) 주문 상세 테이블
3)결제 테이블 
        결제 코드
        주문 코드
        결제 수단
        결제(입금)일자
        총 실제 결제 금액
        추가 입금금액
        무통장 입금액
        무통장 입금자명
        무통장 입금은행
*/
CREATE TABLE TBL_PAYMENT (
    
    PAY_CODE                NUMBER  CONSTRAINT PK_PAYMENT   PRIMARY KEY, --결제 코드
    ORD_CODE                   NUMBER NOT NULL, --주문코드(FK)
    PAY_METHOD           VARCHAR2(20)    NOT NULL, --무통장 / 신용카드 / 페이코 / 휴대폰 / 카카오 페이
    PAY_DATE                DATE        NOT NULL, --결제(입금)일자
    PAT_TOT_PRICE        NUMBER    NOT NULL, --총 실제 결제 금액
    PAY_REST_PRICE        NUMBER NOT NULL, --추가 입금금액
    PAY_NOACCOUNT_PRICE                NUMBER, --무통장 입금액
    PAY_NOACCOUNT_USERNAME                 VARCHAR2(20), -- 무통장 입금자명
    PAY_NOACCOUNT_BANK                VARCHAR2(20) --무통장 입금금액
);
CREATE SEQUENCE SEQ_PAYMENT_CODE;

pay_code, ord_code, pay_method, pay_date, pat_tot_price, pay_rest_price, pay_noaccount_price, pay_noaccount_username, pay_noaccount_bank
PAY_CODE, ORD_CODE, PAY_METHOD, PAY_DATE, PAT_TOT_PRICE, PAY_REST_PRICE, PAY_NOACCOUNT_PRICE, PAY_NOACCOUNT_USERNAME, PAY_NOACCOUNT_BANK


--7. 게시판(BOARD)
CREATE TABLE TBL_BOARD(
B_NUM NUMBER     CONSTRAINT PK_BOARD  PRIMARY KEY,    --게시글 번호(시퀀스)
M_ID VARCHAR2(15) NOT NULL,   --회원id(게시글 작성자)
B_TITLE VARCHAR2(100) NOT NULL,   --게시글 제목
B_CONTENT     VARCHAR2(4000) NOT NULL,   --게시글 내용
B_REGDATE DATE DEFAULT SYSDATE NOT NULL,    --게시글 등록날짜
    CONSTRAINT FK_BOARD_M_ID FOREIGN KEY(M_ID) REFERENCES TBL_MEMBER(M_ID)
);
CREATE SEQUENCE SEQ_BOARD;
--b_num, m_id, b_title, b_content, b_regdate?

--8. 리뷰
CREATE TABLE TBL_REVIEW(
R_NUM NUMBER     CONSTRAINT PK_REVIEW  PRIMARY KEY, --리뷰글 번호
M_ID VARCHAR2(15) NOT NULL,   --회원 id
P_NUM NUMBER NOT NULL,   --상품번호
R_CONTENT VARCHAR2(200) NOT NULL,   --리뷰내용
R_SCORE NUMBER NOT NULL,   --리뷰 평점
R_REGDATE DATE DEFAULT SYSDATE NOT NULL   --리뷰 작성일
);
--r_num, m_id, p_num, r_content, r_score, r_regdate
--R_NUM, M_ID, P_NUM, R_CONTENT, R_SCORE, R_REGDATE
CREATE SEQUENCE SEQ_REVIEW_NUM;

--9. 관리자 테이블 (ADMIN)
CREATE TABLE TBL_ADMIN(
ADMIN_ID VARCHAR2(15)    CONSTRAINT PK_ADMIN  PRIMARY KEY,    --관리자 id
ADMIN_PW VARCHAR2(60) NOT NULL,   --관리자 비밀번호
ADMIN_NAME VARCHAR2(100) NOT NULL,   --관리자명
ADMIN_LASTDATE DATE DEFAULT SYSDATE NOT NULL    --접속시간
);

--admin_id, admin_pw, admin_name, admin_lastdate
--ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_LASTDATE
--관리자 계정 생성 - 아이디: admin,비밀번호: 1234(암호화된 비밀번호 복사해옴), 이름: 관리자
INSERT INTO TBL_ADMIN (admin_id, admin_pw, admin_name, admin_lastdate)
    VALUES('admin', '$2a$10$RFjRcMcQVPZ9s3OVmwuUUOrJ34pEbGtp.2jB8QJv/56YpfpUE470q', '관리자', sysdate);
commit;

--10. 질문게시판?
/*
번호
질문 주제 - 상품 문의, 기타문의, 배송 전 취소 및 변경 문의, 교환 및 환불 문의
질문 내용 - 질문 주제 별 필수 사항 추가
첨부 파일들
비밀번호
비밀글 설정?
사용자 아이디 필요
날짜
*/