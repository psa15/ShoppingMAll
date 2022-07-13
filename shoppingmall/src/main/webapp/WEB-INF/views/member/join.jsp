<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title> DocMall Shopping</title>
	
	<!-- 부트스트랩 css  cdn 버전 -> footer아래에 common.jsp로 참조
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    -->
    
	<meta name="theme-color" content="#563d7c">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

   
    
  </head>
  <body>
    
	<!-- header -->
	<%@include file="/WEB-INF/views/include/header.jsp" %>
	
	<h3>회원 가입</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
	    <form action="join" method="post" id="joinForm">
		  <div class="form-group row">
		    <label for="m_id" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="m_id" name="m_id" placeholder="아이디를 8 ~ 15이내로 입력하세요">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-link" id="btnIdCheck">아이디 중복체크</button>
		      
		    </div>
		    <label for="staticEmail" class="col-form-label col-sm-2" style="display: none;" id="idCheckResult">중복체크 결과</label>
		  </div>
		  <div class="form-group row">
		    <label for="m_passwd" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="m_passwd" name="m_passwd" >
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_passwd2" class="col-sm-2 col-form-label">비밀번호 확인</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="m_passwd2" name="m_passwd2">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_name" class="col-sm-2 col-form-label">이름</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_name" name="m_name" >
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_email" class="col-sm-2 col-form-label">이메일</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_email" name="m_email" >
		    </div>
		  </div>
		  <div class="form-group row">
		  	<label for="m_authcode" class="col-sm-2 col-form-label">이메일 인증코드</label>
		  	<div class="col-sm-3">
		      <button type="button" class="form-control btn btn-info" id="btnAuthcode" > 메일 인증 요청 </button>
		    </div>		    
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="m_authcode" name="m_authcode">
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="form-control btn btn-info" id="btnConfirmAuthcode">메일 인증 확인 </button>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_tel" name="m_tel" >
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_postnum" class="col-sm-2 col-form-label">우편번호</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_postnum" name="m_postnum" >
		      <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_addr" class="col-sm-2 col-form-label">주소</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_addr" name="m_addr" >
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="m_addr_d" class="col-sm-2 col-form-label">상세주소</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="m_addr_d" name="m_addr_d" >
		      <input type="hidden" id="extraAddress" placeholder="참고항목">
		    </div>
		  </div>	
		  <div class="form-group row">
	      	<label class="form-check-label col-sm-2" for="m_email_accept">메일 수신 동의</label>
	      	<div class="col-sm-10 text-left">
		    	<input type="checkbox" class="form-check-input" id="m_email_accept" name="m_email_accept"  >		
		    </div>	    		    
		  </div>
		  
	      <button type="button" class="btn btn-dark text-center" id="btnJoinSend">회원가입</button>
	      		
		</form>
	  </div>
	
	  <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	<!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>

	<script>

		let joinForm = $("#joinForm");

		$(document).ready(function(){

			
			//회원가입 정보 저장
			$("#btnJoinSend").on("click", function(){
				//console.log("회원가입 하기");

				//유효성 검사

				//정보 전송
				joinForm.submit();
			});

			//아이디 중복체크를 했는지 확인하기 위한 전역변수(상태변수) 선언
			let isIDCheck = false;

			//ID 중복 체크
			$("#btnIdCheck").on("click", function(){

				//ID입력됐는지 확인
				if($("#m_id").val == "") { 
					//아이디가 공백일 때
					alert("아이디를 입력하세요.");
					$("#m_id").focus();
					return;
				} 

				//중복확인 결과 출력되는 태그 보이기
				$("#idCheckResult").css({ 'display' : 'inline', 'color' : 'red'});

				$.ajax ({
					url: '/member/idCheck',
					type: 'get',
					dataType: 'text',
					data: { m_id : $("#m_id").val() },
					success: function(result) {
						console.log(result);

						if(result == "yes") {
							$("#idCheckResult").html("<b>" + $('#m_id').val() + "사용가능</b>");
							isIDCheck = true;
						} else {
							$("#idCheckResult").html("<b> 해당 아이디는 사용 불가능 </b>");
							isIDCheck = false;
						}
					}
				});
			});

			//메일 인증코드 요청 작업
			$("#btnAuthcode").on("click", function(){

				//메일 작성됐는지 확인
				if($("#m_email").val() == "") {
					alert("메일 주소를 입력해 주세요.");
					return;
				}

				$.ajax({
					url: '/email/send',
					type: 'get',
					dataType: 'text',
					data: { receiverMail : $("#m_email").val() },
					success: function(result) {
						if(result == "success") {
							alert("인증코드가 발송되었으니 메일을 확인해 주세요.");
						} else if(result == "fail") {
							alert("메일 발송이 실패되었으니 메일주소 확인 및 관리자에게 문의바랍니다.");
						}

					}
				});
			});

			//메일 인증코드를 확인했는지 알려주는 변수
			let isAuthCode = false;

			//메일 인증 확인
			$("#btnConfirmAuthcode").on("click", function(){
				
				let authCode = $("#m_authcode").val();

				$.ajax({
					url: '/email/confirmAuthCode',
					type: 'post',
					dataType: 'text',
					data: {  },
					success: function(result){
						
					}
				});
			});
		});
	</script>
    
    <%-- 우편번호와 주소 입력 폼 - kakao 우편번호 api 사용 (함수이름이나 id값 변경함)
    		https://postcode.map.daum.net/guide --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('m_postnum').value = data.zonecode;
	                document.getElementById("m_addr").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("m_addr_d").focus();
	            }
	        }).open();
	    }
	</script>
  </body>
</html>