package com.psamall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}
