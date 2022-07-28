package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;
import com.psamall.mapper.UserCartMapper;

import lombok.Setter;

@Service
public class UserCartServiceImpl implements UserCartService {

	@Setter(onMethod_ = {@Autowired})
	private UserCartMapper cartMapper;

	//장바구니 담기
	@Override
	public void addCart(CartVO vo) {
		cartMapper.addCart(vo);
	}

	//장바구니 목록
	@Override
	public List<CartListVO> getCartList(String m_id) {
		return cartMapper.getCartList(m_id);
	}

	//장바구니 수량변경
	@Override
	public void updateCartAmount(Long cart_code, int cart_amount) {
		cartMapper.updateCartAmount(cart_code, cart_amount);
	}

	//장바구니 상품 삭제
	@Override
	public void deleteCart(Long cart_code) {
		cartMapper.deleteCart(cart_code);
	}

	//장바구니 비우기
	@Override
	public void clearCart(String m_id) {
		cartMapper.clearCart(m_id);
	}
	
}
