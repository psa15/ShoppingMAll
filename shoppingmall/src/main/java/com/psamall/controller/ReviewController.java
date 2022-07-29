package com.psamall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.psamall.domain.MemberVO;
import com.psamall.domain.ReviewVO;
import com.psamall.dto.Criteria;
import com.psamall.dto.PageDTO;
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
	public ResponseEntity<String> addReview(@RequestBody ReviewVO vo, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		reviewSerice.insertReview(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//리뷰 목록 불러오기
	@GetMapping("/reviewList/{p_num}/{page}")
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("p_num") Integer p_num, @PathVariable("page") Integer page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//목록 불러오기
		Criteria cri = new Criteria();
		List<ReviewVO> list = reviewSerice.getReviewList(p_num, cri);
		map.put("list", list);
		
		//페이징
		PageDTO pageMaker = new PageDTO(cri, reviewSerice.totalReviewCount(p_num));
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
}
