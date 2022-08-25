package com.psamall.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import com.psamall.service.AdOrderService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
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
	public ResponseEntity<String> orderPayChange(@RequestParam("ord_code")Long ord_code, @RequestParam("pay_status")String pay_status, @RequestParam("ord_totalcost") int totalPrice) {
		
		ResponseEntity<String> entity = null;
		
		log.info("결제 상태 : " + pay_status);
		if(pay_status.equals("결제완료")) {
			//무통장입금이었다가 입금 확인 후에 결제 완료로 상태 변경 시, 총 결제 금액을 무통장 입금금액과 같게 수정
			adOrderService.updatePrice(ord_code, totalPrice);
			
		}
		
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
		List<Map<String, Object>> orderProductList = adOrderService.getOrderProductInfo(ord_code);
		
		log.info(ord_code);
		log.info(orderProductList);
		
		for(int i=0; i<orderProductList.size(); i++) {
			Map<String, Object> orderProductInfo = orderProductList.get(i);
			String img_forlder = String.valueOf(orderProductInfo.get("P_IMAGE_FOLDER")).replace("\\", "/");
			
			orderProductInfo.put("P_IMAGE_FOLDER", img_forlder);
		} 
		
		model.addAttribute("orderProductList", orderProductList);
		
	}
	
	//상품목록 이미지 불러오기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {
		
		log.info("파일 이름: " + fileName);
		
		//저장된 썸네일 이미지를 byte[]로 읽어오는 작업
		return UploadFileUtils.getImageFile(uploadPath, folderName + "\\" + fileName);
	}
	
	//개별 상품 삭제
	@PostMapping("/deleteProduct")
	@ResponseBody
	public ResponseEntity<String> deleteProduct(@RequestParam("ord_code") Long ord_code, @RequestParam("p_num") Integer p_num, @RequestParam("ord_unitprice") int ord_unitprice){
		
		ResponseEntity<String> entity = null;
		
		//상품 삭제
		adOrderService.deleteProduct(ord_code, p_num, ord_unitprice);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
}
