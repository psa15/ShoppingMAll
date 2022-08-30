package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.psamall.domain.ReviewVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.ReviewMapper;
import com.psamall.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper reviewMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductMapper userProductMapper;

	//리뷰 등록
	@Transactional
	@Override
	public void insertReview(ReviewVO vo) {
		
		//리뷰 등록
		reviewMapper.insertReview(vo);
		
		//리뷰 개수 카운트
		Integer p_num = vo.getP_num();
		userProductMapper.plusReviewCount(p_num);
	}
	//리뷰 등록 시 주문상세 테이블의 상품 리뷰 컬럼 'Y'로 변경 
	@Override
	public void updatePReview(Integer p_num, Long ord_code) {
		reviewMapper.updatePReview(p_num, ord_code);
		
	}

	//리뷰 목록 불러오기 + 페이징(검색은 X)
	@Override
	public List<ReviewVO> getReviewList(Integer p_num, Criteria cri) {
		return reviewMapper.getReviewList(p_num, cri);
	}

	//총 리뷰 개수
	@Override
	public int totalReviewCount(Integer p_num) {
		return reviewMapper.totalReviewCount(p_num);
	}

	//리뷰 수정
	@Override
	public void updateReview(ReviewVO vo) {
		reviewMapper.updateReview(vo);
	}

	//리뷰 삭제
	@Transactional
	@Override
	public void deleteReview(Integer r_num, Integer p_num) {
		
		//리뷰 삭제
		reviewMapper.deleteReview(r_num);
		
		//리뷰 개수 -1
		userProductMapper.minusReviewCount(p_num);
	}
	
	
}
