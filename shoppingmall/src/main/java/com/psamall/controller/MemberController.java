package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.MemberVO;
import com.psamall.dto.EmailDTO;
import com.psamall.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService service;
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	//회원가입 폼 저장
	@PostMapping("/join")
	public String join(MemberVO vo) {
		
		service.insert(vo);
		
		return "";
	}
	
	//로그인 폼
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/login")
	public String login(EmailDTO dto, RedirectAttributes rttr, HttpSession session) {
		
		return "";
	}
}
