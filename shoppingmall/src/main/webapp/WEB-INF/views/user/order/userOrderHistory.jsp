<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>PsaMall</title>


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

    
    <!-- Custom styles for this template -->
    <link href="/css/album.css" rel="stylesheet">
    
    <!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
  </head>
  <body>
    
<header>
	<%@include file="/WEB-INF/views/include/header.jsp" %>
</header>

<main role="main" style="margin-top: 75px">

  <section class="jumbotron text-center">
    <div class="container">
      <h1>주문내역</h1>
    </div>
  </section>

 <div class="container">
		<div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				<h5>ORDER HISTORY</h5>    
	      			</div>	
	      			<div class="box-body">	
	      			<form id="searchForm" action="/user/order/userOrderHistory" method="get">
					  
					  	<%-- 주문 일자
					  	https://beforb.tistory.com/23   --%>
					  	<button type="button" id="btnToday" class="btn btn-info">오늘</button>
					  	<button type="button" id="btnOneMonth" class="btn btn-info">한 달</button>
					  	<button type="button" id="btnThreeMonth" class="btn btn-info">3개월</button>
					  	<button type="button" id="btnSixMonth" class="btn btn-info">6개월</button>
					  	그 외 날짜 검색<input type="date" name="startDate" value="${startDate }"> ~ <input type="date" name="endDate" value="${endDate }">
					  	<button type="submit" id="btnSearch" class="btn btn-info">검색</button>
					  </form>
					  <form action="/user/order/userOrderList" method="get" id="productSelectedForm">    
					  	<c:forEach items="${orderHistory}" var="orderHistory" varStatus="status">
					  		<hr>
					  		  
				  			<div class="row">          
						       	<div class = "col-4">
						  			<!-- 상품 이미지 -->
						      		<a class="move" href="${orderHistory.P_NUM}">
							      		<img src="/user/order/displayFile?folderName=${orderHistory.P_IMAGE_FOLDER}&fileName=s_${orderHistory.P_IMAGE}" 
							      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
							      	</a>
						      	</div>
						      	<div class = "col-4">
						      		<!-- 상품 정보 -->
						      		<p>${orderHistory.P_NAME}</p>
						      		<p>
						      			판매가격: <fmt:formatNumber type="number" maxFractionDigits="3" value="${orderHistory.P_COST}" />
						      			(${orderHistory.ORD_AMOUNT}개)
						      		</p>
						      		<p>주문 날짜: <fmt:formatDate value="${orderHistory.ORD_DATE}" pattern="yyyy-MM-dd"/></p>
						      	</div>
						      	<div class = "col-2">
						      		<!-- 주문 상태 -->
						      		<p> ${orderHistory.ORD_STATUS} </p>
						      	</div>
						      	<div class = "col-2">
						      		<!-- 리뷰쓰기 -->
						      		<button type="button" class="btn btn-link" name="bunwriteReview">리뷰 쓰기</button>
						      	</div>
						      </div>
						      
						 
							 </c:forEach>
						</form>								
	      			</div>	
	      		</div>     
	      	</div>      
	      </div>
		</div>
</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	<script>

		$(function(){

			//장바구니 비우기
			$("button#btnClearCart").on("click", function(){
				console.log("장바구니 비우기");

				if(!confirm("장바구니를 비우시겠습니까?")){
					return;
				}

				location.href = "/user/cart/clearCart";
			});
			
			/* 버튼 클릭으로 날짜 검색 */
			let searchForm = $("#searchForm");
			//오늘 날짜
			let today = new Date();
			let year = today.getFullYear();
			let month = today.getMonth() + 1;
			let date = today.getDate();

			//오늘 날짜
			let endDate = year + "-" + (("0"+month.toString()).slice(-2)) + "-" + (("0"+date.toString()).slice(-2));

			let startDate = "";
			//오늘 버튼 클릭 시
			$("#btnToday").on("click", function(){

				
				
				startDate = dateFormatter(today, startDate);
				console.log(startDate);
				$("input[name='startDate']").val(startDate);
				$("input[name='endDate']").val(endDate);
			});

			//한 달 버튼 클릭 시
			$("#btnOneMonth").on("click", function(){

				oneMonthAgo = new Date(today.setDate(today.getMonth() - 1)); //실패
				startDate = dateFormatter(oneMonthAgo, startDate);
				console.log(startDate);
				$("input[name='startDate']").val(startDate);
				$("input[name='endDate']").val(endDate);
			});

			dateFormatter = function(today, startDate) {
				let year = today.getFullYear();
				let month = today.getMonth() + 1;
				let day = today.getDate();

				startDate = year + "-" + (("0"+month.toString()).slice(-2)) + "-" + (("0"+date.toString()).slice(-2));

				return startDate;
			}

				
			
			
		});

		//숫자값을 천단위 마다 콤마 찍기
		$.numberWithCommas = function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		//3자리마다 콤마 제거하기
		$.withoutCommas = function (x) {
			return x.toString().replace(",", '');
		}
	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
