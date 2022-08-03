package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;

public interface OrderMapper {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
	
	//최근 배송지 불러오기
	OrderVO getRecentAddr(String m_id);
}
