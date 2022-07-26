package com.psamall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.CatetgoryVO;
import com.psamall.domain.ProductVO;
import com.psamall.dto.Criteria;
import com.psamall.dto.PageDTO;
import com.psamall.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user/product/*")
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
	
	//상품 목록 + 페이징 (REST API)
	@GetMapping("/userProductList/{ct_code}")
	public String userProductList(@PathVariable("ct_code") Integer ct_code, @ModelAttribute("cri") Criteria cri, Model model) {
		
		cri.setAmount(9);
		
		List<ProductVO> productList = userPService.productListBySecondCateCode(ct_code, cri);
		
		//날짜폴더 \ 변환 작업
		for(int i=0; i<productList.size(); i++) {
			String p_image_folder = productList.get(i).getP_image_folder().replace("\\", "/");
			productList.get(i).setP_image_folder(p_image_folder);
		}
		
		model.addAttribute("productList", productList);
		
		int total = userPService.productTotalCountBySecondCateCode(ct_code, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "/user/product/userProductList";
	}
	
	//상품 상세보기(모달)
	@ResponseBody
	@GetMapping("/productDetail/{p_num}")
	public ResponseEntity<ProductVO> productDetail(@PathVariable("p_num") Integer p_num){
		
		ResponseEntity<ProductVO> entity = null;
		
		//이미지 날짜 폴더 \ 변환
		ProductVO vo = userPService.getProductDetail(p_num);
		vo.setP_image_folder(vo.getP_image_folder().replace("\\", "/"));
		
		entity = new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
		
		return entity;
	}
	
	
	
}
