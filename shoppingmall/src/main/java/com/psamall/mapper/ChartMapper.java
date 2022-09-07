package com.psamall.mapper;

import java.util.List;

import com.psamall.domain.ChartVO;

public interface ChartMapper {

	//1차 카테고리 별 주문
	List<ChartVO> primaryChart();
	
}
