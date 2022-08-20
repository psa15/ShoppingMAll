package com.psamall.service;

import java.util.List;

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
}
