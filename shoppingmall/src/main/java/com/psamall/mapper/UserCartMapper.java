package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;

public interface UserCartMapper {

	//장바구니 담기
	void addCart(CartVO vo);
	
	//장바구니 목록
	List<CartListVO> getCartList(String m_id);
	
	//장바구니 수량변경
	void updateCartAmount(@Param("cart_code") Long cart_code, @Param("cart_amount") int cart_amount);
}
