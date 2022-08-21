package com.psamall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderMapper adOrderMapper;
	
	//주문 목록
	@Override
	public List<OrderVO> getOrderList(Criteria cri, String startDate, String endDate) {
		return adOrderMapper.getOrderList(cri, startDate, endDate);
	}

	//총 주문 개수
	@Override
	public int getTotalOrder(Criteria cri, String startDate, String endDate) {
		return adOrderMapper.getTotalOrder(cri, startDate, endDate);
	}

	//주문정보 변경
	@Override
	public void updateOrderStatus(Long ord_code, String ord_status) {
		adOrderMapper.updateOrderStatus(ord_code, ord_status);
	}
	//결제 상태 변경
	@Override
	public void updatePayStatus(Long ord_code, String pay_status) {
		adOrderMapper.updatePayStatus(ord_code, pay_status);
	}
	//총 가격 수정
	@Override
	public void updatePrice(Long ord_code, int totalPrice) {
		adOrderMapper.updatePrice(ord_code, totalPrice);
	}
	//CS 상태 변경
	@Override
	public void updateCsStatus(Long ord_code, String cs_status) {
		adOrderMapper.updateCsStatus(ord_code, cs_status);
	}

	//회원이 주문취소할 경우 주문 삭제
	@Override
	public void deleteOrder(Long ordCodeArr) {
		adOrderMapper.deleteOrder(ordCodeArr);
	}

	//주문 상세 페이지
	//주문 정보
	@Override
	public OrderVO getOrderInfo(Long ord_code) {
		return adOrderMapper.getOrderInfo(ord_code);
	}
	//결제 정보
	@Override
	public PaymentVO getPaymentInfo(Long ord_code) {
		return adOrderMapper.getPaymentInfo(ord_code);
	}
	//주문 상품 정보
	@Override
	public List<Map<String, Object>> getOrderProductInfo(Long ord_code) {
		return adOrderMapper.getOrderProductInfo(ord_code);
	}

	//개별 상품 삭제
	@Transactional
	@Override
	public void deleteProduct(Long ord_code, Integer p_num, int ord_unitprice) {
		
		//주문 상세 테이블 삭제
		adOrderMapper.deleteTblOrderDetail(p_num, ord_code);
		
		//주문 테이블 총 가격 수정
		adOrderMapper.updateTotalCost(ord_code, ord_unitprice);
		
		//결제 테이블 총 가격 수정
		adOrderMapper.updatePayTotalCost(ord_code, ord_unitprice);
		
	}

	

}
