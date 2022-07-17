package com.psamall.mapper;

import org.apache.ibatis.annotations.Param;

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
	
	//아이디 찾기
	String searchId(@Param("m_name") String m_name, @Param("m_email") String m_email);
	
	//임시 비밀번호 발급 전 아이디와 이메일 확인
	String sendNewPw(@Param("m_id") String m_id, @Param("m_email") String m_email);
	
	//임시비밀번호로 비밀번호 업데이트
	void updateTempPw(@Param("m_id") String m_id, @Param("m_passwd") String m_passwd);

	//회원정보 수정 저장
	void updateModify(MemberVO vo);
}
