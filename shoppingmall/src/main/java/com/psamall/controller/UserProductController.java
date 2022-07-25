package com.psamall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.psamall.domain.CatetgoryVO;
import com.psamall.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product/*")
@Log4j
public class UserProductController {

	@Setter(onMethod_ = {@Autowired})
	private UserProductService userPService;
	
	//1차 카테고리 : GlobalControllerAdvice에서 작업함 -> 생략
	
	//2차 카테고리 : ajax로 업데이트
	@RequestMapping("/subCateList/{ct_code}")
	public ResponseEntity<List<CatetgoryVO>> subCateList(@PathVariable("ct_code") Integer ct_code) {
		
		ResponseEntity<List<CatetgoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CatetgoryVO>>(userPService.secondCateList(ct_code), HttpStatus.OK);
		
		return entity;
	}
	
	
}
