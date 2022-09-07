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
	  <div class="row">
	      	<div class="col-md-12">
	      	<form id="questionForm" method="post" action="" enctype="multipart/form-data">
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				QnA
	      			</div>
	      			<div class="box-body">      				
						  <div class="form-group row">
							<label for="category" class="col-sm-2 col-form-label">제목</label>					  
						    <div class="col-sm-10">
						      <select id="q_title" name="q_title">
						      	<option value="상품" selected>상품 문의 </option>
						      	<option value="교환/환불">교환/환불 문의 </option>
						      	<option value="취소/변경">배송 전 취소 및 변경 문의 </option>
						      	<option value="기타">기타 문의 </option>
						      </select>
						    </div>					    
						  </div>
						  <div class="form-group row">
						    <label for="p_name" class="col-sm-2 col-form-label">본문</label>
						    <div class="col-sm-10">
						      <textarea rows="20" cols="50" name="q_content" id="q_content">상품명:</textarea>					     
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="uploadFile" class="col-sm-2 col-form-label">첨부 파일1</label>
						    <div class="col-sm-10">
						    	<input type="file" class="form-control" name="uploadFile">					     
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="uploadFile" class="col-sm-2 col-form-label">첨부 파일2</label>
						    <div class="col-sm-10">
						    	<input type="file" class="form-control" name="uploadFile">					     
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="uploadFile" class="col-sm-2 col-form-label">첨부 파일3</label>
						    <div class="col-sm-10">
						    	<input type="file" class="form-control" name="uploadFile">					     
						    </div>
						  </div>
						  <div class="form-group row">  				  
						    <label for="p_detail" class="col-sm-2 col-form-label">비밀번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="q_password" name="q_password">					     
						    </div>
						  </div>
						  <div class="form-group row">
						    <label for="p_amount" class="col-sm-2 col-form-label">비밀글 설정</label>
						    <div class="col-sm-10">
						      <input type="radio" name="q_open" value="Y">공개글
						      <input type="radio" name="q_open" value="N">비밀글			     
						    </div>
						  </div>					
	      			</div>
	      			<div class="box-footer">
	      				<div class="form-group row">
	      					<div class="col-md-12">
	      						<button type="button" class="btn btn-dark" id="btnCancel">취소</button>
	      						<button type="submit" class="btn btn-info" id="btnAddQuestion">등록</button>
	      					</div>
	      				</div>
	      			</div>
	      		</div>
	      	</form>
	      	</div>      
	      </div>  
	</div>
</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	<!-- CKEditor -->
<script type="text/javascript" src="/ckeditor2/ckeditor.js"></script>

	<script>

		$(function(){
			
			//CKEditor 환경 설정
		    var ckeditor_config = {
					resize_enabled : false,
					enterMode : CKEDITOR.ENTER_BR,
					shiftEnterMode : CKEDITOR.ENTER_P,
					toolbarCanCollapse : true,
					removePlugins : "elementspath"
		    }

		    CKEDITOR.replace("q_content", ckeditor_config);
			
			//질문 제목 선택
			$("select[name='q_title']").on("change", function(){
				
				let url = "";

				if($(this).val() == '상품') {

					url += "상품명: : ";

					CKEDITOR.instances.q_content.setData(url);

				} else if($(this).val() == '교환/환불') {

					url += "주문번호 / 연락처 : <br>";
					url += "교환 / 환불 상품명 : <br>";
					url += "은행명, 환불계좌, 예금주 : <br>";

					CKEDITOR.instances.q_content.setData(url);
										
				} else if($(this).val() == '취소/변경') {

					url += "주문번호 / 연락처 : ";

					CKEDITOR.instances.q_content.setData(url);
				} else {
					CKEDITOR.instances.q_content.setData(url);
				}
			});

			//등록 버튼 클릭 시
			let questionForm = $("#questionForm");
			$("#btnAddQuestion").on("click", function(e){

				e.preventDefault();

				//유효성 검사
				
				
				questionForm.attr("action", "/user/qna/addQuestion");
				questionForm.submit();
			}); 
			

		});


	</script>
	

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
