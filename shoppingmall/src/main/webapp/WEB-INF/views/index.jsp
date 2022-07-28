<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<!-- 카테고리 -->
	
</header>

<main role="main" style="margin-top: 90px">

  <section class="jumbotron text-center">
    <div class="container">
      <h1>슬라이드 이미지</h1>
    </div>
  </section>


  <div class="album py-5 bg-light">
    <div class="container">
      <h4 class="text-center">New</h4>
      <div class="row">
      	<c:forEach items="${productList }" var="productVO">
	        <div class="col-md-4"> <%-- col-md-4가 3개여서 한 페이지에 세 줄의 사진이 보여짐 --%>
	          <div class="card mb-4 shadow-sm">
	            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg> -->
	            <!-- 상품 이미지 -->
				  <a class="move" href="${productVO.p_num}">
				    <img src="/user/product/displayFile?folderName=${productVO.p_image_folder}&fileName=s_${productVO.p_image}" 
							 alt="" class="bd-placeholder-img card-img-top" width="100%" height="225" onerror="this.onerror=null; this.src='/image/no_image.png'">
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

</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>


<!--     <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
