<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
      <h1>질문</h1>
    </div>
  </section>

 <div class="container">
	<div class="row">          
       	<div class = "col-6">
  			<!-- 상품 이미지 -->
      		<img src="/user/product/displayFile?folderName=${productVO.p_image_folder}&fileName=${productVO.p_image}" 
					alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
      	</div>
      	<div class = "col-6">
      		<!-- 상품 이미지 필드 정보 -->
      		<h5>${productVO.p_name}</h5>
      		<p>판매가격: <fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.p_cost}" /></p>
      		<p>
      			<input type="hidden" id="p_num" value="${productVO.p_num}">
      			수량: <input type="number" id="p_amount" min="1" value="1">
      		</p>
      		<button type="button" id="btnOrder"  class="btn btn-primary">구매하기</button>
			<button type="button" id="btnCart"  class="btn btn-primary">장바구니</button>
      	</div>
      </div>
	</div>
</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	<script>

		$(function(){

			//장바구니 페이지에서 상품 수량 변경
			$("button[name='btnCartAmountChange']").on("click", function(){
				console.log("수량 변경 버튼 클릭");

				let btnCartAmountChange = $(this);

				let cart_code = $(this).data("cart_code");
				let cart_amount = $(this).parent().find("input[name='cart_amount']").val();

				$.ajax({
					url: '/user/cart/changeCartAmount',
					data: {cart_code : cart_code, cart_amount : cart_amount},
					dataType: 'text',
					success: function(result) {
						if(result == "success") {
							alert("선택하신 상품의 수량이 변경되었습니다.");
							
							//개별 상품 금액 변경
							//상품 가격 참조
							let p_cost = btnCartAmountChange.parent().find("input[name='p_cost']").val();
							btnCartAmountChange.parents("tr").find("span.unitPrice").html($.numberWithCommas(p_cost * cart_amount));

							//총 구매금액 변경
							let totalPrice = 0;
							$("table#tblCartList tr td span.unitPrice").each(function(index, item){
								console.log("단위가격: " + $(item).html());
								// console.log("단위가격: " + $(item).text());

								totalPrice += parseInt($.withoutCommas($(item).text())); //무언갈 읽어오는 데이터는 전부 text(String)
								$("table#tblCartList tr td span#cartTotalPrice").text($.numberWithCommas(totalPrice));
							});
						}
					}
				});


			});

			//상품 삭제
			$("button[name='btnCartDelete']").on("click", function(){
				console.log("상품삭제");

				if(!confirm("선택하신 상품을 삭제하시겠습니까?")){
					return;
				}

				let cart_code = $(this).data("cart_code");
				location.href = "/user/cart/deleteCart?cart_code=" + cart_code;
			});

			//장바구니 비우기
			$("button[name='btnClearCart']").on("click", function(){
				console.log("장바구니 비우기");

				if(!confirm("장바구니를 비우시겠습니까?")){
					return;
				}

				location.href = "/user/cart/clearCart";
			});
			
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
