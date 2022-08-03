package com.psamall.service;

import java.util.List;

import com.psamall.domain.OrderCartListVO;

public interface OrderService {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
}
