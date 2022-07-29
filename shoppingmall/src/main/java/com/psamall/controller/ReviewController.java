package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.psamall.domain.MemberVO;
import com.psamall.domain.ReviewVO;
import com.psamall.mapper.ReviewMapper;
import com.psamall.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/user/review/*")
public class ReviewController {

	@Setter(onMethod_ = {@Autowired})
	private ReviewService reviewSerice;
	
	//리뷰 작성하기
	@PostMapping("/addReview")
	public ResponseEntity<String> addReview(ReviewVO vo, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		reviewSerice.insertReview(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
}
