package com.psamall.mapper;

import java.util.List;
import java.util.Map;

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
	void updatePayStatus(@Param("ord_code")Long ord_code, @Param("pay_status")String pay_status);
	//CS 상태 변경
	void updateCsStatus(@Param("ord_code")Long ord_code, @Param("cs_status")String cs_status);
	
	//회원이 주문취소할 경우 주문 삭제
	void deleteTblOrder(Long ordCodeArr);
	
	/*주문 상세 페이지*/
	//주문 정보
	OrderVO getOrderInfo(Long ord_code);
	//결제 정보
	PaymentVO getPaymentInfo(Long ord_code);
	//총 가격 수정
	void updatePrice(@Param("ord_code") Long ord_code, @Param("totalPrice") int totalPrice);
	//주문 상품 정보
	List<Map<String, Object>> getOrderProductInfo(Long ord_code);
	
	/*개별 상품 삭제*/
	//주문 상세 테이블 삭제
	void deleteTblOrderDetail(@Param("p_num") Integer p_num, @Param("ord_code") Long ord_code);
	//주문 테이블 총 가격 수정
	void updateTotalCost(@Param("ord_code") Long ord_code, @Param("ord_unitprice") int ord_unitprice);
	//결제 테이블 총 가격 수정
	void updatePayTotalCost(@Param("ord_code") Long ord_code, @Param("ord_unitprice") int ord_unitprice, @Param("pay_tot_price") int pay_tot_price);
	
	/* 개별 상품 삭제 시 주문 상세 테이블의 데이터가 1개이면 주문 테이블과 결제 테이블 데이터 삭제 진행 */
	//데이터 확인
	int getOrderDProductCount(Long ord_code);
	//결제 테이블 삭제
	void deleteTblPayment(Long ord_code);
	
}
