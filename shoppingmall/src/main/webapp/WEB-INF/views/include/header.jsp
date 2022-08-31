<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


  <div id="header" class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white(30px) border-bottom shadow-sm">
  	  <!-- 카테고리 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	    
	      <c:forEach items="${firstCateList}" var="categoryVO">
		      <li class="nav-item dropdown">	
		      	<!-- 1차 카테고리(Main Category) -->	      	
		        <a class="nav-link dropdown-toggle" href="${categoryVO.ct_code }" role="button" data-toggle="dropdown" aria-expanded="false">
		          ${categoryVO.ct_name}
		        </a>		       
		        <!-- 2차 카테고리(Sub Category) -->
		        <div class="dropdown-menu subCateList">
		        	<%-- script로 추가 --%>
		        </div>
		      </li>
	       </c:forEach>
	    </ul>
	  </div>
	
	</nav>
	  <h5 class="my-0 mr-md-auto font-weight-normal"><a class="p-2 text-dark  text-center" href="/">Psa Mall</a></h5>
	  <nav class="my-2 my-md-0 mr-md-3 ">
	  
	  	<!-- 로그인 전 -->
	  	<c:if test="${sessionScope.loginStatus == null}">
		    <a class="p-2 text-dark" href="/member/login">로그인</a>
		    <a class="p-2 text-dark" href="/member/join">회원가입</a>
	    </c:if>
	    
	    <!-- 공통 -->
	    
	    
	    <!-- 로그인 후 -->
	  	<c:if test="${sessionScope.loginStatus != null}">	  		
  			<a class="p-2 text-dark" href="/member/logout">로그아웃</a>
  			<a class="p-2 text-dark" href="#">마이페이지</a>
		    <a class="p-2 text-dark" href="/member/confirmPw">수정하기</a>
	    	<a class="p-2 text-dark" href="/user/order/userOrderHistory">주문목록</a>
	    	<a class="p-2 text-dark" href="/user/qna/userQuestionList">QnA</a>
		    <a class="p-2 text-dark" href="/user/cart/cartList">장바구니 [${sessionScope.totalCart}]</a>
	    </c:if>
	    
	  </nav>
	</div>
	
		<script>

		$(function(){
  
		  //1차 카테고리 선택 시
		  $("ul.navbar-nav li").on("click", "a", function(){

			console.log("1차 카테고리 클릭");

			let fcode = $(this).attr("href")
			console.log(fcode);
			
			let url = '/user/product/subCateList/' + $(this).attr("href");
			console.log("2차 카테고리 주소: " + url);

			//ajax 안에서 사용할 선택자
			let selectedMainCategory = $(this);

			//2차 카테고리
			$.getJSON(url, function(result){

				let subCateList = selectedMainCategory.next();
				let subCateListStr = '';

				for(let i=0; i<result.length; i++) {
					subCateListStr += "<a class='dropdown-item' data-ct_p_code='" + result[i].ct_p_code + "' href='" + result[i].ct_code + "''>" + result[i].ct_name +"</a>";
				}

				subCateList.append(subCateListStr);
			});
		  });
		  
		  //2차 카테고리 클릭 시
		  $(".subCateList").on("click", "a", function(e){

			e.preventDefault();
			// console.log("2차 카테고리 선택");

			let f_ct_code = $(this).data("ct_p_code");
			let s_ct_code = $(this).attr("href");
			let ct_name = $(this).text();
			console.log(ct_name);
			location.href = "/user/product/userProductList/" + f_ct_code + "/" + s_ct_code + "/" + ct_name;
		  });
		  
		});
  
  
	  </script>
	  
	  <script>
		if("${msg}" == "logout") {
			alert("로그아웃 되었습니다.");
		}
		
		if("${msg}" == "needLogin") {
			alert("로그인 후 사용해 주세요.");
		}
  	  </script>