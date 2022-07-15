package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.MemberVO;
import com.psamall.dto.LoginDTO;
import com.psamall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	
	@Setter(onMethod_ = {@Autowired})  
	private MemberService memService;
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	//회원가입 폼 저장
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		//사용자가 입력한 평문 텍스트 비밀번호를 암호화
		String cryptPasswordEncoder = bCryptPasswordEncoder.encode(vo.getM_passwd());
		
		log.info("사용자가 입력한 비밀번호: " + vo.getM_passwd());
		log.info("암호화된 비밀번호: " + cryptPasswordEncoder);
		
		//암호화된 비밀번호를 저장
		vo.setM_passwd(cryptPasswordEncoder);
		
		//메일 수신여부 반드시 체크하게
		if(vo.getM_email_accept().equals("on")) {
			vo.setM_email_accept("Y");
		}
		memService.join(vo);
		
		return "/member/login";
	}
	
	//ID 중복 체크
	@GetMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<String> idCheck(String m_id) {
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재 여부 작업(중복확인)
		String isUsedID = "";
		
		if(memService.idCheck(m_id) != null) {
			
			isUsedID = "no"; //중복되는 아이디가 없으므로 사용 가능
			
		} else {
			
			isUsedID = "yes";
		}
		
		entity = new ResponseEntity<String>(isUsedID, HttpStatus.OK);
		
		return entity;
	}
	
	//메일 인증확인 작업
	@PostMapping("/confirmAuthCode")
	@ResponseBody
	public ResponseEntity<String> confirmAuthCode(String userAuthCode, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String authCode = (String) session.getAttribute("authCode");
		//emailcontroller의 session.setAttribute("authCode", authCode);
		
		if(userAuthCode.equals(authCode)) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
			//메일인증코드 세션 소멸작업
			session.removeAttribute("authCode");
			
		} else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	//로그인 폼
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/login")
	public String login(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception{
		//throws Exception : db작업이 들어가므로
		
		//로그인 정보 인증 작업
		MemberVO vo = memService.login_ok(dto); //vo에는 사용자가 입력한 아이디에 해당하는 회원정보들이 저장
		
		//이동할 주소
		String url = "";
		
		//아이디 혹은 비밀번호가 틀렸다고 사용자에게 알리기
		String msg = "";
		
		if(vo != null) {
			
			if(bCryptPasswordEncoder.matches(dto.getM_passwd(), vo.getM_passwd())) {
				//1) 비번 일치 -> 메인페이지로 이동
				url = "/";
				
				//로그인 성공 시 서버측에 세션을 통해 회원정보 저장
				session.setAttribute("loginStatus", vo);
				
			} else {
				//2)비번 불일치 -> 다시 로그인 페이지로
				url = "/member/login";
				
				msg = "noPW";
			}
			
		} else {
			//아이디가 존재하지 않는 경우 -> 로그인 페이지로
			url = "/member/login";
			
			msg = "noID";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:" + url;
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		//세션에 저장된 모든 정보 제거
		session.invalidate();
		
		return "redirect:/";
	}
	
	//ID 찾기
	//@PostMapping("/lostId")
	
}
