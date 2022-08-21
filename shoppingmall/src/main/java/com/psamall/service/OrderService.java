package com.psamall.service;

import java.util.List;
import java.util.Map;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;

public interface OrderService {

	//주문 페이지 주문 상품 목록
	OrderCartListVO orderCartList(Integer cart_code, String m_id);
	//장바구니 외 주문
	List<OrderCartListVO> orderDirectList(Integer p_num, int ord_amount);
	
	//주문하기(주문 정보 + 결제 정보)
	void orderSave(OrderVO orderVO, PaymentVO payVO);
	
	//주문완료 후 주문 정보 불러오기
	OrderVO getOrderInfo(String m_id);
	
	//주문내역
	List<Map<String, Object>> getOrderHistory(String m_id);
}
