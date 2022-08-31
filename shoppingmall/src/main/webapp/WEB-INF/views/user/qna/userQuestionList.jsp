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

<main role="main" style="margin-top: 75px">


  <section class="jumbotron text-center">
    <div class="container">
      <h1>질문</h1>
      	
    </div>
  </section>
  <div class="container">
      
      <!-- 주문 상품 -->
      <div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				<hr>
	      				<h5>Q&A </h5>
	      			</div>	
	      			<div class="box-body">
	      				<form id="searchForm" action="/board/list" method="get">
						  <%-- 검색 단추를 누르면  --%>
						    <select name="type">
								 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
								 <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" />>제목</option> <%-- Title --%>
								 <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />>내용</option> <%-- Content --%>
								 <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" />>작성자</option> <%-- Writer --%>
								 <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" />>제목  or 내용</option>
								 <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" />>제목  or 작성자</option>
								 <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : ''}" />>제목  or 작성자  or 내용</option>
						  	</select>
						  	<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
						  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						  	<button class="btn btn-info">Search</button>
						  </form>
					
					
						  <table class="table table-hover">
							  <thead>
							    <tr>
							      <th scope="col">번호</th>
							      <th scope="col">제목</th>
							      <th scope="col">작성자</th>
							      <th scope="col">작성일</th>
							    </tr>
							  </thead>
							  <tbody>
							  <c:forEach items="${questionList}" var="questionVO">
							    <tr>
							      <td scope="row">
							      	<c:out value="${questionVO.q_num}" />
							      </td>
							      <td scope="row">
							      	<a class="move" href="${productVO.q_num}">
							      		<c:out value="${questionVO.q_title}" />
							      	</a>
							      </td>
							      <td scope="row">
							      	<c:out value="${fn:substring(questionVO.m_id, 0, fn:length(questionVO.m_id) - 4)}" /> ****
							      </td>
							      <td scope="row">
							      	<fmt:formatDate value="${questionVO.q_regdate}" pattern="yyyy-MM-dd"/>
							      </td>
							    </tr>
							   </c:forEach> 
							  </tbody>
							</table>
							
							<div class="text-right">
								<button type="button" name="btnWriteQuestion" id="btnWriteQuestion" class="btn btn-dark">글쓰기</button>
								<br>
							</div>
							<div>
							<nav aria-label="pagination">
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
							  
							  <form id="actionForm" action="/board/list" method="get">
									<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - model 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
									<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
									<input type="hidden" name="type" value="${pageMaker.cri.type}">
									<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
									<%-- 한 번 검색하면 list()메소드에 Criteria cri 에 값이 들어가게 되어 위 사용 가능 --%>
								</form>
							</nav>					
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
		$(document).ready(function(){
			let actionForm = $("#actionForm");
			//id가 actionForm인  form태그를 참조, 전역변수로 선언
			//페이지 번호 클릭하면 동작하는 기능
			$("li.page-item a.page-link").on("click", function(e){
				//a태그는 클릭하면 걸린 링크로 이동, 우리는 파라미터값으로 제공해야 함
				//e : 이벤트 변수
				e.preventDefault(); //태그의 기본특성을 제거 지금은 <a>태그의 링크기능을 제거
									
				/* 검색기능이 추가되어 아래구문 사용 X
					let url = "list?pageNum=" + $(this).attr("href") + "&amount=10"; 
					location.href=url;
				*/
							
				//현재 선택한 페이지번호 변경작업 <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				actionForm.find("input[name='pageNum']").val($(this).attr("href")); //find() : actionForm이 폼태그를 참조하고, 폼태그의 하위 태그들을 찾고자할 때 쓰는 메소드
				
				//뒤로가기 누를 때 글번호가 주소에 저장되어 페이지 번호를 눌러도 유지되는 것을 지우는 코드
				//글번호 저장된 태그는 주소가 변하는 순간 사라지기 때문에(list페이지가 새로고침????)
				actionForm.find("input[name='bno']").remove();
				//목록에서 제목을 클릭할 때 주소를 /board/get으로 변경헤 놔서 뒤로가기로 페이지목록으로 돌아가면 그대로 유지되는 것
				actionForm.attr("action", "/board/list");
				
				actionForm.submit(); //<form>태그 내용 전송
			});
			//목록에서 제목을 클릭시 동작 (페이징 + 검색 파라미터 + 글번호)
			$("a.move").on("click", function(e) {
				e.preventDefault(); //a태그를 클릭하면 동작하는 기능이 e인데 e의 기본 동작을 못하게 하는 것
				//a태그의 href에는 글번호 값이 있음
				let bno = $(this).attr("href"); //$(this) = $("a.move")
				actionForm.find("input[name='bno']").remove();
				//추가된 input태그가 캐쉬에 남지 않게 삭제
				//actionForm 의 정보 + 글번호 추가하자
				//DOM 작업
				actionForm.append("<input type='hidden' name='bno' value='" + bno + "'>"); //actionForm에 추가
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			
			});
			
			//글쓰기 버튼 클릭 시
			$("#btnWriteQuestion").on("click", function(){
				
				location.href="/user/qna/userAddQuestion";
			});
		});
	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
