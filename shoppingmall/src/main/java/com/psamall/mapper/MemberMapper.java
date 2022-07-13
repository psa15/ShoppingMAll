package com.psamall.mapper;

import com.psamall.domain.MemberVO;
import com.psamall.dto.LoginDTO;

public interface MemberMapper {

	//회원가입 저장
	//controller의 파라미터가 insert문에 해당하는 모든 정보를 커버할 수 있는지 확인해보기
	void join(MemberVO vo);
	
	//id 존재 여부 확인 -> 중복확인
	String idCheck(String m_id);
	
	//로그인 정보 인증
	MemberVO login_ok(LoginDTO dto);
}
