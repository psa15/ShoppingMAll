package com.psamall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.ReviewVO;
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
	
	
}
