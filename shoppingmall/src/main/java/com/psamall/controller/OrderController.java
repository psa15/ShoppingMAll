package com.psamall.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;
import com.psamall.domain.MemberVO;
import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.kakaopay.ApproveResponse;
import com.psamall.kakaopay.ReadyResponse;
import com.psamall.service.OrderService;
import com.psamall.service.UserCartService;
import com.psamall.service.UserProductService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

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
	
	@Setter(onMethod_ = {@Autowired})
	private com.psamall.service.KakaoPayServiceImpl kakaopayService;

	/*
	//주문하기 폼
	@GetMapping("/orderList")
	public void orderList(HttpSession session, Model model, RedirectAttributes rttr, @ModelAttribute("orderCartList")List<OrderCartListVO> orderCartList,
							@RequestParam("type") String type, @RequestParam(value="p_num", required = false) Integer p_num, @RequestParam(value="cart_amount", required = false) Integer ord_amount ) {
		
	
		log.info("cart_amount: " + ord_amount);
		log.info("상품 번호: " + p_num);
		log.info("상품 타입: " + type);
		
		
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		List<OrderCartListVO> vo = null;
		
		if(type.equals("cartOrder")) {
			//장바구니에서 주문하기
			//vo = orderService.orderCartList(m_id);
			
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
	
	
	}
*/	
	@GetMapping("/test")
	public void test() {
		
	}
	
	@GetMapping("/orderList")
	public void orderList(@RequestParam(value="checkProduct", required = false)List<Integer> checkProduct, HttpSession session, Model model, 
							@RequestParam(value="type", required = false) String type,
							@RequestParam(value="p_num", required = false) Integer p_num, 
							@RequestParam(value="cart_amount", required = false) Integer ord_amount) {
		
//		Integer[] checkArr = new Integer[checkProduct.size()];
//		for(int i=0; i<checkProduct.size(); i++) {
//			checkArr[i] = checkProduct.get(i);
//		}
		//System.out.println(Arrays.toString(checkArr));
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		List<OrderCartListVO> vo = new ArrayList<OrderCartListVO>();
		
		
		if(type == null) {
			//장바구니에서 주문하기
			//선택한 상품
			for(int i=0; i<checkProduct.size(); i++) {
				vo.add(i, orderService.orderCartList(checkProduct.get(i), m_id));
			}
			
		} else if(type.equals("directOrder")) {			
			//장바구니 외에서 주문하기
			vo = orderService.orderDirectList(p_num, ord_amount);
			
//		CartVO cartVO = new CartVO();
//			cartVO.setM_id(m_id);
//			cartVO.setCart_amount(ord_amount);
//			cartVO.setP_num(p_num);
//			userCartService.addCart(cartVO);
			
		}
		//

			
//			Integer[] amountArr = new Integer[ordAmountArr.size()];
//			
//			
//			for(int i=0; i<ordAmountArr.size(); i++) {
//				amountArr[i] = ordAmountArr.get(i);
//			}
			
			
			
		
		
		for(int i=0; i<vo.size(); i++) {
			String p_image_folder = vo.get(i).getP_image_folder().replace("\\", "/");
			vo.get(i).setP_image_folder(p_image_folder);
			vo.get(i).setM_id(m_id);
			//vo.get(i).setCart_amount(amountArr[i]);
		}
		
		//System.out.println("선택한 상품 정보: " + vo);
		
		model.addAttribute("orderCartList", vo);
		
		
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
		
		return "redirect:/user/order/orderComplete";
	}
	
	//카카오페이 결제요청. 바로구매는 에러발생된다.
	@GetMapping("/orderPay")
	public @ResponseBody ReadyResponse payReady(OrderVO orderVO, PaymentVO payVO, int totalAmount, HttpSession session, Model model) {
		
		//장바구니테이블에서 상품정보(상품명, 상품코드, 수량, 상품가격*수량=단위별 금액)
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		//장바구니에서 주문이 진행될 때
		List<CartListVO> cartList = userCartService.getCartList(m_id);
		String itemName = cartList.get(0).getP_name() + "외 " + String.valueOf(cartList.size() - 1) + " 개";
		int quantity = cartList.size() - 1;
		
		
		// 카카오페이서버에서 보낸온 정보.
		ReadyResponse readyResponse = kakaopayService.payReady(itemName, quantity, m_id, totalAmount);
		
		//model.addAttribute("tid", readyResponse.getTid());
		
		session.setAttribute("tid", readyResponse.getTid());
		log.info("결제고유번호1: " + readyResponse.getTid());
		
		orderVO.setM_id(m_id);
		session.setAttribute("order", orderVO);
		session.setAttribute("payment", payVO);
		
		return readyResponse;
	}
	
	
	//결제승인요청 : 큐알코드를 찍고(결제요청) 카카오페이 서버에서 결제가 성공적으로 끝나면, 카카오페이 서버에서 호출하는 주소
	@GetMapping("/orderApproval")
	public String orderApproval(@RequestParam("pg_token") String pgToken, HttpSession session ) {
		
		log.info("결제 승인요청 인증토큰: " + pgToken);
		//log.info("주문정보: " + o_vo);
		
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		String tid = (String) session.getAttribute("tid");
		OrderVO orderVO = (OrderVO) session.getAttribute("order");
		PaymentVO payVO = (PaymentVO) session.getAttribute("payment");
		
		session.removeAttribute("tid"); //세션 제거 - 반드시 처리! 로그인 상태에서 세션정보가 필요하지 않게되면 불필요하게 서버측의 메모리를 사용하게 됨
		session.removeAttribute("order");
		session.removeAttribute("payment");
		
		log.info("결제 고유번호2: " + tid);
		
		//카카오페이 결제하기
		ApproveResponse approveResponse =kakaopayService.payApprove(tid, pgToken, m_id);
		log.info("appreveResponse: " + approveResponse);
		
		orderService.orderSave(orderVO, payVO);
		
		return "redirect:/user/order/orderComplete";
	}
	
	//주문 완료 폼
	@GetMapping("/orderComplete")
	public void orderComplete(HttpSession session, Model model) {
		
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		
		model.addAttribute("orderInfo", orderService.getOrderInfo(m_id));
	}
}
