package com.psamall.service;

import com.psamall.dto.EmailDTO;

public interface EmailService {

	//메일 보내기
	void sendMail(EmailDTO dto, String message);
	
}
