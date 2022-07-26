package com.psamall.service;

import com.psamall.domain.CartVO;

public interface UserCartService {

	//장바구니 담기
	void addCart(CartVO vo);
}
