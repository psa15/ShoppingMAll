package com.psamall.service;

import java.util.List;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;
import com.psamall.dto.Criteria;

public interface UserProductService {

	//1차 카테고리
	List<CatetgoryVO> firstCateList();
	
	//2차 카테고리
	List<CatetgoryVO> secondCateList(Integer firstCateCode);
	
	//상품목록(전체 상품)
	List<ProductVO> getAllProduct();
	
	//상품목록
	List<ProductVO> productListBySecondCateCode(Integer s_ct_code, Criteria cri);
	
	//상품 목록 개수 : 페이징 구현 사용
	int productTotalCountBySecondCateCode(Integer s_ct_code, Criteria cri);
	
	//상품 코드에 맞는 상품 정보
	ProductVO getProductDetail(Integer p_num);
}
