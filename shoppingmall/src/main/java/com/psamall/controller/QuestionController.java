package com.psamall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/ask/*")
public class QuestionController {

	//질문 작성 폼
	@GetMapping("/userQuestion")
	public void userQuestion(HttpSession session) {
		
	}
	
	//질문 리스트
	@GetMapping("/userQuestionList")
	public void userQuestionList() {
		
	}
}
