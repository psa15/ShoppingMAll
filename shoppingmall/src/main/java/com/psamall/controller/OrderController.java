package com.psamall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.CartVO;
import com.psamall.domain.MemberVO;
import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.OrderProductListDTO;
import com.psamall.service.OrderService;
import com.psamall.service.UserCartService;
import com.psamall.service.UserProductService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.GetProxy;

@Controller
@Log4j
@RequestMapping("/user/order/*")
public class OrderController {
	
	//상품 이미지를 불러오기 위한 bean
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;
	
	@Setter(onMethod_ = {@Autowired})
	private UserCartService userCartService;
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductService userProductService;

	//주문하기 폼
	@GetMapping("/orderList")
	public String orderList(HttpSession session, Model model,
							@RequestParam("type") String type, @RequestParam(value="p_num", required = false) Integer p_num, @RequestParam(value="cart_amount", required = false) Integer ord_amount ) {
		
		String url = "";
		
		//String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		
//		 if((MemberVO)session.getAttribute("loginStatus") == null) {
//			url = "redirect:/user";
//		}
//		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		List<OrderCartListVO> vo = null;
		
		if(type.equals("cartOrder")) {
			//장바구니에서 주문하기
			vo = orderService.orderCartList(m_id);
		} else if(type.equals("directOrder")) {			
			//장바구니 외에서 주문하기
			vo = orderService.orderDirectList(p_num, ord_amount);
			
			CartVO cartVO = new CartVO();
			cartVO.setM_id(m_id);
			cartVO.setCart_amount(ord_amount);
			cartVO.setP_num(p_num);
			userCartService.addCart(cartVO);
		}
		
		for(int i=0; i<vo.size(); i++) {
			String p_image_folder = vo.get(i).getP_image_folder().replace("\\", "/");
			vo.get(i).setP_image_folder(p_image_folder);
		}
		
		model.addAttribute("orderCartList", vo);
		
		return url;
		
	}
	
	@GetMapping("/test")
	public void test() {
		
	}
	
	//장바구니 선택한 상품만 주문하기
	@GetMapping("/orderSelected")
	@ResponseBody
	public String orderSelected(@RequestParam("checkArray") List<Integer> arrayParams){
		
		log.info(arrayParams);
		
		
		/*
		 * String[] arrayParam = request.getParameterValues("checkedValue"); for(int
		 * i=0; i<arrayParam.length; i++) { System.out.println(arrayParam[i]); }
		 */
		
		return "redirect:/user/order/orderList";
	}
	
	//주문 상품 이미지 불러오기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {
		
		log.info("파일 이름: " + fileName);
		
		//저장된 썸네일 이미지를 byte[]로 읽어오는 작업
		return UploadFileUtils.getImageFile(uploadPath, folderName + "\\" + fileName);
	}
	
	//최근 배송지 불러오기
	@GetMapping("/getRecentAddr")
	public void getRecentAddr (HttpSession session, Model model) {
		
	}
	
	//주문 저장
	@PostMapping("/addOrder")
	public String addOrder(HttpSession session, OrderVO orderVO, PaymentVO payVO) {
		
		log.info("주문 정보: " + orderVO);
		log.info("결제 정보: " + payVO);
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		orderVO.setM_id(m_id);
		
		if(payVO.getPay_noAccount_bank() != null) {
			orderVO.setPay_status("입금전");
			payVO.setPay_tot_price(orderVO.getOrd_totalcost()); //실제 총 결제금액
			payVO.setPay_rest_price(0);	//추가 입금 금액
		}
		
		orderService.orderSave(orderVO, payVO);
		
		return "redirect:/";
	}
}
