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

  <section class="jumbotron text-center">
    <div class="container">
      <h1>${ct_name}</h1>
      <c:forEach items="${cateName}" var="category">
      	<a href="/user/product/userProductList/${category.ct_p_code}/${category.ct_code}/${category.ct_name}" class="btn btn-light">${category.ct_name}</a> 	
	  </c:forEach>
    </div>
  </section>

  <div class="album py-5 bg-light">
    <div class="container">
      <div class="row">
      	<c:forEach items="${productList }" var="productVO">
	        <div class="col-md-4"> <%-- col-md-4가 3개여서 한 페이지에 세 줄의 사진이 보여짐 --%>
	          <div class="card mb-4 shadow-sm">
	            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg> -->
	            <!-- 상품 이미지 -->
				  <a class="move" href="${productVO.p_num}">
				    <img src="/user/product/displayFile?folderName=${productVO.p_image_folder}&fileName=s_${productVO.p_image}" 
							 alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image_found.png'">
					</a>
	            <div class="card-body">
	              <p class="card-text">
	              	${productVO.p_name}<br>
	              	${productVO.p_company}<br>
	              	<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="number" maxFractionDigits="3" value="${productVO.p_cost}"></fmt:formatNumber>
	              	<%-- maxFractionDigits="3" : 3자리마다 ,(콤마) 삽입 --%>
	              </p>
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">
	                  <button type="button" data-p_num="${productVO.p_num}" name="btnBuyCart" class="btn btn-sm btn-outline-secondary">구매 & 장바구니</button>
	                </div>
	                <small class="text-muted">후기</small>
	              </div>
	            </div>
	          </div>
	        </div>
        </c:forEach>          
      </div>
    </div>
  </div>
  
  <!-- 페이징 -->
  <div class="container">
  	<nav>
	  <ul class="pagination justify-content-center">
	  
	  	<%-- 이전표시 --%>
	  	<c:if test="${pageMaker.prev}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.startPage-1}">이전</a>
		    </li>
	    </c:if>
	    
	    <%-- 페이지 번호 표시 ( 1 2 3 4 5) --%>
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
	    	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : ""}'><a class="page-link" href="${num}">${num}</a></li>
	    </c:forEach>
	    
	    <%-- 다음표시 --%>
	    <c:if test="${pageMaker.next}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.endPage +1}">다음</a>
		    </li>
	    </c:if>   
	  </ul>
	  
	  <form id="actionForm" action="/user/product/userProductList" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="${pageMaker.cri.type}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	 </form>
	</nav>  
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
	        <button type="button" name="btnBuyNow" class="btn btn-primary">바로 구매</button>
	        <button type="button" name="btnAddCart" class="btn btn-primary">장바구니 담기</button>
	      </div>
	    </div>
	  </div>
	</div>

	<script>

		$(function(){

			//구매&장바구니 버튼 클릭 시 모달창 띄우기
			$("button[name='btnBuyCart']").on("click", function(){
				console.log(" 구매 & 장바구니 클릭");

				$("#modal_productDetail").modal('show');

				//상품 번호 참조
				let p_num = $(this).data("p_num");

				let url = "/user/product/modalProductDetail/" + p_num;
				console.log("상품 상세보기 주소: " + url);

				$.getJSON(url, function(result){
					
					//모달에 상품정보 표시
					//상품 이미지
					let imgUrl = "/user/product/displayFile?folderName=" + result.p_image_folder + "&fileName=" + result.p_image;
					$("div#modal_productDetail img#modal_product_img").attr("src", imgUrl);
					//상품명
					$("div#modal_productDetail input#p_name").val(result.p_name);
					//상품코드
					$("div#modal_productDetail input#p_num").val(result.p_num);
					//상품 가격
					$("div#modal_productDetail input#p_cost").val(result.p_cost);
					//상품 제조사
					$("div#modal_productDetail input#p_company").val(result.p_company);
					//상품 수량
					$("div#modal_productDetail input#p_amount").val(1);
				});
			});

			//모달 - 장바구니 담기 클릭
			$("button[name='btnAddCart']").on("click", function(){
				console.log("장바구니 담기 클릭");
				
				$.ajax({
					url: "/user/cart/addCart",
					data: { p_num : $("input#p_num").val(), cart_amount : $("input#p_amount").val()},
					dataType: 'text',
					success: function(result) {
					
						alert(result);
						if(result == "success") {
							alert("장바구니가 추가되었습니다.");
							if(confirm("장바구니로 이동하시겠습니까?")) {
								location.href = "/user/cart/cartList"
							}
						}
						
						if(result == "noID") {
							alert("로그인 후 사용해 주세요.");
							location.href = "/member/login";						
						}
					}
				});
			});
			
			//모달 - 바로구매 클릭
			$("button[name='btnBuyNow']").on("click", function(){
				console.log("바로구매 클릭");
				
				let p_num = $("div#modal_productDetail input#p_num").val();
				let cart_amount = $("div#modal_productDetail input#p_amount").val();
				
				location.href = "/user/order/orderList?type=directOrder&p_num=" + p_num + "&cart_amount=" + cart_amount;
				
			});
			
		    //페이지 번호 이동 
		    let actionForm = $("#actionForm");
		    $("ul.pagination li a.page-link").on("click", function(e){
		    	e.preventDefault();
		    	
		    	let pageNum = $(this).attr("href");
		    	
		    	actionForm.find("input[name='pageNum']").val(pageNum);
		    	
		    	let url = "/user/product/userProductList/${ct_code}/${ct_name}";
		    	actionForm.attr("action", url);
		    	
		    	actionForm.submit();
		    });

			//상품 이미지 클릭 시 상세 페이지로 이동
			$("a.move").on("click", function(e){
				e.preventDefault();
				console.log("이미지 클릭");

				let p_num = $(this).attr("href");
				location.href = "/user/product/userProductDetail?p_num=" + p_num;
			});
		});
	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
