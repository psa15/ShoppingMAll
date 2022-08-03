package com.psamall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.psamall.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//공통모델

@ControllerAdvice(basePackages = "com.psamall.controller")
@Log4j
public class GlobalControllerAdvice {

	@Setter(onMethod_ = {@Autowired})
	private UserProductService userProductService;
	//카테고리 메뉴 DB에서 불러오기
	
	//1차 카테고리
	@ModelAttribute
	public void mainCateList(Model model) {
		
		log.info("1차 카테고리 불러옴");
		
		model.addAttribute("firstCateList", userProductService.firstCateList());
	}
}
