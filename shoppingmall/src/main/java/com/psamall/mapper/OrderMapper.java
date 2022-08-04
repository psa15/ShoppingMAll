package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;

public interface OrderMapper {

	//주문 페이지 주문 상품 목록
	List<OrderCartListVO> orderCartList(String m_id);
	
	//최근 배송지 불러오기
	OrderVO getRecentAddr(String m_id);
	
	//주문 저장
	//1)주문테이블
	void insertOrder(OrderVO vo);
	//2)주문 상세 테이블
	void insertOrderDetail(@Param("ord_code") Long ord_code, @Param("m_id") String m_id);
}
