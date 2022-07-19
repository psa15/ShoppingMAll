package com.psamall.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.CatetgoryVO;
import com.psamall.service.AdProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//관리자가 상품관리할 수 있는 기능 제공
@Controller
@Log4j
@RequestMapping("/admin/product/*")
public class AdProductController {

	//상품 등록을 위한 bean 주입
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private AdProductService adPService;
	
	//상품 등록 폼 + 1차 카테고리 불러오기
	@GetMapping("/addProduct")
	public void addProduct(Model model) {
		model.addAttribute("firstCateList", adPService.firstCateList());
	}
	//2차 카테고리 불러오기
	@ResponseBody
	@GetMapping("/secondCateList/{f_CategoryCode}")
	public ResponseEntity<List<CatetgoryVO>> secondCateList(@PathVariable("f_CategoryCode") Integer firstCategoryCode) {
		
		ResponseEntity<List<CatetgoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CatetgoryVO>>(adPService.secondCateList(firstCategoryCode), HttpStatus.OK);
		
		return entity;
	}
	
	
	//상품 저장
}
