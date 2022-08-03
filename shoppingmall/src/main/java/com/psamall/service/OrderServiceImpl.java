package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.OrderCartListVO;
import com.psamall.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;
	@Override
	public List<OrderCartListVO> orderCartList(String m_id) {
		return orderMapper.orderCartList(m_id);
	}
	
	
}
