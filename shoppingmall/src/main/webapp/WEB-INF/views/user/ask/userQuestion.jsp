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
      <h1>질문</h1>
    </div>
  </section>

  <!-- Main content -->
    <section class="content container-fluid">

      <div class="row">
      	<div class="col-md-12">
      	<form id="productForm" method="post" action="addProduct" enctype="multipart/form-data">
      		<div class="box box-primary">
      			<div class="box-header">
      				
      			</div>
      			<div class="box-body">      				
					 <div class="form-group row">
						<label for="category" class="col-sm-2 col-form-label">문의 주제</label>					  
					    <div class="col-sm-10">
					      <select id="firstCategory" name="f_ct_code">
					      	<option>상품 문의 </option>
					      	<option>기타 문의 </option>
					      	<option>배송 전 취소 및 변경 문의 </option>
					      	<option>교환 및 환불 문의 </option>
					      </select>
					    </div>					    
					  </div>
					  <div class="form-group row">  				  
					    <label for="p_detail" class="col-sm-2 col-form-label">질문 내용</label>
					    <div class="col-sm-10">
					      <textarea class="form-control" name="p_detail" rows="3"></textarea>					     
					    </div>
					  </div>					  
					  <div class="form-group row">
					    <label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지1</label>
					    <div class="col-sm-10">
					      <input type="file" class="form-control" id="uploadFile1" name="uploadFile">					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지2</label>
					    <div class="col-sm-10">
					      <input type="file" class="form-control" id="uploadFile2" name="uploadFile">					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지3</label>
					    <div class="col-sm-10">
					      <input type="file" class="form-control" id="uploadFile3" name="uploadFile">					     
					    </div>
					  </div>					  
					  <div class="form-group row">
					    <label for="pw" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-10">
					      <input type="password" class="form-control" id="uploadFile3" name="pw">					     
					    </div>
					  </div>
				</div>					
      		</div>
      		<div class="box-footer">
				<div class="form-group">
					<ul class="uploadedList"></ul>
				</div>
				<div class="form-group">
					<div class="text-center">
						<button type="submit" class="btn btn-dark text-center" id="btnProduct">취소</button>
						<button type="submit" class="btn btn-dark text-center" id="btnProduct">저장</button>
					</div>
				</div> 
			</div>     			
      	</form>
      	</div>      
      </div>
    </section>

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
					data: { p_num : $("div#modal_productDetail input#p_num").val(), cart_amount : $("div#modal_productDetail input#p_amount").val()},
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