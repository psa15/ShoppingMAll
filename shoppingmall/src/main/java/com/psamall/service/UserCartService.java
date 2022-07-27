package com.psamall.service;

import java.util.List;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;

public interface UserCartService {

	//장바구니 담기
	void addCart(CartVO vo);
	
	//장바구니 목록
	List<CartListVO> getCartList(String m_id);
}
