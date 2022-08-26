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

  <div class="row">
      	<div class="col-md-12">
      	<form id="productForm" method="post" action="addProduct" enctype="multipart/form-data">
      		<div class="box box-primary">
      			<div class="box-header">
      				REGISTER PRODUCT
      			</div>
      			<div class="box-body">      				
					  <div class="form-group row">
						<label for="category" class="col-sm-2 col-form-label">카테고리</label>					  
					    <div class="col-sm-10">
					      <select id="firstCategory" name="f_ct_code">
					      	<option>1차 카테고리 선택 </option>
					      	<c:forEach items="${firstCateList}" var="fCateList">
					      		<option value="${fCateList.ct_code}">${fCateList.ct_name} </option>
					      	</c:forEach>
					      </select>
					      <select id="secondCategory" name="s_ct_code">
					      	<option>2차 카테고리 선택 </option>
					      </select>
					    </div>					    
					  </div>
					  <div class="form-group row">
					    <label for="p_name" class="col-sm-2 col-form-label">상품명</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_name" name="p_name">					     
					    </div>
					    <label for="p_cost" class="col-sm-2 col-form-label">상품가격</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_cost" name="p_cost">					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="p_discount" class="col-sm-2 col-form-label">할인율</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_discount" name="p_discount">					     
					    </div>
					    <label for="p_company" class="col-sm-2 col-form-label">제조사</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_company" name="p_company">					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지</label>
					    <div class="col-sm-4">
					      <input type="file" class="form-control" id="uploadFile" name="uploadFile">					     
					    </div>
					    <label for="cur_img" class="col-sm-2 col-form-label">이미지 미리보기</label>
					    <div class="col-sm-4">
					    	<img alt="" id="change_img"> 				     
					    </div>
					  </div>
					  <div class="form-group row">  				  
					    <label for="p_detail" class="col-sm-2 col-form-label">상품 설명</label>
					    <div class="col-sm-10">
					      <textarea class="form-control" name="p_detail" rows="3"></textarea>					     
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="p_amount" class="col-sm-2 col-form-label">수량</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="p_amount" name="p_amount">					     
					    </div>
					    <label for="p_buy_ok" class="col-sm-2 col-form-label">판매여부</label>
					    <div class="col-sm-4">
					      <select id="p_buy_ok" name="p_buy_ok">
					      	<option value="Y">판매가능</option>
					      	<option value="N">판매불가</option>
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
      						<button type="submit" class="btn btn-dark text-center" id="btnProduct">상품등록</button>
      					</div>
      				</div>
      			</div>
      		</div>
      	</form>
      	</div>      
      </div>  

</main>

<footer class="text-muted">
  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</footer>

	

	<script>

		$(function(){
			
			
			
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

			//은행과 입금자 명은 결제방법을 무통장 입금으로 선택했을 때만 나오게
			$("#bank").hide();
			$("div#noAccountUsername").hide();
			
			//결제 방법 선택
			$("#pay_method").on("change", function(){
				
				$("#bank").hide();
				$("div#noAccountUsername").hide();

				if($(this).val() == '') {
					alert("결제 방법을 선택해 주세요");
					return;
				}

				if($(this).val() == '무통장 입금') {
					$("#bank").show();
					$("div#noAccountUsername").show();
				}
				
				$("#btnOrder").attr("disabled", false); //비활성화 -> 활성화
				$("img#kakao_pay").css("display", "none");

				//카카오 페이 선택 시
				if($("#pay_method option:selected").val() =="카카오 페이") {
					alert("카카오페이 이미지를 클릭하세요");

					//ajax구문에서 카카오페이라는 값을 pay_method로 보내주기 위해
					pay_method = $("#pay_method option:selected").val();

					$("#btnOrder").attr("disabled", true); //활성화 -> 비활성화
					$("#kakao_pay").attr("style", "display:inline;");
					return;
				}
			});
			
			//카카오페이 버튼 클릭(ajax구문으로 사용해야 함)
			$("img#kakao_pay").on("click", function(){

				//카카오 페이에서 요청하는 필수 입력값 확보
				
				//주문자				
				let ord_name = $("input[name='ord_name']").val();
				//연락처
				let ord_tel = $("input[name='ord_tel']").val();
				//전자우편
				let ord_email = $("input[name='ord_email']").val();
				//전체금액
				let ord_totalcost = $("input[name='ord_totalcost']").val();
				//적립금
				//쿠폰

				$.ajax({
					url: '/user/order/orderPay',
					type: 'get',
					data: {
						totalAmount : ord_totalcost,

						ord_name : ord_name,
						ord_postcode : $("input[name='ord_postcode']").val(),
						ord_addr : $("input[name='ord_addr']").val(),
						ord_addr_d : $("input[name='ord_addr_d']").val(),
						ord_tel : ord_tel,
						ord_totalcost : ord_totalcost,
						ord_message : $("select[name='selectBox']").val(),
						pay_status : '결제완료',

						pay_method : pay_method,
						pay_tot_price : ord_totalcost,



					},
					success: function(response) {
						//alert(response.next_redirect_pc_url);
						location.href = response.next_redirect_pc_url;
					}

				});
			});

			//무통장 입금 선택 시
			$("#bank").on("change", function(){
				
				if($(this).val() == '') {
					alert("입금 은행을 선택해 주세요");
					return;
				}

				$("#pay_noAccount_bank").val($("#bank option:selected").text().substring(0,5));
			});

			//주문하기 버튼 클릭 시
			let orderForm = $("#orderForm");
			$("#btnOrder").on("click", function(){

				//console.log("버튼클릭");
				//유효성 검사
				
				//카트 코드 받아서 orderForm에 추가해주기???
				//값들의 갯수 -> 배열 길이를 지정
				let valueLength = $("input[name='cart_code']").length;
				//배열 생성
				let cartCodeArr = new Array(valueLength);
				//배열에 값 주입
				for(let i=0; i<valueLength; i++){                          
					cartCodeArr[i] = $("input[name='cart_code']").eq(i).val();
				}
				//console.log(cartCodeArr[0]);
				//console.log(cartCodeArr[1]);

				let url = "";

				for(let i=0; i<valueLength; i++){
					url += "<input type='hidden' class='form-control' name='cartCodeArr' value='" + cartCodeArr[i] + "'>"
				}
				//console.log(url);
				
				orderForm.append(url);

				//상품번호
				let pNumValueLength = $("input[name='p_num']").length;
				console.log(pNumValueLength);
				//배열 생성
				let pNumArr = new Array(pNumValueLength);
				//배열에 값 주입
				for(let i=0; i<pNumValueLength; i++){                          
					pNumArr[i] = $("input[name='p_num']").eq(i).val();
				}
				console.log(pNumArr[0]);
				console.log(pNumArr[1]);

				url = "";

				for(let i=0; i<pNumValueLength; i++){
					url += "<input type='hidden' class='form-control' name='pNumArr' value='" + pNumArr[i] + "'>"
				}
				console.log(url);

				orderForm.append(url);
				

				let ord_message = $("select[name='selectBox']").val();
				if(ord_message != 'newMessage') {
					$("#newMessage").val(ord_message);
				} 
				//console.log("o_message 값: " + $("#newMessage").val());
				
				let totalPrice = $("#cartTotalPrice").text();
				let total = $.withoutCommas(totalPrice);
				console.log(total);
				
				$("input[name='ord_totalcost']").val(total);
				$("#pay_tot_price").val(total);
				
				orderForm.attr("action", "/user/order/addOrder");
				orderForm.submit();
			}); 

			$("button[name='btnCalProduct']").on("click", function(){
				console.log("계산하기");
			});
			

		});

		//총 가격 계산하기(배송비, 총 가격, 적립금)
		function totalInfo(){

			let totalCost = 0; //주문할 상품 총 가격
			let deliveryCost = 0; //배송비
			let totalPoint = 0; //상품 주문시 적립될 포인트
			let realTotalCost = 0; //상품 총 가격 + 배송비

			//상품 계산
			$(".calProduct").each(function(index, item){		
			
				totalCost += parseInt($(item).find("input[name='ord_cost']").val());
				totalPoint += parseInt($(item).find(".productPointForCal").val());
								
			});

			//배송비
			if(totalCost >= 30000) {
				deliveryCost = 0;
			} else if(totalCost == 0) {
				deliveryCost = 0;
			} else {
				deliveryCost = 3000;
			}

			realTotalCost = totalCost + deliveryCost;

			//상품 총 금액
			$("#productTotalPrice").text($.numberWithCommas(totalCost));
			//배송비
			$("#deliveryPrice").text($.numberWithCommas(deliveryCost));
			//총 구매 금액(상품 총 금액 + 배송비)
			$("#cartTotalPrice").text($.numberWithCommas(realTotalCost));
		}

		//숫자값을 천단위 마다 콤마 찍기
		$.numberWithCommas = function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		//3자리마다 콤마 제거하기
		$.withoutCommas = function (x) {
			return x.toString().replace(",", '');
		}

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
