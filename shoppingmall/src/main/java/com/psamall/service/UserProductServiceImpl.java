package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class UserProductServiceImpl implements UserProductService {

	@Setter(onMethod_ = {@Autowired})
	private UserProductMapper userPMapper;
	
	//1차 카테고리
	@Override
	public List<CatetgoryVO> firstCateList() {
		return userPMapper.firstCateList();
	}

	//2차 카테고리
	@Override
	public List<CatetgoryVO> secondCateList(Integer firstCateCode) {
		return userPMapper.secondCateList(firstCateCode);
	}

	//상품목록
	@Override
	public List<ProductVO> productListBySecondCateCode(Integer s_ct_code, Criteria cri) {
		return userPMapper.productListBySecondCateCode(s_ct_code, cri);
	}

	//상품 목록 개수 : 페이징 구현 사용
	@Override
	public int productTotalCountBySecondCateCode(Integer s_ct_code, Criteria cri) {
		return userPMapper.productTotalCountBySecondCateCode(s_ct_code, cri);
	}

	//상품 코드에 맞는 상품 정보
	@Override
	public ProductVO getProductDetail(Integer p_num) {
		return userPMapper.getProductDetail(p_num);
	}

	
	//상품목록(전체 상품)
	@Override
	public List<ProductVO> getAllProduct() {
		return userPMapper.getAllProduct();
	}

}
