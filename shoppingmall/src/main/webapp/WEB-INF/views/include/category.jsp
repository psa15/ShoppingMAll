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
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>

	<script>

		$(function(){
  
		  //1차 카테고리 선택 시
		  $("ul.navbar-nav li").on("click", "a", function(){

			// console.log("1차 카테고리 클릭");

			let url = '/product/subCateList/' + $(this).attr("href");
			// console.log("2차 카테고리 주소: " + url);

			//ajax 안에서 사용할 선택자
			let selectedMainCategory = $(this);

			//2차 카테고리
			$.getJSON(url, function(result){

				let subCateList = selectedMainCategory.next();
				let subCateListStr = '';

				for(let i=0; i<result.length; i++) {
					subCateListStr += "<a class='dropdown-item' href='" + result[i].ct_code + "''>" + result[i].ct_name +"</a>";
				}

				subCateList.append(subCateListStr);
			});
		  });
		  
		  //2차 카테고리 클릭 시
		  $(".subCateList").on("click", "a", function(e){

			e.preventDefault();
			// console.log("2차 카테고리 선택");

			let s_ct_code = $(this).attr("href");
			location.href = "/product/productList/" + s_ct_code;
		  });
		  
		});
  
  
	  </script>