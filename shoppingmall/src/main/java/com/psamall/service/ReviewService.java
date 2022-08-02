package com.psamall.service;

import java.util.List;

import com.psamall.domain.ReviewVO;
import com.psamall.dto.Criteria;

public interface ReviewService {

	//리뷰 등록
	void insertReview(ReviewVO vo);
	
	//리뷰 목록 불러오기 + 페이징(검색은 X)
	List<ReviewVO> getReviewList(Integer p_num, Criteria cri);
	
	//총 리뷰 개수
	int totalReviewCount(Integer p_num);
	
	//리뷰 수정
	void updateReview(ReviewVO vo);
	
	//리뷰 삭제
	void deleteReview(Integer r_num);
}
