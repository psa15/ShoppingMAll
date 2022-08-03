package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.psamall.dto.EmailDTO;
import com.psamall.service.EmailService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/email/*")
public class EmailController {

	@Setter(onMethod_ = {@Autowired})
	private EmailService emailService;
	
	//메일 보내기
	@GetMapping("/send")
	public ResponseEntity<String> send(EmailDTO dto, HttpSession session){
		ResponseEntity<String> entity = null;
		
		//인증코드 6자리 생성
		String authCode = "";
		for(int i=0; i<6; i++) {
			authCode += String.valueOf((int)(Math.random()*10));
		}
		
		session.setAttribute("authCode", authCode);
		
		log.info("인증코드 : " + authCode);
		
		//메일 보내기 기능
		try {
			
			emailService.sendMail(dto, authCode);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
						
		} catch (Exception e) {
			//콘솔에 출력
			e.printStackTrace();
			
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
