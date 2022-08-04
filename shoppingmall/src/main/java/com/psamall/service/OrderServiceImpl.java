package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	//주문하기
	@Transactional
	@Override
	public void orderSave(OrderVO vo) {

		//1) 주문테이블
		orderMapper.insertOrder(vo);
		
		//2) 주문 상세 테이블
		//시퀀스 값 확보
		Long ord_code = vo.getOrd_code();
		OrderDetailVO odvo = new OrderDetailVO();
		odvo.setOrd_code(ord_code);
		
		orderMapper.insertOrderDetail(odvo);
		
		//3)장바구니 비우기
		String m_id = vo.getM_id();
		userCartMapper.clearCart(m_id);
		
	}
	
	
}
