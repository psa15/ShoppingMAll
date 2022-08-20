package com.psamall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.psamall.domain.OrderVO;
import com.psamall.dto.Criteria;
import com.psamall.dto.PageDTO;
import com.psamall.mapper.AdOrderMapper;
import com.psamall.service.AdOrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdOrderService adOrderService;

	//주문 목록
	@GetMapping("/adOrderList")
	public void orderList(Model model, Criteria cri) {
		
		List<OrderVO> orderList = adOrderService.getOrderList(cri);
		model.addAttribute("orderList", orderList);
		
		model.addAttribute("pageMaker", new PageDTO(cri, adOrderService.getTotalOrder(cri)));
		
	}
}
