package com.psamall.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.psamall.domain.ProductVO;
import com.psamall.service.UserProductService;

import lombok.Setter;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	
	@Setter(onMethod_ = {@Autowired})
	private UserProductService userPService;
	
	//홈
	@RequestMapping("/")
	public String index(Model model) {
		
		List<ProductVO> productList = userPService.getAllProduct();
		//날짜폴더 \ 변환 작업
		for(int i=0; i<productList.size(); i++) {
			String p_image_folder = productList.get(i).getP_image_folder().replace("\\", "/");
			productList.get(i).setP_image_folder(p_image_folder);
		}
		
		model.addAttribute("productList", productList);
		
		return "index";
	}
}
