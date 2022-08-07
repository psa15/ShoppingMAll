package com.psamall.service;

import java.util.List;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.dto.OrderProductDTO;
import com.psamall.dto.OrderProductListDTO;

public interface OrderService {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
	//장바구니 외 주문
	List<OrderCartListVO> orderDirectList(Integer p_num, int ord_amount);
	
	//선택한 상품 주문
	List<OrderProductDTO> getSelectedProduct(List<OrderProductDTO> dto);
	
	
	//주문하기
	void orderSave(OrderVO vo);
}
