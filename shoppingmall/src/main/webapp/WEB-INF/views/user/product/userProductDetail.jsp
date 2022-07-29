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
      
	/*상품 후기 별 평점*/	
	/*별점 기본 스타일*/  
	#star_r_score a.r_score {
		font-size: 22px;
		text-decoration: none;
		color: lightgray;
	}
	/*별점 클릭 시 jquery의 addClass(), removeClass()메소드를 이용하여 사용하여 색 변경
	.on을 클래스로! */
	#star_r_score a.r_score.on {
		color: black;
	}
    </style>

    
    <!-- Custom styles for this template -->
    <link href="/css/album.css" rel="stylesheet">
    
    <!-- bootstrap 버전 및 여러 파일들 -->
	<%@include file="/WEB-INF/views/include/common.jsp" %>
	
	<!-- Tab 기능 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	
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
      
      <!-- 상품 상세정보 및 리뷰 탭 -->
      <div class="row">
      	<div class="col-12">
      		<div id="productDetailTabs">
			  <ul>
			    <li><a href="#productDetailInfo">상세정보</a></li>
			    <li><a href="#productDetailReview">상품리뷰</a></li>
			    <li><a href="#tabs-3">QnA</a></li>
			  </ul>
			  <div id="productDetailInfo">
			    <p>${productVO.p_detail}</p>
			  </div>
			  <div id="productDetailReview">
			    <div class="col-6">
			    	REVIEW
			    </div>
			    <div class="col-6">
			    	<button type="button" id="btnReview" class="btn btn-info">상품 리뷰 쓰기</button>
			    </div>
			  </div>
			  <div id="tabs-3">
			    <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
			    <p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
			  </div>
			</div>
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
	
	<!-- 리뷰 작성할 모달 -->
	<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">상품 후기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="col-form-label">상품평점:</label>
	            <p id="star_r_score">
	            	<a class="r_score" href="#">★</a>
	            	<a class="r_score" href="#">★</a>
	            	<a class="r_score" href="#">★</a>
	            	<a class="r_score" href="#">★</a>
	            	<a class="r_score" href="#">★</a>
	            </p>
	          </div>
	          <div class="form-group">
	            <label for="r_content" class="col-form-label">리뷰내용:</label>
	            <textarea class="form-control" id="r_content"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">		        
	        <button type="button" id="btnReviewWrite" class="btn btn-primary btnReview">상품 리뷰 저장</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
			
			//jQuery-ui 탭기능
			$("#productDetailTabs").tabs();
			
			//상품 리뷰 쓰기 버튼 클릭
			$("button#btnReview").on("click", function(){

				$("#reviewModal").modal('show');
			});
			
			//평점 별 클릭시 색상 변경
			$("#star_r_score a.r_score").on("click", function(e){
				
				e.preventDefault();
	
				$(this).parent().children().removeClass("on"); 
				//별 선택시 클래스에 추가되어 있던 on 선택자를 제거(처음에는 제거할 on선택자가 없지만 다시 별을 선택하게 되면 on선택자 제거해야 함)
				$(this).addClass("on").prevAll("a").addClass("on"); 
				//제거된 on선택자를 선택한 별의 태그에 on선택자를 추가하고, 그 이전 a태그에 on선택자를 다시 추가
			});

			//상품 리뷰 저장 버튼 클릭
			$("#btnReviewWrite").on("click", function(){
				
				//리뷰 저장할 때 필요한 정보들 - r_score, r_content, p_num, m_id
				let r_score = 0;
				let r_content = $("#r_content").val();
				let p_num = $("#p_num").val();

				$("#star_r_score a.r_score").each(function(index, item){

					if($(this).attr("class") == 'r_score on') {
						r_score += 1;
					}
				});
				console.log("별 평점: " + r_score);

				if(r_score == 0) {
					alert("별점을 선택해 주세요");
					return;
				}

				if(r_content == "") {
					alert("상품 후기를 작성해 주세요.");
					return;
				}

				let data = JSON.stringify({ r_score : r_score, r_content : r_content, p_num : p_num });
				$.ajax({
					url: '/user/review/addReview',
					data: data,
					dataType: 'text',
					method: 'post',
					headers: {
						"Content-type" : "application/json", "X-HTTP-Method_Override" : "POST"
					},
					success: function(result){
						if(result == "success") {
							alert("상품 후기가 등록되었습니다.");

							let url = "/user/review/reviewList/" + $("#p_num").val() + "/1";
							//상품 후기 목록
							$.getJSON(url, function(data){
								console.log("목록: " + data.list[0].r_num);
								console.log("페이지 정보: " + data.pageMaker.startPage);
							});

							//후기가 등록되고 초기화
							$("#reviewModal").modal('hide');
							$("#star_r_score a.r_score").parent().children().removeClass("on"); 
							$("#r_content").val("");
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
