package com.psamall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ResponseEntity<String> addReview(@RequestBody ReviewVO vo, HttpSession session, @RequestParam(value="ord_code", required = false) Long ord_code){
		
		ResponseEntity<String> entity = null;
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		reviewSerice.insertReview(vo);
		
		log.info(ord_code);
		System.out.println(ord_code);
		
		if(ord_code != null ) {
			reviewSerice.updatePReview(vo.getP_num(), ord_code);
		}
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//리뷰 목록 불러오기
	@GetMapping("/reviewList/{p_num}/{page}")
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("p_num") Integer p_num, @PathVariable("page") Integer page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
				
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		
		//목록 불러오기
		List<ReviewVO> list = reviewSerice.getReviewList(p_num, cri);
		map.put("list", list);
		
		//페이징
		PageDTO pageMaker = new PageDTO(cri, reviewSerice.totalReviewCount(p_num));
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	//리뷰 수정하기
	@PatchMapping("/updateReview")
	public ResponseEntity<String> updateReview(@RequestBody ReviewVO vo, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);
		
		reviewSerice.updateReview(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//리뷰 삭제하기
	@DeleteMapping("/deleteReview/{r_num}/{p_num}")
	public ResponseEntity<String> deleteReview(@PathVariable("r_num") Integer r_num, @PathVariable("p_num") Integer p_num){
		
		ResponseEntity<String> entity = null;
				
		reviewSerice.deleteReview(r_num, p_num);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
}
