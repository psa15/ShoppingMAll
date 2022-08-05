package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.psamall.domain.CartVO;
import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderDetailVO;
import com.psamall.domain.OrderVO;
import com.psamall.mapper.OrderMapper;
import com.psamall.mapper.UserCartMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private UserCartMapper userCartMapper;
	
	//주문 페이지 주문 상품 목록
	@Override
	public List<OrderCartListVO> orderCartList(String m_id) {
		return orderMapper.orderCartList(m_id);
	}

	//장바구니 외 주문
	@Override
	public List<OrderCartListVO> orderDirectList(Integer p_num, int ord_amount) {
		return orderMapper.orderDirectList(p_num, ord_amount);
	}
	
	//주문하기
	@Transactional
	@Override
	public void orderSave(OrderVO vo) {

		//1) 주문테이블
		orderMapper.insertOrder(vo);
		
		//2) 주문 상세 테이블
		//시퀀스 값 확보
		Long ord_code = vo.getOrd_code();
		String m_id = vo.getM_id();
		
		orderMapper.insertOrderDetail(ord_code, m_id, p_num);;
		
		//3)장바구니 비우기
		OrderDetailVO orderDetailVO = new OrderDetailVO();
		Integer p_num = orderDetailVO.getP_num();
		userCartMapper.deleteCartOrder(p_num);
		
	}

	
	
}
