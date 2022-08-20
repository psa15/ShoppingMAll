package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.Criteria;

public interface AdOrderMapper {

	//주문 목록
	List<OrderVO> getOrderList(@Param("cri")Criteria cri, @Param("startDate")String startDate, @Param("endDate")String endDate);
	//총 주문 개수
	int getTotalOrder(@Param("cri")Criteria cri, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//주문 상태 변경
	void updateOrderStatus(@Param("ord_code")Long ord_code, @Param("ord_status")String ord_status);
	//결제 상태 변경
	void updatePayStatus(@Param("ord_code")Long ord_code, @RequestParam("pay_status")String pay_status);
	//CS 상태 변경
	void updateCsStatus(@Param("ord_code")Long ord_code, @RequestParam("cs_status")String cs_status);
	
	//회원이 주문취소할 경우 주문 삭제
	void deleteOrder(Long ordCodeArr);
	
	//주문 상세 페이지
	//주문 정보
	OrderVO getOrderInfo(Long ord_code);
	//결제 정보
	PaymentVO getPaymentInfo(Long ord_code);
}
