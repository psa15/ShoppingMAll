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

      if(msg == "noID") {
        alert("아이디를 확인하세요");
      } else if(msg == "noPW") {
        alert("비밀번호가 다릅니다.");
      }
    </script>
    
  </head>
  <body>
    
	<!-- header -->
	<%@include file="/WEB-INF/views/include/header.jsp" %>
	
	<h3>아이디 찾기</h3>
	
	<div class="container">
	  <div class=" mb-3 text-center">
	    <div class="col-6">
	 		<form id="loginForm" method="post" action="searchID">
			  <div class="form-group row">
			    <label for="m_userid" class="col-sm-4 col-form-label">아이디</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="m_userid" name="m_userid">
			    </div>
			   </div>		    
			  <div class="form-group row">
			    <label for="m_passwd" class="col-sm-4 col-form-label">비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="m_passwd" name="m_passwd">
			    </div>
			  </div>		  
			  <div class="form-group">
			    <div class="text-center">
					<button class="btn btn-lg btn-primary btn-block" type="submit">아이디 찾기</button>
			    </div>
			  </div>
			  <div class="form-group">
				<div class="text-center">
					<button class="btn btn-lg btn-primary btn-block" id="btnLogin" type="button">로그인</button>
			    </div>
			  </div>			  
			</form>
		</div>
	  </div>
	
	  <!-- footer -->
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	<!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
    
    <script>

      $(document).ready(function(){
    	
    	//비밀번호 찾기 버튼
        $("#btnSearchPw").on("click", function(){
          location.href = "/member/searchPw";
        });

      });

    </script>
    
  </body>
</html>