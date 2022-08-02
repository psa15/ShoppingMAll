package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.ReviewVO;
import com.psamall.dto.Criteria;

public interface ReviewMapper {

	//리뷰 등록
	void insertReview(ReviewVO vo);
	
	//리뷰 목록 불러오기 + 페이징(검색은 X)
	List<ReviewVO> getReviewList(@Param("p_num") Integer p_num, @Param("cri") Criteria cri);
	
	//총 리뷰 개수
	int totalReviewCount(Integer p_num);
	
	//리뷰 수정
	void updateReview(ReviewVO vo);
	
	//리뷰 삭제
	void deleteReview(Integer r_num);
}
