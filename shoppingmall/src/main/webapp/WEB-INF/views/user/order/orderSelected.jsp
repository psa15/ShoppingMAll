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
	
	<!-- Tab 기능 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	

  </head>
  <body>
    
<header>
	<%@include file="/WEB-INF/views/include/header.jsp" %>
</header>

<main role="main">

  <div class="container">
      <!-- 메시지 선택 - select태그 -->
      <div class="row">
      </div>
      
      <!-- 주문 상품 -->
      <div class="row">
	      	<div class="col-md-12">      	
	      		<div class="box box-primary">
	      			<div class="box-header">
	      				<hr>
	      				<h5>주문 상품 </h5>
	      			</div>	
	      			<div class="box-body">
	      				<form action="" id="orderProductListForm" method="post">	      				
						  <table class="table table-hover" id="tblCartList">
							  <thead>
							    <tr>
							      <th scope="col">상품</th>
							      <th scope="col">판매 가격</th>
							      <th scope="col">수량</th>						      						      
							      <th scope="col">적립예정 금액</th>
							      <th scope="col">총 가격</th>
							      <th scope="col">삭제</th>
							    </tr>
							  </thead>
							  <tbody>
							  <c:forEach items="${orderList}" var="orderCartListVO">
							  <c:set var="price" value="${orderCartListVO.cart_amount * orderCartListVO.p_cost}"></c:set>
							    <tr>	
							      <!-- 상품 : 이미지 및 상품이름 -->				      
							      <td>						      	
							      	<a class="move" href="${orderCartListVO.p_num}">
							      		<img src="/user/product/displayFile?folderName=${orderCartListVO.p_image_folder}&fileName=s_${orderCartListVO.p_image}" 
							      		alt="" style="width: 80px; height: 80px" onerror="this.onerror=null; this.src='/image/no_image.png'">
							      		<c:out value="${orderCartListVO.p_name}" />
							      	</a>
							      </td>
							      <!-- 판매 가격 -->
							      <td>
							      	￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${orderCartListVO.p_cost}" />
									<input type="hidden" name="p_cost" value="${orderCartListVO.p_cost}">
							      </td>
							      <!-- 수량 -->
							      <td>
							      	<c:out value="${orderCartListVO.cart_amount}" />개
							      </td>
							      <!-- 적립 예정 금액 -->
							      <td class="text-center" >
							      	<fmt:formatNumber type="number" maxFractionDigits="3" value="${orderCartListVO.p_cost * 0.001}" />
							      </td>	
								  <!-- 상품 가격 * 수량 -->				      
								  <td>
									<span class="unitPrice">						      	
										￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" />
									</span>
								  </td>
							      <!-- 삭제 -->
							      <td>
				                    <input type="hidden" name="p_image_dateFolder" value="${orderCartListVO.p_image_folder}">
				                    <input type="hidden" name="p_image" value="${orderCartListVO.p_image}">
				                    <input type="hidden" name="ord_cost" value="${orderCartListVO.p_cost * orderCartListVO.cart_amount}" >
						  <input type="hidden" name="p_num" value="${orderCartListVO.p_num}" >
						  <input type="hidden" name="ord_amount" value="${orderCartListVO.cart_amount}" >
				                    <button type="button" name="btnCartDelete" data-cart_code="${orderCartListVO.cart_code}" class="btn btn-link">X</button></td>
							    </tr>
							    <c:set var="sum" value="${sum + price}"></c:set>
							   </c:forEach>					   
							  </tbody>
							  <tfoot>
								<tr>
									<c:if test="${!empty orderCartList}">
										<td colspan="5" style="text-align: right"> 
											총 구매 금액: ￦ <span id="cartTotalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sum}" /></span>
										</td>
									</c:if>
									<c:if test="${empty orderCartList}">
										<td colspan="5" style="text-align: right"> 
											주문 내역이 비었습니다.
										</td>
									</c:if>
								</tr>
							  </tfoot>
							</table>	
						</form>						
	      			</div>
	      			
	      					
	      		</div>     
	      	</div>      
	      </div>
	      
	      <!-- 상품 상세정보 및 리뷰 탭 -->
	      <div class="row">
		      	<div class="col-md-12">      	
		      		<div class="box box-primary">
		      			<div>
		      				<form id="orderForm" method="post" action="">
		      				  <h5>주문자 정보</h5>
		      				  <hr>
							  <div class="form-group row">
							    <label for="m_name" class="col-sm-2 col-form-label">이름</label>
							    <div class="col-sm-10">
							      <c:out value="${sessionScope.loginStatus.m_name}" />
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="m_email" class="col-sm-2 col-form-label">이메일</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" name="m_email" readonly value="${sessionScope.loginStatus.m_email}">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="m_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" name="m_tel" readonly value="${sessionScope.loginStatus.m_tel}">
							      <input type="hidden" class="form-control" name="s_o_post" value="${sessionScope.loginStatus.m_postcode}">
							      <input type="hidden" class="form-control" name="s_o_addr" value="${sessionScope.loginStatus.m_addr}">
							      <input type="hidden" class="form-control" name="s_o_addr_d" value="${sessionScope.loginStatus.m_addr_d}">
							    </div>
							  </div>
							  <input type="checkbox" id="same"><label for="same"> 위 정보와 같음</label>
							  <hr>
							  <h5>배송 정보</h5>
		      				  <hr>
							  <div class="form-group row">
							    <label for="ord_name" class="col-sm-2 col-form-label">이름</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_name" name="ord_name">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="ord_tel" class="col-sm-2 col-form-label">휴대폰 번호</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_tel" name="ord_tel">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="mem_phone" class="col-sm-2 col-form-label">배송지 선택</label>
							    <div class="col-sm-10">
							      <div class="form-check form-check-inline">
								  	<input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr1" value="1" checked>
								  	<label class="form-check-label" for="inlineRadio1">자택</label>
								   </div>
								   <div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="receiveAddr" id="receiveAddr2" value="2">
									  <label class="form-check-label" for="inlineRadio2">타지역</label>
								   </div>
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="ord_postcode" class="col-sm-2 col-form-label">우편번호</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_postcode" name="ord_postcode" value="${sessionScope.loginStatus.m_postcode}">
							      <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="ord_addr" class="col-sm-2 col-form-label">주소</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_addr" name="ord_addr" value="${sessionScope.loginStatus.m_addr}">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="ord_addr_d" class="col-sm-2 col-form-label">상세주소</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_addr_d" name="ord_addr_d" value="${sessionScope.loginStatus.m_addr_d}">
							      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="ord_email" class="col-sm-2 col-form-label">이메일</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" id="ord_email" name="ord_email">
							    </div>
							  </div>
							  <div class="form-group row">
							  	<label for="" class="col-sm-2 col-form-label">배송 메시지</label>
							    <select name="selectBox">
							      <option value="" selected>--메시지 선택 (선택 사항)--</option>
							      <option value="배송 전에 미리 연락 바랍니다.">배송 전에 미리 연락 바랍니다.</option>
							      <option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
							      <option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
							      <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
							      <option value="택배함에 보관해 주세요.">택배함에 보관해 주세요.</option>
							      <option value="newMessage">직접 입력</option>
							    </select>
								<input type="text" name="ord_message" id="newMessage">
								<input type="hidden" name="ord_totalcost" value="${sum}">
							  </div>
							</form>
		      			</div>      	
					 
				</div>
	      	</div>      	
	      </div>
      	
		<div class="box-footer text-center">
		<c:if test="${!empty orderCartList}">
			<button type="button" id="btnCancelOrder"  class="btn btn-primary">주문취소</button>
			<button type="button" id="btnOrder"  class="btn btn-primary">주문하기</button>
		</c:if>
		<c:if test="${empty orderCartList}">
			<button type="button" name="btnShopping"  class="btn btn-primary">쇼핑하기</button>
		</c:if>
    </div>	
				
				
    </div>  

</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	

	<script>

		$(function(){

			//jQuery-ui 탭기능
			$("#productDetailTabs").tabs();
			
			//위 정보와 같을 때 체크박스
			$("#same").on("click", function(){

				if($("#same").is(":checked") == true) {
					$("#ord_name").val("${sessionScope.loginStatus.m_name}");
					$("#ord_tel").val($("input[name='m_tel']").val());
					$("#ord_email").val($("input[name='m_email']").val());
				} else{
					$("#ord_name").val("");
					$("#ord_tel").val("");
					$("#ord_email").val("");
				}
				
			});
			
			$("#newMessage").hide();
			
			
			//배송 메시지 직접입력 선택 시
			$("select[name='selectBox']").on("change", function(){
				
				if($(this).val() == 'newMessage') {
					$("#newMessage").show();
										
				} else {
					$("#newMessage").hide();
				}
			});


			//주문하기 버튼 클릭 시
			$("#btnOrder").on("click", function(){

				//유효성 검사

				let ord_message = $("select[name='selectBox']").val();
				if(ord_message != 'newMessage') {
					$("#newMessage").val(ord_message);
				} 
				//console.log("o_message 값: " + $("#newMessage").val());
				$("#orderForm").attr("action", "/user/order/addOrder");
				$("#orderForm").submit();
			});

		});

		

	</script>
	
	<%-- 우편번호와 주소 입력 폼 - kakao 우편번호 api 사용 (함수이름이나 id값 변경함)
    		https://postcode.map.daum.net/guide --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('ord_postcode').value = data.zonecode;
	                document.getElementById("ord_addr").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("ord_addr_d").focus();
	            }
	        }).open();
	    }
	</script>

<!-- bootstrap에 포함되어 있던 스크립트, 없어도 영향이 없어서 주석처리 
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
    --> <!-- <script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script> -->


      
  </body>
</html>
