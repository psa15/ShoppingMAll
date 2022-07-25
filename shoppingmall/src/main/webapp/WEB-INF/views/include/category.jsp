<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	<!-- 카테고리 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">PSA Mall</a>
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
		      	<!-- 1차 카테고리 -->	      	
		        <a class="nav-link dropdown-toggle" href="${categoryVO.ct_code }" role="button" data-toggle="dropdown" aria-expanded="false">
		          ${categoryVO.ct_name}
		        </a>		       
		        <!-- 2차 카테고리 -->
		        <div class="dropdown-menu">
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
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>

	<script>

		$(function(){
  
		  //1차 카테고리 선택 시
		  $("ul.navbar-nav li").on("clicl", "a", function(){


			let url = '/product/subCateList/' + $(this).attr("href");

			//2차 카테고리
			$.getJSON(url, function(result){

			});
		  });
		});
  
  
	  </script>