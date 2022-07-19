package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.CatetgoryVO;

public interface AdProductMapper {

	//1차 카테고리 불러오기
	List<CatetgoryVO> firstCateList();
}
