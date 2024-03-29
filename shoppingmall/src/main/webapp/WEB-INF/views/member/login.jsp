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
	
	<div class="container">
		<h3>로그인</h3>
	  <div class=" mb-3 text-center">
	    <div class="col-6">
	 		<form id="loginForm" class="form-signin" action="login" method="post">
			  <div class="form-group row">
			    <label for="m_id" class="col-sm-4 col-form-label">아이디</label>
			    <div class="col-sm-6">
			      <input type="text" id="m_id" class="form-control" name="m_id" placeholder="ID" required autofocus>
			    </div>
			   </div>		    
			  <div class="form-group row">
			    <label for="m_passwd" class="col-sm-4 col-form-label">비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" id="m_passwd" class="form-control" name="m_passwd" placeholder="Password" required>
			    </div>
			  </div>		  
			  <div class="form-group">
			    <div class="text-center">
					<button class="btn btn-lg btn-primary" id="btnsignIn" type="submit">Sign in</button>
			    </div>
			  </div>
			  <div class="form-group">
				<div class="text-center">
					<a href="/member/lostId">아이디 찾기</a> |
		  			<a href="/member/newPw">비밀번호 발급받기</a>
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
        
        let loginForm = $("#loginForm");
        
         //로그인 정보 전송
        $("#loginForm").on("submit", function(){
          console.log("로그인");

          /*유효성 검사 */
          
          //아이디와 비밀번호 입력했는지 확인
          if($("#m_id").val() == "") {
            alert("아이디를 입력하세요");
            $("#m_id").focus();
            return false;
          }
          
          if($("#m_passwd").val() == "") {
            alert("비밀번호를 입력하세요");
            $("#m_passwd").focus();
            return false;
          }

          return true;
        });
         



        //아이디 찾기 버튼
        $("#btnlostId").on("click", function(){
          location.href = "member/login";
        });
      	//비밀번호 찾기 버튼
        $("#btnNewPw").on("click", function(){
          location.href = "/member/newPw";
        });

      });

    </script>
    
  </body>
</html>