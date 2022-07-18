package com.psamall.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

//관리자가 상품관리할 수 있는 기능 제공
@Controller
@Log4j
@RequestMapping("/admin/product/*")
public class AdProductController {

	//상품 등록을 위한 bean 주입
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	//상품 등록 폼
	@GetMapping("/addProduct")
	public void addProduct() {
		
	}
	
	
	//상품 저장
}
