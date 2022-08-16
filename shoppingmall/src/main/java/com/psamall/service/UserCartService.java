package com.psamall.service;

import java.util.List;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;

public interface UserCartService {

	//장바구니 담기
	void addCart(CartVO vo);
	
	//장바구니 목록
	List<CartListVO> getCartList(String m_id);
	
	//장바구니 수량변경
	void updateCartAmount(Long cart_code, int cart_amount);
	
	//장바구니 상품 삭제
	void deleteCart(Long cart_code);
	
	//장바구니 주문 상품 삭제
	void deleteCartOrder(Integer p_num);
	
	//장바구니 비우기
	void clearCart(String m_id);
	
	//장바구니 개수
	int totalCart(String m_id);
}
