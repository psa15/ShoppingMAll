package com.psamall.service;

import com.psamall.domain.MemberVO;
import com.psamall.dto.LoginDTO;

public interface MemberService {

	//회원가입 저장
	void join(MemberVO vo);
	
	//id 존재 여부 확인 -> 중복확인
	String idCheck(String m_id);
	
	//로그인 정보 인증
	MemberVO login_ok(LoginDTO dto);
}
