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
      				LIST ORDER DETAIL    
      			</div>	
      			<div class="box-body">
      			<h3>주문 상세 조회</h3>
      			
      			  <h5 style="color:red; font-weight:bold">주문 정보</h5>
				  <table class="table table-bordered">
					  <thead>
					    <tr>
					      <th scope="col">주문번호</th>
					      <td scope="col">${orderInfo.ord_code}</td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="col">주문일자</th>
					      <td scope="col"><fmt:formatDate value="${orderInfo.ord_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
					    </tr>
					    <tr>
					      <th scope="col">주문자</th>
					      <td scope="col">${orderInfo.ord_name}</td>
					    </tr>
					    <tr>
					      <th scope="col">주문 처리 상태</th>
					      <td scope="col">${orderInfo.ord_status}</td>
					    </tr>
					    <tr>
					      <th scope="col">배송 메시지</th>
					      <td scope="col">${orderInfo.ord_message}</td>
					    </tr>
					  </tbody>
					</table>
					
					<h5 style="color:red; font-weight:bold">결제 정보</h5>
					  <table class="table table-bordered">
						  <tbody>
						    <tr>
						      <th scope="col">총 결제 금액</th>
						      <td scope="col">${paymentInfo.pay_tot_price}</td>
						    </tr>
						    <tr>
						      <th scope="col">결제 수단</th>
						      <td scope="col">${paymentInfo.pay_method}</td>
						    </tr>
						    <tr>
						      <th scope="col">결제 상태</th>
						      <td scope="col">${orderInfo.pay_status}</td>
						    </tr>
						  </tbody>
						</table>
						
						<h5 style="color:red; font-weight:bold">주문 상품 정보</h5>
						<table class="table table-bordered">
						  <thead>
						  <!--  -->
						    <tr>
						      <th scope="col">이미지</th>
						      <th scope="col">상품 정보</th>
						      <th scope="col">수량</th>
						      <th scope="col">상품 금액</th>
						      <th scope="col">주문 처리 상태</th>
						      <th scope="col">취소/교환/반품</th>
						    </tr>
						  </thead>
						  <tbody>
						  	<c:forEach items="${orderProductList }" var="orderProduct">
							    <tr>
							      <!-- MAP의 키를 대문자로 입력 -->							      
							      <td scope="col">
								      <img src="/admin/product/displayFile?folderName=${orderProduct.P_IMAGE_FOLDER }&fileName=s_${orderProduct.P_IMAGE }" 
							      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">							      		 
							      </td>
							      <td scope="col">${orderProduct.P_NAME}</td>
							      <td scope="col">${orderProduct.ORD_AMOUNT}</td>
							      <td scope="col">${orderProduct.ORD_UNITPRICE}</td>
							      <td scope="col">${orderProduct.ORD_STATUS}</td>
							      <td scope="col">
							      	<button type="button" name="btnCancelProduct" data-ord_code="${orderInfo.ord_code}" class="btn btn-link">취소</button>
							      	<input type="hidden" name="ord_unitprice" value="${orderProduct.ORD_UNITPRICE}">
							      	<input type="hidden" name="p_num" value="${orderProduct.P_NUM}">
							      	<input type="hidden" name="pay_tot_price" value="${paymentInfo.pay_tot_price}">
							      </td>
							    </tr>
						    </c:forEach>
						  </tbody>
						</table>					
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
    
  	
    //상품 삭제버튼
    $("button[name='btnCancelProduct']").on("click", function(){

      //console.log("버튼 클릭");

      let ord_code = $(this).data("ord_code");
      let p_num = $(this).parent().find("input[name='p_num']").val();
      let ord_unitprice = $(this).parent().find("input[name='ord_unitprice']").val();
      //console.log("ord_unitprice: " + ord_unitprice);
      //console.log("p_num: " + p_num);

      $.ajax({
        url: '/admin/order/deleteProduct',
        type: 'post',
        dataType: 'text',
        data: {
          p_num : p_num,
          ord_unitprice : ord_unitprice,
          ord_code : ord_code
        },
        success: function(result) {
          if(result == "success") {
            alert("선택하신 상품이 삭제되었습니다.");
            
            location.href="/admin/order/adOrderDetail";
          }
        }
      });

    });
  

  });
</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>