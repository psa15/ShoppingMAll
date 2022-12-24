# 개인프로젝트 - 쇼핑몰 제작

### 프로젝트
* 프로젝트 명: REAL Mall
* 프로젝트 소개: 옷과 악세사리를 파는 온라인 쇼핑몰 제작

### 프로젝트 구현 기능

#### 1. 사용자
  * 회원가입 - 메일 인증(Gmail smtp 사용), 주소찾기(다음 우편번호 API 사용)
  * 로그인/로그아웃, 아이디 찾기/임시 비밀번호 재발급(Gmail smtp 사용)
  * 마이페이지 - 주문내역, 회원정보 수정, Q&A게시판(파일첨부 기능 포함)
  * 장바구니 - 선택한 제품 삭제하기/주문하기, 전체 제품 삭제하기/주문하기
  * 주문하기 - 카카오페이결제 가능(카카오페이 API 사용)
  * 주문내역 - 주문 날짜 별 검색, 상품 후기 쓰기

#### 2. 관리자
  * 상품 등록/수정
  * 상품 리스트
  * 주문 관리 - 검색 기능, 주문/결제/CS상태 변경 기능
  * 통계 - 제품 카테고리 별 주문 통계 차트(구글 Chart API 사용)
  
  
### 기술
* Front-End: HTML5, CSS, Javascript, Boot-Strap 4.6
* Back-End: Spring Framework, Oracle, MyBatis, jstl, log4j, lombok
* Open AIP: 다음 우편번호 API, Google Chart API, 카카오페이 API
