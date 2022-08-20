package com.psamall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.OrderVO;
import com.psamall.dto.Criteria;
import com.psamall.dto.PageDTO;
import com.psamall.mapper.AdOrderMapper;
import com.psamall.service.AdOrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdOrderService adOrderService;

	//주문 목록
	@GetMapping("/adOrderList")
	public void orderList(Model model, Criteria cri,
							@RequestParam(value="startDate", required = false) String startDate,
							@RequestParam(value="endDate", required = false) String endDate) {
		
//		log.info(startDate);
//		log.info(endDate);
		
		List<OrderVO> orderList = adOrderService.getOrderList(cri, startDate, endDate);
		model.addAttribute("orderList", orderList);
		
		int totalOrderList = adOrderService.getTotalOrder(cri, startDate, endDate);
		model.addAttribute("pageMaker", new PageDTO(cri, totalOrderList));
		
		//검색한 값이 남게
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
	}
	
	//결제 상태 변경
	@GetMapping("/orderPayChange")
	@ResponseBody
	public ResponseEntity<String> orderPayChange(@RequestParam("ord_code")Long ord_code, @RequestParam("pay_status")String pay_status) {
		
		ResponseEntity<String> entity = null;
		
		adOrderService.updatePayStatus(ord_code, pay_status);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//주문 상태 변경
	@GetMapping("/orderStatusChange")
	@ResponseBody
	public ResponseEntity<String> orderStatusChange(@RequestParam("ord_code")Long ord_code, @RequestParam("ord_status")String ord_status) {
		
		ResponseEntity<String> entity = null;
		
		adOrderService.updateOrderStatus(ord_code, ord_status);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//CS 상태 변경
	@GetMapping("/orderCsChange")
	@ResponseBody
	public ResponseEntity<String> orderCsChange(@RequestParam("ord_code")Long ord_code, @RequestParam("cs_status")String cs_status) {
		
		ResponseEntity<String> entity = null;
		
		adOrderService.updateCsStatus(ord_code, cs_status);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//회원이 주문을 취소한 경우
	@ResponseBody
	@PostMapping("/deleteCheckOrder")
	public ResponseEntity<String> deleteCheckOrder(@RequestParam("ordCodeArr[]") List<Long> ordCodeArr){
				
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<ordCodeArr.size(); i++) {
			
			//주문번호를 이용하여 삭제구문 진행
			adOrderService.deleteOrder(ordCodeArr.get(i));
			
		}
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//주문 상세 페이지
	@GetMapping("/adOrderDetail")
	public void adOrderDetail(Model model, Long ord_code) {
		
		//주문 정보
		model.addAttribute("orderInfo", adOrderService.getOrderInfo(ord_code));
		
		//결제 정보
		model.addAttribute("paymentInfo", adOrderService.getPaymentInfo(ord_code));
		
		//주문 상품 정보
		
	}
}
