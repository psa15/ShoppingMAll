package com.psamall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.psamall.domain.ChartVO;
import com.psamall.service.ChartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/chart/*")
public class ChartController {
	
	@Setter(onMethod_ = @Autowired)
	private ChartService chartService;
	
	//전체 주문 통계
	@GetMapping("/orderOverall")
	public void orderOverall(Model model) {		
		
		List<ChartVO> primary_list = chartService.primaryChart();
		
		String primaryData = "[";
		primaryData +=			"['1차 카테고리', '매출'],";
		
		int i=0;
		for(ChartVO vo : primary_list) {
			primaryData += "['" + vo.getPrimary_cd() + "', " + vo.getSales_p() + "]";
			i++;
			
			//마지막 데이터 처리시 콤마(,)는 추가 안함
			if( i < primary_list.size()) primaryData += ",";
		}
		
		primaryData += "]";
		
		model.addAttribute("primaryData", primaryData);
	}

}
