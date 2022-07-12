package com.psamall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.psamall.domain.MemberVO;
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
}
