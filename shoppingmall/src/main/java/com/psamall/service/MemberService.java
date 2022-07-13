package com.psamall.service;

import com.psamall.domain.MemberVO;

public interface MemberService {

	//회원가입 저장
	void join(MemberVO vo);
	
	//id 존재 여부 확인 -> 중복확인
	String idCheck(String m_id);
}
