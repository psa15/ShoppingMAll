package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.ReviewVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper reviewMapper;

	//리뷰 등록
	@Override
	public void insertReview(ReviewVO vo) {
		reviewMapper.insertReview(vo);
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
	
	
}
