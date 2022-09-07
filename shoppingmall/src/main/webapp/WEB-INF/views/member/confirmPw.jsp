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
    
    <!-- Custom styles for this template -->
    <link href="/css/album.css" rel="stylesheet">
    
    <!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
  </head>
  
 <body>
    
	<header>
		<%@include file="/WEB-INF/views/include/header.jsp" %>
	</header>
	
	<div class="container-fluid">
	  <div class="row">
	    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse" style="background-color: #e3f2fd;">
	      <div class="sidebar-sticky pt-3">
	        <ul class="nav flex-column">
	          <li class="nav-item">
	            <a class="nav-link active" href="/user/order/userOrderHistory">
	              	주문내역 
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="/member/confirmPw">
	             	 회원 정보 수정
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link active" href="/user/qna/userQuestionList">
	              	Q&A 
	            </a>
	          </li>
	        </ul>
	      </div>
	    </nav>
	
	    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
		  <section class="text-center" style="margin: 100px">
		    <div class="container">
		      <h3>비밀번호 확인</h3>
		    </div>
		  </section>
      	  <div class="container">
			  <div class="row text-center">
			    <div class="col-12">
			 		<form id="loginForm" method="post" action="confirmPw">
					  <div class="form-group row">
					    <label for="m_id" class="col-sm-4 col-form-label">아이디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" id="m_id" name="m_id" value="${sessionScope.loginStatus.m_id}">
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
							<button class="btn btn-lg btn-primary" type="submit">확인</button>
					    </div>
					  </div>		  
					</form>
				</div>
			  </div>
	      </div>
	    </main>
	  </div>
	</div>
	
	
	<footer class="text-muted">
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</footer>
	
  </body>
</html>