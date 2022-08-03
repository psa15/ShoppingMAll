package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.AdminVO;
import com.psamall.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {

	@Setter(onMethod_ = {@Autowired})
	private AdminService adminService;
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//관리자 로그인페이지
	@GetMapping("")
	public String adLogin() {
		return "/admin/adLogin";
	}
	//관리자 로그인
	@PostMapping("/adLogin")
	public String adLogin(AdminVO vo, HttpSession session, RedirectAttributes rttr) {
		
		AdminVO db_vo = adminService.adLogin(vo);
		
		//관리자 최근 접속 날짜 업데이트
		adminService.updateDate(db_vo.getAdmin_id());
		
		String url = "";
		
		if(bCryptPasswordEncoder.matches(vo.getAdmin_pw(), db_vo.getAdmin_pw())) {
			url = "/admin/main";
			
			session.setAttribute("adLoginStatus", vo);
		} else {
			url = "/admin/";
			rttr.addFlashAttribute("msg", "noData");
		}		
		
		return url;
	}
	
	//메인 페이지
	@GetMapping("/main")
	public void main() {
		
	}
	
	//로그아웃
	@GetMapping("/adLogout")
	public String logout(HttpSession session) {
		
		//세션 소멸
		session.invalidate();
		
		return "redirect:/admin/";
	}
}
