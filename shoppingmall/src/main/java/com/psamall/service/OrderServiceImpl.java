package com.psamall.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.OrderProductDTO;
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
	public OrderCartListVO orderCartList(Integer cart_code, String m_id) {
		return orderMapper.orderCartList(cart_code, m_id);
	}

	
	//주문하기(주문 정보 + 결제 정보)
	@Transactional
	@Override
	public void orderSave(OrderVO orderVO, PaymentVO payVO, Integer p_num) {

		//1) 주문테이블
		orderMapper.insertOrder(orderVO);
		
		//2) 주문 상세 테이블
		//시퀀스 값 확보
		Long ord_code = orderVO.getOrd_code();
		String m_id = orderVO.getM_id();
		
		orderMapper.insertOrderDetail(ord_code, m_id, p_num);
		
		//3) 결제 정보
		payVO.setOrd_code(ord_code);
		orderMapper.insertPayment(payVO);
		
	}	

	//주문완료 후 주문 정보 불러오기
	@Override
	public OrderVO getOrderInfo(String m_id) {
		return orderMapper.getOrderInfo(m_id);
	}

	//장바구니 외 목록
	@Override
	public List<OrderCartListVO> orderDirectList(Integer p_num, int ord_amount) {
		return orderMapper.orderDirectList(p_num, ord_amount);
	}

	//주문내역
	@Override
	public List<Map<String, Object>> getOrderHistory(String m_id, String startDate, String endDate) {
		return orderMapper.getOrderHistory(m_id, startDate, endDate);
	}

	


	
	
}
