package com.psamall.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.Criteria;

public interface AdOrderService {

	//주문 목록
	List<OrderVO> getOrderList(Criteria cri, String startDate, String endDate);
	//총 주문 개수
	int getTotalOrder(Criteria cri, String startDate, String endDate);
	
	//주문 상태 변경
	void updateOrderStatus(Long ord_code, String ord_status);
	//결제 상태 변경
	void updatePayStatus(Long ord_code, String pay_status);
	//CS 상태 변경
	void updateCsStatus(Long ord_code, String cs_status);
	
	//회원이 주문취소할 경우 주문 삭제
	void deleteOrder(Long ordCodeArr);
	
	//주문 상세 페이지
	//주문 정보
	OrderVO getOrderInfo(Long ord_code);
	//결제 정보
	PaymentVO getPaymentInfo(Long ord_code);
	//총 가격 수정
	void updatePrice(Long ord_code, int totalPrice);
	//주문 상품 정보
	List<Map<String, Object>> getOrderProductInfo(Long ord_code);
	
	//개별 상품 삭제
	void deleteProduct(Long ord_code, Integer p_num, int ord_unitprice);
}
