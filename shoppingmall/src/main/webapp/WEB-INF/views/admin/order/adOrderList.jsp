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
      				LIST ORDER     
      			</div>	
      			<div class="box-body">
      				<form id="searchForm" action="/admin/order/orderList" method="get">
					  <%-- 검색 단추를 누르면 - pageNum은 1로 돌아가게  --%>
					    <select name="type" id="selectType">
							 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
							 <option value="O" <c:out value="${pageMaker.cri.type eq 'O' ? 'selected' : ''}" />>주문번호</option>
							 <option value="I" <c:out value="${pageMaker.cri.type eq 'I' ? 'selected' : ''}" />>주문자 아이디</option>
					  	</select>
					  	<input type="text" id="keywordTag" name="keyword" value="${pageMaker.cri.keyword}">
					  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					  	
					  	주문 일자 <input type="date" name="startDate" value="${startDate }"> ~ <input type="date" name="endDate" value="${endDate }">
					  	<button type="button" id="btnSearch" class="btn btn-info">Search</button>
					  </form>
					  <button type="button" name="btnDeleteCheck" class="btn btn-link">선택 삭제(체크 확인)</button>
					
					
					  <table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col"><input type="checkbox" id="checkAll" name="checkAll"></th>
						      <th scope="col">주문 번호</th>
						      <th scope="col">주문일시</th>
						      <th scope="col">수령인 / 주문자 아이디 </th>
						      <th scope="col">주문금액 / 배송비</th>
						      <th scope="col">결제 방법 / 결제 상태</th>
						      <th scope="col">배송 상태</th>
						      <th scope="col">CS 상태</th>
						      <th scope="col">주문 관리</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:forEach items="${orderList}" var="ordertVO">
						    <tr>
						      <!-- 비고 -->
						      <td scope="row"><input type="checkbox" class="check" value="${ordertVO.ord_code }"></td>	
						      <!-- 주문 번호 -->
						      <td><c:out value="${ordertVO.ord_code}" /></td>
						      <!-- 주문일시 -->				      
						      <td>
						      	<fmt:formatDate value="${ordertVO.ord_date}" pattern="yyyy-MM-dd hh:mm:ss"/>
						      </td>							  
						      <!-- 수령인 / 주문자 아이디 -->
						      <td><c:out value="${ordertVO.ord_name}" /> / <c:out value="${ordertVO.m_id}" /></td>
						      <!-- 주문금액 / 배송비 -->
						      <td><c:out value="${ordertVO.ord_totalcost}"/></td>
						      <!-- 결제 상태 -->
						      <td><c:out value="${ordertVO.pay_status}" /></td>
						      <!-- 배송상태 -->
						      <td>
						      	<select class="form-control" id="o_status" name="o_status">
							      <option value="주문접수"${ordertVO.ord_status eq '주문접수' ? 'selected' : ''}>주문접수</option>
							      <option value="배송준비중"${ordertVO.ord_status eq '배송준비중' ? 'selected' : ''}>배송 준비 중</option>
							      <option value="배송보류"${ordertVO.ord_status eq '배송보류' ? 'selected' : ''}>배송 보류</option>
							      <option value="배송대기"${ordertVO.ord_status eq '배송대기' ? 'selected' : ''}>배송 대기</option>
							      <option value="배송중"${ordertVO.ord_status eq '배송중' ? 'selected' : ''}>배송 중</option>
							      <option value="배송완료"${ordertVO.ord_status eq '배송완료' ? 'selected' : ''}>배송 완료</option>
							      <option value="주문취소"${ordertVO.ord_status eq '주문취소' ? 'selected' : ''}>주문 취소</option>
							      <option value="취소요청"${ordertVO.ord_status eq '취소요청' ? 'selected' : ''}>취소 요청</option>
							      <option value="취소완료"${ordertVO.ord_status eq '취소완료' ? 'selected' : ''}>취소 완료</option>
							      <option value="교환요청"${ordertVO.ord_status eq '교환요청' ? 'selected' : ''}>교환 요청</option>
							      <option value="교환완료"${ordertVO.ord_status eq '교환완료' ? 'selected' : ''}>교환 완료</option>
							    </select>
							    <button type="button" name="btnChangeOrderStatus" data-o_code="${ordertVO.ord_code }" class="btn btn-link">변경</button>
						      </td>
						      <!-- CS 상태 -->
						      <td><c:out value="${ordertVO.cs_status}" /></td>
						      
						      <!-- 주문 관리 -->						      
						      <td><button type="button" name="btnOrderDetail" data-o_code="${ordertVO.ord_code}" class="btn btn-link">주문 상세</button></td>
						      
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
						  <form id="actionForm" action="/admin/order/orderList" method="get">
								<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - model 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
								<input type="hidden" name="type" value="${pageMaker.cri.type}">
								<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                				<%--<input type="hidden" name="startDate" value="${startDate}">
                				<input type="hidden" name="endDate" value="${endDate}">
								 한 번 검색하면 list()메소드에 Criteria cri 에 값이 들어가게 되어 위 사용 가능 --%>
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

    //삭제 버튼 클릭 시
    $("button[name='btnProductDelete']").on("click", function(){

        if(!confirm($(this).data("p_num") + "번 게시물을 삭제하시겠습니까?")) { return; }
        
        //날짜 폴더 및 이미지 파일 이름 참조
        let p_image_folder = $(this).siblings("input[name='p_image_folder']").val();
        let p_image = $(this).siblings("input[name='p_image']").val();

        actionForm.append("<input type='hidden' name='p_image' value='" + p_image + "'>");
        actionForm.append("<input type='hidden' name='p_image_folder' value='" + p_image_folder + "'>");
        actionForm.append("<input type='hidden' name='p_num' value='" + $(this).data("p_num") + "'>");
        actionForm.attr("action", "/admin/product/deleteProduct");

        actionForm.submit();
      });
    
    let searchForm = $("#searchForm");
    
    //search 클릭 시 페이지번호 1로 돌아가기
    $("#btnSearch").on("click",function(){
    	searchForm.find("input[name='pageNum']").val(1);
      // searchForm.find("input[name='keyword']").val("");
      searchForm.submit();
    });
    
    //페이지 번호 
    $("ul.pagination li a.page-link").on("click", function(e){
    	e.preventDefault();
    	
    	let pageNum = $(this).attr("href");
    	
    	actionForm.find("input[name='pageNum']").val(pageNum);
    	actionForm.submit();
    });

    //검색 판매여부 선택 시 이벤트
/*     $("#selectType").on("change", function(){
      let p_buy = $(this).find("option[value='Y']").val();
      // console.log("판매여부 선택됨: " + p_buy);

      let inputKeyword = $(this).siblings("input[name='keyword']");

      if(p_buy == "Y"){

        $(this).after("<select name='keyword'><option value='Y'>판매가능</option><option value='N'>판매불가</option></select>");
        inputKeyword.remove();
      } else {
        $(this).find("select[name='keyword']").remove();
        // inputKeyword.show();
      }

    }); */

   $("#selectType").change(function(){
      let result = $("#selectType option:selected").val();
      console.log(result);

      let buyYN = "<select id='buyCan' name='keyword'><option value='Y'>판매가능</option><option value='N'>판매불가</option></select>"
      
      
      $(this).parent().find("input[name='keyword']").val("");
      $(this).parent().find("input[name='keyword']").remove();
      
      //$("#buyCan").remove(); 이게 인식이 안됐음
      $(this).parent().find("select[name='keyword']").remove();


      if(result == "Y") {
        $(this).after(buyYN);  
       
        
      } else  {
        // $(this).parent().find("input[name='keyword']").val("");
        $(this).after("<input type='text' id='keywordTag' name='keyword' value='${pageMaker.cri.keyword}'>");
        
        $("#buyCan").remove();
        
      }

      $(this).parent().find("input[name='keyword']").val("");
      
    }); 
    /*
    $('#selectBox').change(function() {
    var result = $('#selectBox option:selected').val();
    if (result == 'option2') {
      $('.div1').show();
    } else {
      $('.div1').hide();
    }
  });  */

  });
</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>