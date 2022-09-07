<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	      	<div class="col-md-12">
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				QnA
	      			</div>
	      			<div class="box-body">      				
						  <div class="form-group row">
							<label for="category" class="col-sm-2 col-form-label">제목</label>					  
						    <div class="col-sm-10">
						    	<c:if test="${questionVO.q_title == '상품'}">
						    		<input type="text" class="form-control" id="q_title" name="q_title" value="상품 문의" readonly>
						    	</c:if>
						    	<c:if test="${questionVO.q_title == '교환/환불'}">
						    		<input type="text" class="form-control" id="q_title" name="q_title" value="교환/환불 문의" readonly>
						    	</c:if>
						    	<c:if test="${questionVO.q_title == '취소/변경'}">
						    		<input type="text" class="form-control" id="q_title" name="q_title" value="배송 전 취소 및 변경 문의" readonly>
						    	</c:if>
						    	<c:if test="${questionVO.q_title == '기타'}">
						    		<input type="text" class="form-control" id="q_title" name="q_title" value="기타 문의" readonly>
						    	</c:if>
						    </div>					    
						  </div>
						  <div class="form-group row">
						    <label for="p_name" class="col-sm-2 col-form-label">본문</label>
						    <div class="col-sm-10">
						      ${questionVO.q_content }				     
						    </div>
						  </div>
						  <c:if test="${questionVO.q_file_exist == 'Y'}">
							  <div class="form-group row">
						  		<label class="col-sm-2 col-form-label">첨부된 파일</label>
						  		<c:forEach items="${fileInfo }" var="questionFileVO">
								    <div class="col-sm-10">
								    	<a class="downloadFile" href="">
								    		<c:out value="${fn:substring(questionFileVO.filename, 37,-1)}" />
											<input type="hidden" class="form-control" name="filename" value="${questionFileVO.filename}">
											<input type="hidden" class="form-control" name="fileFolder" value="${questionFileVO.fileFolder}">
								    	</a>			     
								    </div>
								</c:forEach>
							  </div>
						  </c:if>					
	      			</div>
	      			<div class="box-footer">
	      				<div class="form-group row">
	      					<div class="col-md-12">
	      						<button type="button" class="btn btn-info" id="btnQuestionList">목록</button>
	      					</div>
	      				</div>
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

			//파일 이름 클릭 시 다운로드
			$("a.downloadFile").on("click", function(e){
				e.preventDefault();

				console.log("파일 다운로드");

				let filename = $(this).find("input[name='filename']").val();
				let fileFolder = encodeURIComponent($(this).find("input[name='fileFolder']").val());
				let fileName = fileFolder + "/" + filename;
				console.log(fileName);

				let url = "/user/qna/download?fileName=" + fileName;
				location.href=url;
			});

			//장바구니 담기 클릭
			$("#btnQuestionList").on("click", function(){
				location.href="/user/qna/userQuestionList";
			});

		});

	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
