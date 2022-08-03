package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.OrderCartListVO;

public interface OrderMapper {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
}
