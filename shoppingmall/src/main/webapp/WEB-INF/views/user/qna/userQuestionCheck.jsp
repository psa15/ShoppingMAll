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

    <script>
      let msg = "${msg}";

      if(msg == "wrongPw") {
        alert("입력하신 비밀번호가 다릅니다.");
      } 
    </script>
    
    <!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
  </head>
  <body>
    
	<header>
		<%@include file="/WEB-INF/views/include/header.jsp" %>
	</header>
	
	<h3>비밀번호 확인</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
	    <div class="row">
	 		<form id="pwCheckForm" method="post" action="/user/qna/userQuestionCheck">
			  <div class="form-group row">
			    <p>질문 작성 시 입력하셨던 비밀번호를 입력해 주세요.</p>
			  </div>		    
			  <div class="form-group row">
			    <label for="m_passwd" class="col-sm-4 col-form-label">비밀번호</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="q_password" name="q_password">
			      <input type="hidden" class="form-control" id="q_num" name="q_num" value="${q_num}">
			    </div>
			  </div>		  
			  <div class="form-group">
			    <div class="text-center">
					<button class="btn btn-lg btn-primary" type="submit">확인</button>
			    </div>
			  </div>		  
			</form>
		</div>
	  </div>
	
	  <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>

   
    
  </body>
</html>