package com.psamall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;

public interface OrderMapper {

	//주문 페이지 주문 상품 목록 - 장바구니에서 주문
	OrderCartListVO orderCartList(@Param("cart_code") Integer cart_code,@Param("m_id")  String m_id);
	//장바구니 외 주문
	List<OrderCartListVO> orderDirectList(@Param("p_num") Integer p_num, @Param("ord_amount") int ord_amount);
	
	//최근 배송지 불러오기
	OrderVO getRecentAddr(String m_id);
	
	//주문 저장
	//1)주문테이블
	void insertOrder(OrderVO vo);
	//2-1)주문 상세 테이블 - 장바구니 테이블 사용
	void insertOrderDetail(@Param("ord_code") Long ord_code, @Param("m_id") String m_id, @Param("pNumArr") Integer p_num);
	//2-2)상품번호 사용
	void insertOrderDetailByPNum(@Param("ord_code") Long ord_code, @Param("pNumArr") Integer p_num, @Param("cartAmountArr") Integer cart_amount);
	//3) 결제 테이블
	void insertPayment(PaymentVO vo);
	
	//주문완료 후 주문 정보 불러오기
	OrderVO getOrderInfo(String m_id);
	
	//주문내역
	List<Map<String, Object>> getOrderHistory(String m_id);
}
