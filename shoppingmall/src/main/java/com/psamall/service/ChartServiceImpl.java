package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.ChartVO;
import com.psamall.mapper.ChartMapper;

import lombok.Setter;

@Service
public class ChartServiceImpl implements ChartService {

	@Setter(onMethod_ = @Autowired)
	private ChartMapper chartMapper;
	
	@Override
	public List<ChartVO> primaryChart() {
		return chartMapper.primaryChart();
	}

}
