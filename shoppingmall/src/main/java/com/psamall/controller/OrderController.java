package com.psamall.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;
import com.psamall.domain.MemberVO;
import com.psamall.domain.OrderCartListVO;
import com.psamall.domain.OrderVO;
import com.psamall.domain.PaymentVO;
import com.psamall.dto.Criteria;
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

	//주문하기 폼 - 장바구니
	@GetMapping("/userOrderList")
	public void orderList(@RequestParam(value="checkProduct", required = false)List<Integer> checkProduct, HttpSession session, Model model, 
							@RequestParam(value="type", required = false) String type,
							@RequestParam(value="p_num", required = false) Integer p_num, 
							@RequestParam(value="cart_amount", required = false) Integer ord_amount) {
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		List<OrderCartListVO> vo = new ArrayList<OrderCartListVO>();

		for(int i=0; i<checkProduct.size(); i++) {
			vo.add(i, orderService.orderCartList(checkProduct.get(i), m_id));
		}
						
		
		for(int i=0; i<vo.size(); i++) {
			String p_image_folder = vo.get(i).getP_image_folder().replace("\\", "/");
			vo.get(i).setP_image_folder(p_image_folder);
			vo.get(i).setM_id(m_id);
		}
		
		//System.out.println("선택한 상품 정보: " + vo);
		
		model.addAttribute("orderCartList", vo);
		
		
	}
	
	//주문하기 폼 - 바로구매
	@GetMapping("/userDirectOrderList")
	public void orderList(HttpSession session, Model model, 
							@RequestParam(value="p_num", required = false) Integer p_num, 
							@RequestParam(value="p_amount", required = false) Integer ord_amount) {
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		OrderCartListVO vo = new OrderCartListVO();
		vo = orderService.orderDirectList(p_num, ord_amount);
		
		//이미지 폴더 변경
		String p_image_folder = vo.getP_image_folder().replace("\\", "/");
		vo.setP_image_folder(p_image_folder);
		vo.setM_id(m_id);
		
		//System.out.println("선택한 상품 정보: " + vo);
		
		model.addAttribute("order", vo);
		
		
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
	
	//주문 저장 - 장바구니
	@PostMapping("/addOrder")
	public String addOrder(HttpSession session, OrderVO orderVO, PaymentVO payVO, 
							@RequestParam(value="cartCodeArr", required = false) List<Long> cartCodeArr,
							@RequestParam("pNumArr") List<Integer> pNumArr) {
		
		System.out.println("주문 정보: " + orderVO);
		System.out.println("결제 정보: " + payVO);
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		orderVO.setM_id(m_id);
		
		if(payVO.getPay_method().equals("무통장 입금")) {
			orderVO.setPay_status("입금전");
			payVO.setPay_noAccount_price(payVO.getPay_tot_price());
			payVO.setPay_tot_price(0); //실제 총 결제금액
		} else {
			orderVO.setPay_status("결제완료");
			payVO.setPay_noAccount_username("");
		}
		System.out.println("주문 정보: " + orderVO);
		System.out.println("결제 정보: " + payVO);
		
		System.out.println(pNumArr.get(0));

		//주문 저장
		orderService.orderSave(orderVO, payVO);
		
		//주문한 상품 장바구니에서 삭제
		for (int i=0; i<pNumArr.size(); i++) {
			userCartService.deleteCartOrder(pNumArr.get(i));
		}
		
		
		return "redirect:/user/order/userOrderComplete";
	}
	
	//주문 저장 - 바로구매
	@PostMapping("/addDirectOrder")
	public String addOrder(HttpSession session, OrderVO orderVO, PaymentVO payVO,
							@RequestParam("p_num") Integer p_num, @RequestParam("ord_amount") Integer ord_amount) {
		
		System.out.println("주문 정보: " + orderVO);
		System.out.println("결제 정보: " + payVO);
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		orderVO.setM_id(m_id);
		
		if(payVO.getPay_method().equals("무통장 입금")) {
			orderVO.setPay_status("입금전");
			payVO.setPay_noAccount_price(payVO.getPay_tot_price());
			payVO.setPay_tot_price(0); //실제 총 결제금액
		} else {
			orderVO.setPay_status("결제완료");
			payVO.setPay_noAccount_username("");
		}
		System.out.println("주문 정보: " + orderVO);
		System.out.println("결제 정보: " + payVO);
		
		orderService.orderDirectSave(orderVO, payVO, p_num, ord_amount);
		
		return "redirect:/user/order/userOrderComplete";
	}
	
	//카카오페이 결제요청. 바로구매는 에러발생된다.
	@GetMapping("/orderPay")
	public @ResponseBody ReadyResponse payReady(OrderVO orderVO, PaymentVO payVO, int totalAmount, 
												@RequestParam(value="pNumArr", required = false) List<Integer> pNumArr, HttpSession session, Model model) {
		
		//장바구니테이블에서 상품정보(상품명, 상품코드, 수량, 상품가격*수량=단위별 금액)
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		//장바구니에서 주문이 진행될 때
		List<CartListVO> cartList = userCartService.getCartList(m_id);
		String itemName = cartList.get(0).getP_name() + "외 " + String.valueOf(cartList.size() - 1) + " 개";
		int quantity = cartList.size() - 1;
		
		ArrayList<Integer> list = new ArrayList<Integer>();
		session.setAttribute("pnum", list);
		
		
		for(int i=0; i<pNumArr.size(); i++) {
			list.add(pNumArr.get(i));
		}
		
		
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
		@SuppressWarnings("unchecked")
		ArrayList<Integer> pNumArr = (ArrayList<Integer>) session.getAttribute("pnum");
		
		session.removeAttribute("tid"); //세션 제거 - 반드시 처리! 로그인 상태에서 세션정보가 필요하지 않게되면 불필요하게 서버측의 메모리를 사용하게 됨
		session.removeAttribute("order");
		session.removeAttribute("payment");
		session.removeAttribute("pnum");
		
		log.info("결제 고유번호2: " + tid);
		
		//카카오페이 결제하기
		ApproveResponse approveResponse =kakaopayService.payApprove(tid, pgToken, m_id);
		log.info("appreveResponse: " + approveResponse);
		
		for (int i=0; i<pNumArr.size(); i++) {
			orderService.orderSave(orderVO, payVO);
		}
		
		return "redirect:/user/order/userOrderComplete";
	}
	
	//주문 완료 폼
	@GetMapping("/userOrderComplete")
	public void orderComplete(HttpSession session, Model model) {
		
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		
		model.addAttribute("orderInfo", orderService.getOrderInfo(m_id));
	}
	
	//주문 내역
	@GetMapping("/userOrderHistory")
	public void userOrderHistory(Model model, HttpSession session, Criteria cri,
									@RequestParam(value="startDate", required = false) String startDate,
									@RequestParam(value="endDate", required = false) String endDate) {
		
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		
		System.out.println(startDate);
		System.out.println(endDate);
		
		// 최근 일주일 주문 내역 불러오기 위한 작업
		if(startDate == null && endDate == null) {
			//Date today = new Date();
			//일주일 전
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calender = Calendar.getInstance();
			endDate = sdf.format(calender.getTime());
			calender.add(calender.DATE, -7);
			startDate = sdf.format(calender.getTime());
		}
		
		
		log.info(startDate);
		log.info(endDate);
		
		List<Map<String, Object>> orderHistory = orderService.getOrderHistory(m_id, startDate, endDate);
		
		for(int i=0; i<orderHistory.size(); i++) {
			Map<String, Object> orderProductInfo = orderHistory.get(i);
			String img_forlder = String.valueOf(orderProductInfo.get("P_IMAGE_FOLDER")).replace("\\", "/");
			
			orderProductInfo.put("P_IMAGE_FOLDER", img_forlder);
		}
		model.addAttribute("orderHistory", orderHistory);
		
		//검색한 값이 남게
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
	}
	
}
