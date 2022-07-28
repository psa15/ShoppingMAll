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
      <h1>CART</h1>
    </div>
  </section>

 <div class="container">
		<div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				LIST CART     
	      			</div>	
	      			<div class="box-body">	      				
					  <table class="table table-hover" id="tblCartList">
						  <thead>
						    <tr>
						      <th scope="col">제품</th>
						      <th scope="col">수량</th>
						      <th scope="col">배송비</th>
						      <th scope="col">가격</th>						      
						      <th scope="col">적립</th>
						      <th scope="col">취소</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${cartList}" var="cartVO">
						  <c:set var="price" value="${cartVO.cart_amount * cartVO.p_cost}"></c:set>
						    <tr>	
						      <!-- 제품 : 이미지 및 상품이름 -->				      
						      <td>						      	
						      	<a class="move" href="${cartVO.p_num}">
						      		<img src="/user/product/displayFile?folderName=${cartVO.p_image_folder}&fileName=s_${cartVO.p_image}" 
						      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
						      		<c:out value="${cartVO.p_name}" />
						      	</a>
						      </td>
						      <!-- 수량 -->
						      <td>
						      	<input type="number" name="cart_amount" value='<c:out value="${cartVO.cart_amount}" />'>
								<input type="hidden" name="p_cost" value="${cartVO.p_cost}">
						      	<button type="button" name="btnCartAmountChange" data-cart_code="${cartVO.cart_code}" class="btn btn-link">수량변경</button>
						 
						      </td>
						      <!-- 배송비 -->	
						      <td>
						      	[기본배송]
						      </td>	
								<!-- 상품 가격 * 수량 -->				      
							  <td>
								<span class="unitPrice">						      	
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />
								</span>
							  </td>						  
						      <!-- 적립 -->
						      <td>
						      	<c:out value="${cartVO.m_point}" />
						      </td>
						      <!-- 삭제 -->
						      <td>
			                    <input type="hidden" name="p_image_dateFolder" value="${cartVO.p_image_folder}">
			                    <input type="hidden" name="p_image" value="${cartVO.p_image}">
			                    <button type="button" name="btnCartDelete" data-cart_code="${cartVO.cart_code}" class="btn btn-link">삭제</button></td>
						    </tr>
						    <c:set var="sum" value="${sum + price}"></c:set>
						   </c:forEach>					   
						  </tbody>
						  <tfoot>
							<tr>
								<td colspan="6" style="text-align: right"> 
									총 구매 금액: <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum}" /></span>
								</td>
							</tr>
						  </tfoot>
						</table>							
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