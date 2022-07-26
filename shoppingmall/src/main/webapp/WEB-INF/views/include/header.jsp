<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


  <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm fixed-top">
  	  <!-- 카테고리 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <!--  
	      <li class="nav-item active">
	        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Link</a>
	      </li>
	      -->
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
	      <!--  
	      <li class="nav-item">
	        <a class="nav-link disabled">Disabled</a>
	      </li>
	      -->
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
	    <a class="p-2 text-dark" href="#">마이페이지</a>
	    <a class="p-2 text-dark" href="#">주문목록</a>
	    
	    <!-- 로그인 후 -->
	  	<c:if test="${sessionScope.loginStatus != null}">
	  		<a class="p-2 text-dark" href="/member/logout">로그아웃</a>
		    <a class="p-2 text-dark" href="/member/confirmPw">수정하기</a>
	    </c:if>
	    
	    <!-- 공통 -->
	    <a class="p-2 text-dark" href="#">장바구니</a>
	  </nav>
	</div>