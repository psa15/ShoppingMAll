package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.AdProductMapper;

import lombok.Setter;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Setter(onMethod_ = {@Autowired})
	private AdProductMapper adProductMapper;
	
	//1차 카테고리 불러오기
	@Override
	public List<CatetgoryVO> firstCateList() {
		return adProductMapper.firstCateList();
	}

	//2차 카테고리 불러오기
	@Override
	public List<CatetgoryVO> secondCateList(Integer firstCategoryCode) {
		return adProductMapper.secondCateList(firstCategoryCode);
	}

	//상품등록 폼의 정보 저장
	@Override
	public void insertProduct(ProductVO vo) {
		adProductMapper.insertProduct(vo);
	}

	//상품목록
	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		return adProductMapper.getProductList(cri);
	}

	//페이징을 위한 전체 데이터 수
	@Override
	public int getProductTotalCount(Criteria cri) {
		return adProductMapper.getProductTotalCount(cri);
	}

	//상품코드를 통해 상품 정보 가져오기 - 상품 수정 폼
	@Override
	public ProductVO getProductByPNum(Integer p_num) {
		return adProductMapper.getProductByPNum(p_num);
	}

	//상품 수정 저장
	@Override
	public void updateProduct(ProductVO vo) {
		adProductMapper.updateProduct(vo);
	}

	//상품 삭제
	@Override
	public void deleteProduct(Integer p_num) {
		adProductMapper.deleteProduct(p_num);
	}

}
