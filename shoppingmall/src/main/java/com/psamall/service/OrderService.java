package com.psamall.service;

import java.util.List;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;

public interface OrderService {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
	
	//주문하기
	void orderSave(OrderVO vo);
}
