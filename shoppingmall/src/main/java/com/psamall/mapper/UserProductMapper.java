package com.psamall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;
import com.psamall.dto.Criteria;

public interface UserProductMapper {

	//1차 카테고리
	List<CatetgoryVO> firstCateList();
	
	//2차 카테고리 - 1차 카테고리별 2차 카테고리 불러오기
	List<CatetgoryVO> secondCateList(Integer firstCateCode);
	
	//상품목록
	List<ProductVO> productListBySecondCateCode(@Param("s_ct_code") Integer s_ct_code, @Param("cri") Criteria cri);
	
	//상품 목록 개수 : 페이징 구현 사용
	int productTotalCountBySecondCateCode(@Param("s_ct_code") Integer s_ct_code, @Param("cri") Criteria cri);
}
