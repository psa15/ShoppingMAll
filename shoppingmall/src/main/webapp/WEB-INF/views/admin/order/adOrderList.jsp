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
      				<form id="searchForm" action="/admin/order/adOrderList" method="get">
					  <%-- 검색 단추를 누르면 - pageNum은 1로 돌아가게  --%>
					    <select name="type" id="selectType">
							 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
							 <option value="O" <c:out value="${pageMaker.cri.type eq 'O' ? 'selected' : ''}" />>주문 상태</option>
							 <option value="P" <c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}" />>결제 상태</option>
							 <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />>cs 상태</option>
					  	</select>
					  	<c:if test="${pageMaker.cri.type == 'O'}">
					  		<select name="keyword">
						      <option value="상품준비중"${pageMaker.cri.keyword eq '상품준비중' ? 'selected' : ''}>상품준비중</option>
						      <option value="배송준비중"${pageMaker.cri.keyword eq '배송준비중' ? 'selected' : ''}>배송 준비 중</option>
						      <option value="배송보류"${pageMaker.cri.keyword eq '배송보류' ? 'selected' : ''}>배송 보류</option>
						      <option value="배송중"${pageMaker.cri.keyword eq '배송중' ? 'selected' : ''}>배송 중</option>
						      <option value="배송완료"${pageMaker.cri.keyword eq '배송완료' ? 'selected' : ''}>배송 완료</option>
						    </select>
					  	</c:if>
					  	<c:if test="${pageMaker.cri.type == 'P'}">
					  		<select name="keyword">
						      <option value="입금전"${pageMaker.cri.keyword eq '입금전' ? 'selected' : ''}>무통장 입금 전</option>
						      <option value="추가입금대기 "${pageMaker.cri.keyword eq '추가입금대기 ' ? 'selected' : ''}>추가 입금 대기 </option>
						      <option value="결제완료"${pageMaker.cri.keyword eq '결제완료' ? 'selected' : ''}>결제 완료</option>
						    </select>
					  	</c:if>
					  	<c:if test="${pageMaker.cri.type == 'C'}">
					  		<select name="keyword">
						      <option value="취소요청"${pageMaker.cri.keyword eq '취소요청' ? 'selected' : ''}>취소 요청</option>
						      <option value="취소완료"${pageMaker.cri.keyword eq '취소완료' ? 'selected' : ''}>취소 완료</option>
						      <option value="교환요청"${pageMaker.cri.keyword eq '교환요청' ? 'selected' : ''}>교환 요청</option>
						      <option value="교환완료"${pageMaker.cri.keyword eq '교환완료' ? 'selected' : ''}>교환 완료</option>
						      <option value="반품요청"${pageMaker.cri.keyword eq '반품요청' ? 'selected' : ''}>반품요청</option>
						      <option value="반품완료"${pageMaker.cri.keyword eq '반품완료' ? 'selected' : ''}>반품완료</option>
						      <option value="환불요청"${pageMaker.cri.keyword eq '환불요청' ? 'selected' : ''}>환불요청</option>
						      <option value="환불완료"${pageMaker.cri.keyword eq '환불완료' ? 'selected' : ''}>환불완료</option>
						    </select>
					  	</c:if>
					  	<%-- <input type="text" id="keywordTag" name="keyword" value="${pageMaker.cri.keyword}"> --%>
					  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					  	
					  	주문 일자 <input type="date" name="startDate" value="${startDate }"> ~ <input type="date" name="endDate" value="${endDate }">
					  	<button type="button" id="btnSearch" class="btn btn-info">Search</button>
					  </form>
					  <button type="button" name="btnDeleteCheck" class="btn btn-link">선택 삭제</button>
					
					
					  <table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col"><input type="checkbox" id="checkAll" name="checkAll"></th>
						      <th scope="col">주문 번호</th>
						      <th scope="col">주문일시</th>
						      <th scope="col">수령인 / 주문자 아이디 </th>
						      <th scope="col">주문금액 / 배송비</th>
						      <th scope="col">결제 방법 / 결제 상태</th>
						      <th scope="col">주문 상태</th>
						      <th scope="col">CS 상태</th>
						      <th scope="col">주문 상세</th>
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
						      <td>
						      	<select class="form-control" id="pay_status" name="pay_status">
							      <option value="입금전"${ordertVO.pay_status eq '입금전' ? 'selected' : ''}>무통장 입금 전</option>
							      <option value="추가입금대기 "${ordertVO.pay_status eq '추가입금대기 ' ? 'selected' : ''}>추가 입금 대기 </option>
							      <option value="결제완료"${ordertVO.pay_status eq '결제완료' ? 'selected' : ''}>결제 완료</option>
							    </select>
							    <button type="button" name="btnChangePayStatus" data-ord_totalcost="${ordertVO.ord_totalcost}" data-ord_code="${ordertVO.ord_code }" class="btn btn-link">변경</button>
						      </td>
						      <!-- 주문상태 -->
						      <td>
						      	<select class="form-control" id="ord_status" name="ord_status">
							      <option value="상품준비중"${ordertVO.ord_status eq '상품준비중' ? 'selected' : ''}>상품준비중</option>
							      <option value="배송준비중"${ordertVO.ord_status eq '배송준비중' ? 'selected' : ''}>배송 준비 중</option>
							      <option value="배송보류"${ordertVO.ord_status eq '배송보류' ? 'selected' : ''}>배송 보류</option>
							      <option value="배송중"${ordertVO.ord_status eq '배송중' ? 'selected' : ''}>배송 중</option>
							      <option value="배송완료"${ordertVO.ord_status eq '배송완료' ? 'selected' : ''}>배송 완료</option>
							    </select>
							    <button type="button" name="btnChangeOrderStatus" data-ord_code="${ordertVO.ord_code }" class="btn btn-link">변경</button>
						      </td>
						      <!-- CS 상태 -->
						      <td>
						      	<select class="form-control" id="cs_status" name="cs_status">
						      	  <option value="" selected>------------------</option>
							      <option value="취소요청"${ordertVO.cs_status eq '취소요청' ? 'selected' : ''}>취소 요청</option>
							      <option value="취소완료"${ordertVO.cs_status eq '취소완료' ? 'selected' : ''}>취소 완료</option>
							      <option value="교환요청"${ordertVO.cs_status eq '교환요청' ? 'selected' : ''}>교환 요청</option>
							      <option value="교환완료"${ordertVO.cs_status eq '교환완료' ? 'selected' : ''}>교환 완료</option>
							      <option value="반품요청"${ordertVO.cs_status eq '반품요청' ? 'selected' : ''}>반품요청</option>
							      <option value="반품완료"${ordertVO.cs_status eq '반품완료' ? 'selected' : ''}>반품완료</option>
							      <option value="환불요청"${ordertVO.cs_status eq '환불요청' ? 'selected' : ''}>환불요청</option>
							      <option value="환불완료"${ordertVO.cs_status eq '환불완료' ? 'selected' : ''}>환불완료</option>
							     </select>
							     <button type="button" name="btnChangeCsStatus" data-ord_code="${ordertVO.ord_code }" class="btn btn-link">변경</button>
						      </td>
						      
						      <!-- 주문 관리 -->						      
						      <td><button type="button" name="btnOrderDetail" data-ord_code="${ordertVO.ord_code}" class="btn btn-link">주문 상세</button></td>
						      
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
						  <form id="actionForm" action="/admin/order/adOrderList" method="get">
								<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - model 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
								<input type="hidden" name="type" value="${pageMaker.cri.type}">
								<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                				<input type="hidden" name="startDate" value="${startDate}">
                				<input type="hidden" name="endDate" value="${endDate}">
								 <%--한 번 검색하면 list()메소드에 Criteria cri 에 값이 들어가게 되어 위 사용 가능 --%>
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
    
    //주문 상태 변경 작업
    $("button[name='btnChangeOrderStatus']").on("click", function(){
      //console.log("변경 버튼 클릭");
      //주문 번호, 선택한 배송상태 값
      let ord_code = $(this).data("ord_code");
      let ord_status = $(this).parent().find("select#ord_status option:selected").val();
     
      // console.log("주문 번호: " + o_code + " 배송상태: " + o_status);
      $.ajax({
        url: '/admin/order/orderStatusChange',
        method: 'get',
        data: {ord_code : ord_code, ord_status : ord_status},
        dataType: 'text',
        success: function(result) {
          if(result == "success"){
            alert("주문 상태가 변경 되었습니다.")
          }
        }
      });
    });

    //결제 상태 변경 작업
    $("button[name='btnChangePayStatus']").on("click", function(){
      console.log("변경 버튼 클릭");
      
      let ord_code = $(this).data("ord_code");
      let pay_status = $(this).parent().find("select#pay_status option:selected").val();
      let ord_totalcost = $(this).data("ord_totalcost");
      
      console.log(ord_code);
      console.log(pay_status);
      console.log(ord_totalcost);
      
       $.ajax({
        url: '/admin/order/orderPayChange',
        method: 'get',
        data: {ord_code : ord_code, pay_status : pay_status, ord_totalcost : ord_totalcost},
        dataType: 'text',
        success: function(result) {
          if(result == "success"){
            alert("결제 상태가 변경 되었습니다.")
          }
        }
      }); 
    });

    //CS 상태 변경 작업
    $("button[name='btnChangeCsStatus']").on("click", function(){
      //console.log("변경 버튼 클릭");
      //주문 번호, 선택한 배송상태 값
      let ord_code = $(this).data("ord_code");
      let cs_status = $(this).parent().find("select#cs_status option:selected").val();
      // console.log("주문 번호: " + o_code + " 배송상태: " + o_status);
      $.ajax({
        url: '/admin/order/orderCsChange',
        method: 'get',
        data: {ord_code : ord_code, cs_status : cs_status},
        dataType: 'text',
        success: function(result) {
          if(result == "success"){
            alert("CS 상태가 변경 되었습니다.")
          }
        }
      });
    });
    
    //검색 선택 시
    $("#selectType").change(function(){
        let result = $("#selectType option:selected").val();
        console.log(result);

        let orderStatus = "<select id=orderStatusKeyword name='keyword'>";
        	orderStatus +=   "<option value='상품준비중'>상품준비중</option>";	      
       		orderStatus +=   "<option value='배송준비중'>배송 준비 중</option>";
   			orderStatus +=   "<option value='배송보류'>배송 보류</option>";				      
   			orderStatus +=   "<option value='배송중'>배송 중</option>";				      
   			orderStatus +=   "<option value='배송완료'>배송 완료</option>";				      
   			orderStatus += "</select>";	
   		
   		let payStatus = "<select id=payStatusKeyword name='keyword'>";     
	   		payStatus +=   "<option value='입금전'>무통장 입금 전</option>";
	   		payStatus +=   "<option value='추가입금대기'>추가 입금 대기 </option>";			      
	   		payStatus +=   "<option value='결제완료'>결제 완료</option>";				      
	   		payStatus += "</select>";
	   		
	   	let csStatus = "<select id=csStatusKeyword name='keyword'>";
		   	csStatus +=   "<option value='취소요청'>취소 요청</option>";
		   	csStatus +=   "<option value='취소완료'>취소 완료</option>";
		   	csStatus +=   "<option value='교환요청'>교환 요청</option>";			      
		   	csStatus +=   "<option value='교환완료'>교환 완료</option>";	
		   	csStatus +=   "<option value='반품요청'>반품 요청</option>";	
		   	csStatus +=   "<option value='반품완료'>반품 완료</option>";	
		   	csStatus +=   "<option value='환불요청'>환불 요청</option>";
		   	csStatus +=   "<option value='환불완료'>환불 완료</option>";	
		   	csStatus += "</select>";
        
        
        //$(this).parent().find("input[name='keyword']").val("");
        //$(this).parent().find("input[name='keyword']").remove();
        
        
        $(this).parent().find("select[name='keyword']").remove();


        if(result == "O") {
          $(this).after(orderStatus);  
         
        } else if(result == "P") {
        	$(this).after(payStatus); 
        } else if(result == "C") {
        	$(this).after(csStatus); 
        }

        //$(this).parent().find("input[name='keyword']").val("");
        
      });
    
    let searchForm = $("#searchForm");
    
    //search 클릭 시 페이지번호 1로 돌아가기
    $("#btnSearch").on("click",function(){
    	searchForm.find("input[name='pageNum']").val(1);
      // searchForm.find("input[name='keyword']").val("");
      searchForm.submit();
    });
    
    let actionForm = $("#actionForm");
    //페이지 번호 
    $("ul.pagination li a.page-link").on("click", function(e){
    	e.preventDefault();
    	
    	let pageNum = $(this).attr("href");
    	
    	actionForm.find("input[name='pageNum']").val(pageNum);
    	actionForm.submit();
    });
    
  	//체크박스 전체선택
    $("#checkAll").on("click", function(){
      $(".check").prop("checked", this.checked);
    });

  	//데이터 행 체크박스
    $(".check").on("click", function(){

      //데이터 행의 체크박스가 전부 체크되어있다면 전체선택 체크박스도 체크!
      $("#checkAll").prop("checked", this.checked);

      //데이터 행의 체크박스의 선택자 해당하는 만큼 동작하는 구문
      $(".check").each(function() {
        if(!$(this).is(":checked")) {
          //체크가 하나라도 존재시
          $("#checkAll").prop("checked", false);
        }
      });
    });
  	
  //선택한 주문 삭제하기
    $("button[name='btnDeleteCheck']").on("click", function(){

      if($(".check:checked").length == 0){
        alert("삭제할 주문정보를 선택하세요.");
        return;
      }

      let isOrderDel = confirm("선택하신 주문목록을 삭제하시겠습니까?");
      if(!isOrderDel) return;

      //삭제할 주문번호 배열로 받기
      let ordCodeArr = [];
      $(".check:checked").each(function(){
        ordCodeArr.push($(this).val());
      });

      // console.log("선택된 주문번호: " + oCodeArr);

      $.ajax({
        url: '/admin/order/deleteCheckOrder',
        type: 'post',
        dataType: 'text',
        data: {
          ordCodeArr : ordCodeArr
        },
        success: function(result) {
          if(result == "success") {
            alert("선택하신 주문 목록이 삭제되었습니다.");
            
            location.href="/admin/order/adOrderList";
          }
        }
      });

    });

    //주문 상세 클릭
    $("button[name='btnOrderDetail']").on("click", function(){
      console.log("주문번호: " + $(this).data("ord_code"));
      //상품코드를 자식으로 추가
      actionForm.append("<input type='hidden' name='ord_code' value='" + $(this).data("ord_code") + "'>");
      
      //폼태그 주소 변경
      actionForm.attr("action", "/admin/order/adOrderDetail");
      actionForm.submit();
    }); 

  });
</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>