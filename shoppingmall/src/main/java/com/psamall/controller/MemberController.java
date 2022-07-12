package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		//메일 수신여부 반드시 체크하게
		if(vo.getM_email_accept().equals("on")) {
			vo.setM_email_accept("Y");
		}
		service.join(vo);
		
		return "";
	}
	
	//ID 중복 체크
	@GetMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<String> idCheck(String m_id) {
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재 여부 작업(중복확인)
		String isUsedID = "";
		
		if(service.idCheck(m_id) != null) {
			
			isUsedID = "no"; //중복되는 아이디가 없으므로 사용 가능
			
		} else {
			
			isUsedID = "yes";
		}
		
		entity = new ResponseEntity<String>(isUsedID, HttpStatus.OK);
		
		return entity;
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
