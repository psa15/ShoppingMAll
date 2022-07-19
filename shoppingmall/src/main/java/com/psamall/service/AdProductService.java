package com.psamall.service;

import java.util.List;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;

public interface AdProductService {
	//1차 카테고리 불러오기
	List<CatetgoryVO> firstCateList();	
	
	//2차 카테고리 불러오기
	List<CatetgoryVO> secondCateList(Integer firstCategoryCode);
	
	//상품등록 폼의 정보 저장
	void insertProduct(ProductVO vo);
}
