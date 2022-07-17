package com.psamall.service;

import org.apache.ibatis.annotations.Param;

import com.psamall.domain.MemberVO;
import com.psamall.dto.LoginDTO;

public interface MemberService {

	//회원가입 저장
	void join(MemberVO vo);
	
	//id 존재 여부 확인 -> 중복확인
	String idCheck(String m_id);
	
	//로그인 정보 인증
	MemberVO login_ok(LoginDTO dto);
	
	//아이디 찾기
	String searchId(String m_name, String m_email);
	
	//임시 비밀번호 발급 전 아이디와 이메일 확인
	String sendNewPw(String m_id, String m_email);
	
	//임시비밀번호로 비밀번호 업데이트
	void updateTempPw(String m_id, String m_passwd);
	
	//회원정보 수정 저장
	void updateModify(MemberVO vo);
}
