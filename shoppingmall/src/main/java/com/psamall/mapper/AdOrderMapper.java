package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.OrderVO;
import com.psamall.dto.Criteria;

public interface AdOrderMapper {

	//주문 목록
	List<OrderVO> getOrderList(Criteria cri);
	//총 주문 개수
	int getTotalOrder(Criteria cri);
}
