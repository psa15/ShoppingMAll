<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
  <!-- Font Awesome, Ionicons, Theme style, AdminLTE Skins, Google Font -->
  <%@include file="/WEB-INF/views/admin/include/script1.jsp" %>
  
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/leftNav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <div class="row">
      	<div class="col-md-12">      	
      		<div class="box box-primary">
      			<div class="box-header">
      				PRODUCT LIST
      			</div>
      			<div class="box-body">      				
					  <form id="searchForm" action="" method="get">
  <%-- 검색 단추를 누르면  --%>
    <select name="type">
		 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
		 <option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}" />>상품명</option>
		 <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />>제조사</option>
		 <option value="NC" <c:out value="${pageMaker.cri.type eq 'NC' ? 'selected' : ''}" />>상품명  or 제조사</option>
  	</select>
  	<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
  	<button type="button" id="btnSearch" class="btn btn-info">Search</button>
  </form>


  <table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">상품명</th>
	      <th scope="col">가격</th>
	      <th scope="col">제조사</th>
	      <th scope="col">수량 / 구매 가능 여부</th>
	      <th scope="col">등록일</th>
	      <th scope="col">수정</th>
	      <th scope="col">삭제</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${productList}" var="productVO">
	    <tr>
	      <td scope="row"><c:out value="${productVO.p_num}" /></td>
	      <td>
	      	<img alt="이미지" src="/admin/product/displayFile?folderName=${productVO.p_image_folder}&fileName=${productVO.p_image}">
	      	<a class="move" href="${productVO.p_name}"><c:out value="${productVO.p_name}" /></a></td>
	      <td scope="row"><c:out value="${productVO.p_cost}" /></td>
	      <td scope="row"><c:out value="${productVO.p_company}" /></td>
	      <td scope="row"><c:out value="${productVO.p_amount}" /> / <c:out value="${productVO.p_buy_ok == 'Y' ? '구매가능' : '구매 불가능'}"></c:out> </td>
	      <td><fmt:formatDate value="${productVO.p_regdate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	      <td scope="row"><button type="button" class="btn btn-link" name="btnUpdateProduct" data-p_num="${productVO.p_num}">수정</button></td>
	      
	      <td scope="row"><button type="button" class="btn btn-link" name="btnProductDelete" data-p_num="${productVO.p_num}">삭제</button></td>
	    </tr>
	   </c:forEach> 
	   
	  </tbody>
	</table>
	<nav aria-label="...">
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
	  
	  <form id="actionForm" action="/admin/product/productList" method="get">
			<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - @ModelAttribute("cri") 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
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
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS - jQuery 3, Bootstrap 3.3.7, AdminLTE App -->
<%@include file="/WEB-INF/views/admin/include/script2.jsp" %>

<!-- CKEditor -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script>
  $(document).ready(function(){
    
    let actionForm = $("#actionForm");

    //수정 버튼 클릭 시
    $("button[name='btnUpdateProduct']").on("click", function(){

      actionForm.append("<input type='hidden' name='p_num' value='" + $(this).data("p_num") + "'>");
      actionForm.attr("action", "/admin/product/updateProduct");

      actionForm.submit();
    });
    
    let searchForm = $("#searchForm");
    
    //search 클릭 시 페이지번호 1로 돌아가기
    $("#btnSearch").on("click",function(){
    	searchForm.find("input[name='pageNum']").val(1);
        searchForm.submit();
    });
    
    //페이지 번호 
    $("ul.pagination li a.page-link").on("click", function(e){
    	e.preventDefault();
    	
    	let pageNum = $(this).attr("href");
    	
    	actionForm.find("input[name='pageNum']").val(pageNum);
    	actionForm.submit();
    });

  });
</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>