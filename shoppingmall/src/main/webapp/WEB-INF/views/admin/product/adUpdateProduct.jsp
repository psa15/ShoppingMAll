<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
      	<form id="productForm" method="post" action="updateProduct" enctype="multipart/form-data">
      		<div class="box box-primary">
      			<div class="box-header">
      				REGISTER PRODUCT
      			</div>
      			<div class="box-body">      				
					  <div class="form-group row">
					  
					  	<!-- 페이징 및 검색 정보 -->
	  				    <input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="type" value="${cri.type}">
						<input type="hidden" name="keyword" value="${cri.keyword}">						
						
						<label for="category" class="col-sm-2 col-form-label">카테고리</label>					  
					    <div class="col-sm-10">
					      <select id="firstCategory" name="f_ct_code">
					      	<option>1차 카테고리 선택 </option>
					      	<c:forEach items="${firstCateList}" var="fCateList">
					      		<option value="${fCateList.ct_code}" ${fCateList.ct_code == productVO.f_ct_code ? 'selected' : ''}>${fCateList.ct_name} </option>
					      	</c:forEach>
					      </select>
					      <select id="secondCategory" name="s_ct_code">
					      	<option>2차 카테고리 선택 </option>
					      	<c:forEach items="${secondCateList}" var="secCateList">
					      		<option value="${secCateList.ct_code}" ${secCateList.ct_code == productVO.s_ct_code ? 'selected' : ''}>${secCateList.ct_name} </option>
					      	</c:forEach>
					      </select>
					    </div>					    
					  </div>
					  <div class="form-group row">
					    <label for="p_name" class="col-sm-2 col-form-label">상품명</label>
					    <div class="col-sm-4">
					      <input type="hidden" id="p_num" name="p_num" value="${productVO.p_num }">
					      <input type="text" class="form-control" id="p_name" name="p_name" value="${productVO.p_name }">					     
					    </div>
					    <label for="p_cost" class="col-sm-2 col-form-label">상품가격</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_cost" name="p_cost" value="${productVO.p_cost }">					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="p_discount" class="col-sm-2 col-form-label">할인율</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_discount" name="p_discount" value="${productVO.p_discount }">					     
					    </div>
					    <label for="p_company" class="col-sm-2 col-form-label">제조사</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_company" name="p_company" value="${productVO.p_company }">					     
					    </div>
					  </div>
					  <div class="form-group row">
					  	<label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지</label>
					  	<div class="col-sm-10">
					      <input type="file" class="form-control" id="uploadFile" name="uploadFile">
					      
					      <input type="hidden" name="p_image" value="${productVO.p_image}">
					      <input type="hidden" name="p_image_folder" value="${productVO.p_image_folder}">					  	
					  	</div>
					  </div>
					  <div class="form-group row">
					    <label for="cur_img" class="col-sm-2 col-form-label">현재 이미지</label>
					    <div class="col-sm-4">
					    	<img alt="" id="cur_img" style="width: 200px; height: 200px;" src="/admin/product/displayFile?folderName=${productVO.p_image_folder}&fileName=${productVO.p_image}"> 				     
					    </div>
					    <label for="change_img" class="col-sm-2 col-form-label">변경 이미지</label>
					    <div class="col-sm-4">
					    	<img alt="" id="change_img"> 				     
					    </div>
					  </div>
					  <div class="form-group row">  				  
					    <label for="p_detail" class="col-sm-2 col-form-label">상품 설명</label>
					    <div class="col-sm-10">
					      <textarea class="form-control" name="p_detail" rows="3">${productVO.p_detail }</textarea>					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="p_amount" class="col-sm-2 col-form-label">수량</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_amount" name="p_amount" value="${productVO.p_amount }">					     
					    </div>
					    <label for="p_buy_ok" class="col-sm-2 col-form-label">판매여부</label>
					    <div class="col-sm-4">
					      <select id="p_buy_ok" name="p_buy_ok">
					      	<option value="Y" ${productVO.p_buy_ok eq 'Y' ? 'selected' : ''}>판매가능</option>
					      	<option value="N" ${productVO.p_buy_ok eq 'N' ? 'selected' : ''}>판매불가</option>
					      </select>					     
					    </div>
					  </div>					
      			</div>
      			<div class="box-footer">
      				<div class="form-group">
    					<ul class="uploadedList"></ul>
      				</div>
      				<div class="form-group row">
      					<div class="col-md-12">
      						<button type="submit" class="btn btn-dark text-center" id="btnProduct">상품수정</button>
      					</div>
      				</div>
      			</div>
      		</div>
      	</form>
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
	  
    //CKEditor 환경 설정
    var ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath", 
			filebrowserUploadUrl: '/admin/product/imageUpload' //업로드 탭기능추가 속성
    }

    CKEDITOR.replace("p_detail", ckeditor_config);

    //1차 카테고리 선택 시 2차 카테고리 불러오기
    $("#firstCategory").on("change", function(){

      //선택된 1차 카테고리 코드
      let firstCategoryCode = $(this).val();
      console.log("1차 카테고리 코드: " + firstCategoryCode);

      //2차 카테고리 코드를 불러올 주소
      let url = "/admin/product/secondCateList/" + firstCategoryCode;

      $.getJSON(url, function(sec_CateList){
        // console.log("첫 번째 카테고리 코드: " + subCateList[0].ct_code);
        // console.log("첫 번째 카테고리 이름: " + subCateList[0].ct_name);
        //console.log("두 번째 카테고리 코드: " + subCateList[1].ct_code);

        //2차 카테고리 태그
        let secondCategory = $("#secondCategory");
        let optionTag = "";
        
        //1차 카테고리를 변경하면 전에 선택했던 카테고리 정보가 지워져야 함
        secondCategory.find("option").remove();
        secondCategory.append("<option value =''>2차 카테고리 선택</option>");

         for(let i=0; i<sec_CateList.length; i++) {
          optionTag += "<option value='" + sec_CateList[i].ct_code + "'>" + sec_CateList[i].ct_name + "</option>";
        }

        secondCategory.append(optionTag);
      });
    });
    
  	//이미지 미리보기
    $("#uploadFile").on("change", function(e){

      let file = e.target.files[0];
      //.files[0] : 만약 파일이 여러개라면 그 중 첫번재 파일!

      let reader = new FileReader();
      //FileReader() 객체 : 비동기적으로 데이터를 읽음 (ajax메소드가 다 비동기적인 방식)
      //동기적 방식 : 질문 하나를 하고 난 후 답변을 받을 때까지 다른 행위를 못함 - 이 코드가 끝날 때까지 다른 코드 동작 X
      //비동기적 방식 : 질문 하나를 던져놓고 다른 행위 할 수 있음 - 이 코드가 안끝나도 다른 코드 동작 가능

      reader.onload = function(e){
        //reader.onload : reader객체가 reader.readAsDataURL(file); 이 읽기 동작이 성공적으로 완료 되었을 때마다 발생

        $("#change_img").attr("src", e.target.result);
        //e.target.result : 읽어들인 이미지 파일 명

        $("#change_img").attr("style", "width: 200px; height: 200px;");
        //이미지 크기조절
      }
      
      reader.readAsDataURL(file);
    });
  	
  	$("#btnProduct").on("clicl",function(e){
  		e.preventDefault();
      console.log("상품 수정하기");
  	});

  });
</script>


<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>