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
	

  </head>
  <body>
    
<header>
	<%@include file="/WEB-INF/views/include/header.jsp" %>
</header>

<main role="main">

  <div class="container">
		 <h3 class="text-center">주문이 완료되었습니다.</h3><br><br>
		 <div class=" mb-3 text-center">	
			<p>주문번호: ${orderInfo.ord_code }</p><br>
			<p>주문자: ${orderInfo.ord_name }</p><br>
			<p>총 주문 금액: ${orderInfo.ord_totalcost }</p><br>  		
		 </div>
		 <div class="text-center">
			<button class="btn btn-lg btn-primary" id="btnBack" type="button">돌아가기</button>
	 		<button class="btn btn-lg btn-primary" id="btnOrderList" type="button">주문내역 조회</button>
	     </div>
     	
				
   </div>  

</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	

	<script>

		$(function(){
			
		});


	</script>
	
	

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
