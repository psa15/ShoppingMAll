package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.CatetgoryVO;

public interface UserProductMapper {

	//1차 카테고리
	List<CatetgoryVO> firstCateList();
	
	//2차 카테고리 - 1차 카테고리별 2차 카테고리 불러오기
	List<CatetgoryVO> secondCateList(Integer firstCateCode);
}
