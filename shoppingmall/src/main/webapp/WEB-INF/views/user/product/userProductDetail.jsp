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

<main role="main">

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
      <div class="row">
      	<div class="col text-center">     	
      	</div>
      
      </div>
    </div>  

</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	<!-- 상품상세보기(바로구매 + 장바구니) 모달 -->
	<div class="modal fade" id="modal_productDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
			<div class="row">
				<div class="col-md-6">
					<img src="" id="modal_product_img"
					 alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
	
				</div>
				<div class="col-md-6">
					<form>
						<div class="form-group">
							<label for="p_name" class="col-form-label">상품명</label>
							<input type="text" class="form-control" id="p_name" readonly>
							<input type="hidden" class="form-control" id="p_num">
						</div>
						<div class="form-group">
							<label for="p_cost" class="col-form-label">가격</label>
							<input type="text" class="form-control" id="p_cost" readonly>
						</div>
						<div class="form-group">
							<label for="p_company" class="col-form-label">제조사</label>
							<input type="text" class="form-control" id="p_company" readonly>
						</div>
						<div class="form-group">
							<label for="p_amount" class="col-form-label">수량</label>
							<input type="number" class="form-control" id="p_amount" min="1" value="1">
						</div>
					</form>
				</div>
			</div>	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary">바로 구매</button>
	        <button type="button" name="btnAddCart" class="btn btn-primary">장바구니 담기</button>
	      </div>
	    </div>
	  </div>
	</div>

	<script>

		$(function(){


			//모달 - 장바구니 담기 클릭
			$("#btnCart").on("click", function(){
				console.log("장바구니 담기 클릭");
				
				$.ajax({
					url: "/user/cart/addCart",
					data: { p_num : $("input#p_num").val(), cart_amount : $("input#p_amount").val()},
					dataType: 'text',
					success: function(result) {
					
						if(result == "success") {
							alert("장바구니가 추가되었습니다.");
							if(confirm("장바구니로 이동하시겠습니까?")) {
								location.href = "/user/cart/cartList"
							}
						}
					}
				});
			});
		});
	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
