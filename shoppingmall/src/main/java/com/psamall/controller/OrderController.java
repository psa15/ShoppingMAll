package com.psamall.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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
import com.psamall.domain.ProductVO;
import com.psamall.dto.OrderProductDTO;
import com.psamall.dto.OrderProductListDTO;
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

	//주문하기 폼
	@GetMapping("/orderList")
	public void orderList(HttpSession session, Model model,
							@RequestParam("type") String type, @RequestParam(value="p_num", required = false) Integer p_num, @RequestParam(value="cart_amount", required = false) Integer ord_amount ) {
		
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
		
	}
	
	@GetMapping("/test")
	public void test() {
		
	}
	
	//장바구니 선택한 상품만 주문하기
	@GetMapping("/orderSelected")
	@ResponseBody
	public String orderSelected(HttpServletRequest request, HttpServletResponse response) {
		//List<OrderProductListDTO> orderdto = new ArrayList<OrderProductListDTO>();
		
		String[] list = request.getParameterValues("checkProduct");
		for(String str : list) {
			log.info(str);
		}
		
//		String code = checkList.get("checkedValue").toString();
//		log.info(code);
//		array = code.split(",");
		
//		int[] results = new int[array.length];
//		int result = 1;
//		log.info(array);
//		for(int i=0; i<array.length; i++) {
//			HashMap<String, Object> resendMap = new HashMap<String, Object>();
//			
//			resendMap.put
//		}
		
//		model.addAttribute("testList", testList);
		return "";
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
	public String addOrder(HttpSession session, OrderVO vo) {
		
		log.info("주문 정보: " + vo);
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		
		orderService.orderSave(vo);
		
		return "redirect:/";
	}
}
