package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.CartVO;
import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.MemberVO;
import com.psamall.mapper.UserCartMapper;
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
}
