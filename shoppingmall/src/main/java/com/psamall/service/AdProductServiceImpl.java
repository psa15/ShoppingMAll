package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.CatetgoryVO;
import com.psamall.mapper.AdProductMapper;

import lombok.Setter;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Setter(onMethod_ = {@Autowired})
	private AdProductMapper adPMapper;
	
	//1차 카테고리 불러오기
	@Override
	public List<CatetgoryVO> firstCateList() {
		return adPMapper.firstCateList();
	}

	//2차 카테고리 불러오기
	@Override
	public List<CatetgoryVO> secondCateList(Integer firstCategoryCode) {
		return adPMapper.secondCateList(firstCategoryCode);
	}

}
