package com.psamall.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.psamall.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {

	//메일 보내기 위한 객체 생성
	@Setter(onMethod_ = {@Autowired})
	private JavaMailSender mailSender;
	
	@Override
	public void sendMail(EmailDTO dto, String message) {
		
		//메일 구성 정보를 답당하는 객체
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			
			//발신자 메일
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
			
			//수신자 메일
			msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName()) });
			
			//메일 제목
			msg.setSubject(dto.getTitle(), "utf-8");
			
			//본문 내용
			msg.setText(message, "utf-8");
			
			//메일 전송
			mailSender.send(msg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
