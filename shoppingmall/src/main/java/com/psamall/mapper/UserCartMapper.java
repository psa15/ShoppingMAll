package com.psamall.mapper;

import com.psamall.domain.CartVO;

public interface UserCartMapper {

	//장바구니 담기
	void addCart(CartVO vo);
}
