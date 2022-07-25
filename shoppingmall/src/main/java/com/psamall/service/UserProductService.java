package com.psamall.service;

import java.util.List;

import com.psamall.domain.CatetgoryVO;

public interface UserProductService {

	//1차 카테고리
	List<CatetgoryVO> firstCateList();
	
	//2차 카테고리
	List<CatetgoryVO> secondCateList(Integer firstCateCode);
}
