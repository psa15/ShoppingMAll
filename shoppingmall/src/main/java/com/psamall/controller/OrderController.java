package com.psamall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psamall.domain.MemberVO;
import com.psamall.domain.OrderCartListVO;
import com.psamall.service.OrderService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/order/*")
public class OrderController {
	
	//상품 이미지를 불러오기 위한 bean
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;

	//주문하기 폼
	@GetMapping("/orderList")
	public void orderList(HttpSession session, Model model) {
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		
		List<OrderCartListVO> vo = orderService.orderCartList(m_id);
		for(int i=0; i<vo.size(); i++) {
			String p_image_folder = vo.get(i).getP_image_folder().replace("\\", "/");
			vo.get(i).setP_image_folder(p_image_folder);
		}
		
		model.addAttribute("orderCartList", vo);
		
	}
	
	//주문 상품 이미지 불러오기
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {
		
		log.info("파일 이름: " + fileName);
		
		//저장된 썸네일 이미지를 byte[]로 읽어오는 작업
		return UploadFileUtils.getImageFile(uploadPath, folderName + "\\" + fileName);
	}
	
	//최근 배송지 불러오기
	@GetMapping("/getRecentAddr")
	public void getRecentAddr (HttpSession session, Model model) {
		
	}
}
