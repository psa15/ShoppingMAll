package com.psamall.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.CartVO;
import com.psamall.domain.MemberVO;
import com.psamall.dto.EmailDTO;
import com.psamall.dto.LoginDTO;
import com.psamall.service.EmailService;
import com.psamall.service.MemberService;
import com.psamall.service.UserCartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	
	@Setter(onMethod_ = {@Autowired})  
	private MemberService memberService;
	
	@Setter(onMethod_ = {@Autowired})  
	private EmailService emailService;
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Setter(onMethod_ = {@Autowired})
	private UserCartService cartService;
	
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
		
		if(vo.getM_authcode() != null) {
			vo.setM_authcode("Y");
		}
		
		memberService.join(vo);
		
		return "/member/login";
	}
	
	//ID 중복 체크
	@GetMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<String> idCheck(String m_id) {
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재 여부 작업(중복확인)
		String isUsedID = "";
		
		if(memberService.idCheck(m_id) != null) {
			
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
		MemberVO vo = memberService.login_ok(dto); //vo에는 사용자가 입력한 아이디에 해당하는 회원정보들이 저장
		
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
				
				session.setAttribute("totalCart", cartService.totalCart(vo.getM_id()));
				
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
	public String logout(HttpSession session,  RedirectAttributes rttr) {
		
		//세션에 저장된 모든 정보 제거
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "logout");
		
		return "redirect:/";
	}
	
	//ID 찾기
	@GetMapping("/lostId")
	public void lostId() {
		
	}
	@PostMapping("/searchId")
	public String searchId(@RequestParam("m_name") String m_name, @RequestParam("m_email") String m_email, 
							Model model, RedirectAttributes rttr) {
		
		log.info("이름: " + m_name);
		log.info("이메일: " + m_email);
		
		String userid = memberService.searchId(m_name, m_email);
		log.info("사용자 아이디: " + userid);
						
		String url = "";
		if(userid != null) {
			//정보가 있을 경우
			url = "/member/searchId";
			model.addAttribute("m_id", userid);
		} else {
			//일치하는 정보가 없을 시
			rttr.addFlashAttribute("msg", "noData");
			url = "redirect:/member/lostId";
		}
		
		return url;
		
	}
	
	//임시 비밀번호 발급
	@GetMapping("/newPw")
	public void newPw() {
		
	}
	@PostMapping("/sendNewPw")
	public String sendNewPw(@RequestParam("m_id") String m_id, @RequestParam("m_email") String m_email, 
							Model model, RedirectAttributes rttr) {
		
		String db_m_id = memberService.sendNewPw(m_id, m_email);
		String temp_m_passwd = "";
		String url = "";
		
		if(db_m_id != null) {
			//정보가 있다면 임시비밀번호 생성
			UUID uuid = UUID.randomUUID();
			log.info(uuid);
			temp_m_passwd = uuid.toString().substring(0, 6);
			
			//임시비밀번호를 암호화하여 저장
			memberService.updateTempPw(m_id, bCryptPasswordEncoder.encode(temp_m_passwd));
			
			//메일보내기
			EmailDTO dto = new EmailDTO("PsaMall", "PsaMall", m_email, "PSA Mall 임시비밀번호 입니다.", "");
			try {
				
				emailService.sendMail(dto, temp_m_passwd);
				model.addAttribute("mail", "mail");
				url = "/member/searchId";
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			url = "redirect:/member/newPw";
			rttr.addFlashAttribute("msg", "noData");
		}
		
		return url;
	}
	
	//회원정보 수정 전 비밀번호 확인
	@GetMapping("/confirmPw")
	public void confirmPw() {
		
	}
	@PostMapping("/confirmPw")
	public String confirmPw(@RequestParam("m_passwd")String m_passwd, HttpSession session, RedirectAttributes rttr) {
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		
		LoginDTO dto = new LoginDTO(m_id, m_passwd);
		
		//로그인 정보 인증 작업
		MemberVO vo = memberService.login_ok(dto);
		
		//이동할 주소
		String url = "";
		String db_m_passwd = vo.getM_passwd();
					
		if(bCryptPasswordEncoder.matches(dto.getM_passwd(), db_m_passwd)) {
			//1) 비번 일치 -> 회원 정보 수정 페이지로 이동
			url = "/member/modify";
			
		} else {
			//2)비번 불일치 -> 다시 로그인 페이지로
			url = "/member/confirmPw";
			rttr.addFlashAttribute("msg", "wrongPw");				
		}
			

		return "redirect:" + url;
	}
	
	//회원정보 수정 폼
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) {
		
		String m_id = ((MemberVO)session.getAttribute("loginStatus")).getM_id();
		
		LoginDTO dto = new LoginDTO(m_id, ""); //아이디만 사용
		
		MemberVO vo = memberService.login_ok(dto);
		
		model.addAttribute("memberVO", vo);
	}
	//회원정보 수정 저장
	@PostMapping("/modify")
	public String modify(MemberVO vo, RedirectAttributes rttr) {
		
		log.info("회원수정 정보: " + vo);
		//비밀번호를 수정했을 시 비밀번호 암호화
		if(vo.getM_passwd() != null && !vo.getM_passwd().equals("")) {
			log.info("변경 비밀번호: " + vo.getM_passwd());
			String cryptEncoderPw = bCryptPasswordEncoder.encode(vo.getM_passwd());
			vo.setM_passwd(cryptEncoderPw);
		}
		
		/*
		 메일 수신 여부
		 <input type="checkbox" value="Y"> 라고 value값을 지정해 뒀다면 if(vo.getM_email_accept().equals("Y"))
		 <input type="checkbox"> value값 지정 안하면 체크박스 선택 안할 시 null로 인식이 됨
		 	-> if(vo.getM_email_accept() != null)
		 
		 */
		if(vo.getM_email_accept().equals("on")) {
			vo.setM_email_accept("Y");
		} else {
			vo.setM_email_accept("N");
		}
		
		memberService.updateModify(vo);
		
		return "redirect:/";
	}
 	
}
