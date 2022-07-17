package com.psamall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmailDTO {

	//메일쓰기의 정보
	private String senderName; //이메일 발신자 이름
	private String senderMail; //발신자 메일 주소
	private String receiverMail; //수신자 메일 주소
	private String title; //메일 제목
	private String message; //메일 내용
	
	public EmailDTO() {
		this.senderName = "PSA Mall";
		this.senderMail = "psaMall";
		this.title = "PSA Mall 회원가입 메일 인증코드입니다.";
		this.message = "메일 인증을 위한 인증코드를 확인하시고, 회원가입 시 인증코드를 입력해 주세요.";
	}
}
