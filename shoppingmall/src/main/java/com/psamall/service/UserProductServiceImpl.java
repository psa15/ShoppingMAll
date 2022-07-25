package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.CatetgoryVO;
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

}
