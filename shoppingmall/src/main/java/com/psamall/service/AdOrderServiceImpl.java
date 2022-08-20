package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.OrderVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderMapper adOrderMapper;
	
	//주문 목록
	@Override
	public List<OrderVO> getOrderList(Criteria cri) {
		return adOrderMapper.getOrderList(cri);
	}

	//총 주문 개수
	@Override
	public int getTotalOrder(Criteria cri) {
		return adOrderMapper.getTotalOrder(cri);
	}

}
