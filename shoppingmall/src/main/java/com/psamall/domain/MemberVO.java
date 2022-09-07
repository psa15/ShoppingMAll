package com.psamall.domain;

import java.util.Date;

import lombok.Data;

//Member테이블
@Data
public class MemberVO {
	
	/*
	 m_id, m_name, m_passwd, m_postcode, m_addr, m_addr_d, m_tel, 
	 m_email, m_email_accept, m_regdate, m_updatedate, m_lastdate, m_authcode
	 */
	private String m_id; //회원 id
	private String m_name; //회원 이름
	private String m_passwd; //회원 비밀번호
	private String m_postcode; //우편번호(5)
	private String m_addr; //기본 주소
	private String m_addr_d; //상세 주소
	private String m_tel; //전화번호
	private String m_email; //이메일 주소
	private String m_email_accept; //이메일 수신여부 - 무조건 yes 여야 함 - default 'Y' -> 그래야 이메일 인증코드 전송 가능
	private Date m_regdate; //가입 날짜
	private Date m_updatedate; //수정 날짜
	private Date m_lastdate; //최근 접속 날짜
	private String m_authcode; //이메일 인증코드(char(1) - default 'N')
	
}
