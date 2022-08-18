package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;

public interface OrderMapper {

	//주문 페이지 주문 상품 목록 - 장바구니에서 주문
	OrderCartListVO orderCartList(@Param("cart_code") Integer cart_code,@Param("m_id")  String m_id);
	//장바구니 외 주문
	List<OrderCartListVO> orderDirectList(@Param("p_num") Integer p_num, @Param("ord_amount") int ord_amount);
	
	//선택한 상품 주문
	OrderCartListVO getSelected( String m_id);
	
	//최근 배송지 불러오기
	OrderVO getRecentAddr(String m_id);
	
	//주문 저장
	//1)주문테이블
	void insertOrder(OrderVO vo);
	//2)주문 상세 테이블
	void insertOrderDetail(@Param("ord_code") Long ord_code, @Param("m_id") String m_id);
	//3) 결제 테이블
	void insertPayment(PaymentVO vo);
	
	//주문완료 후 주문 정보 불러오기
	OrderVO getOrderInfo(String m_id);
}
