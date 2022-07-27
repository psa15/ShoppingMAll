package com.psamall.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.CartListVO;
import com.psamall.domain.CartVO;
import com.psamall.domain.MemberVO;
import com.psamall.service.UserCartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/cart/*")
public class CartController {

	@Setter(onMethod_ = {@Autowired})
	private UserCartService cartService;
	
	//장바구니 담기 - ajax
	@ResponseBody
	@GetMapping("/addCart")
	public ResponseEntity<String> addCart(CartVO vo, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		//로그인 시 사용한 세션 정보
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		cartService.addCart(vo);
		log.info("장바구니 정보: " + vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//장바구니 폼
	@GetMapping("/cartList")
	public void cartList(HttpSession session, Model model) {
		
		//로그인 정보
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		
		List<CartListVO> vo = cartService.getCartList(m_id);
		//날짜폴더 \ 변환 작업
		for(int i=0; i<vo.size(); i++) {
			String p_image_folder = vo.get(i).getP_image_folder().replace("\\", "/");
			vo.get(i).setP_image_folder(p_image_folder);
		}
		
		model.addAttribute("cartList", vo);
	}
	
	//장바구니 상품수량 변경
	@GetMapping("/changeCartAmount")
	public ResponseEntity<String> changeCartAmount(@RequestParam("cart_code") Long cart_code, @RequestParam("cart_amount") int cart_amount){
		
		ResponseEntity<String> entity = null;
		
		cartService.updateCartAmount(cart_code, cart_amount);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
}
