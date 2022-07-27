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
	
}
