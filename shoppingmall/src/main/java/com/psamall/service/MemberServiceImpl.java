package com.psamall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.MemberVO;
import com.psamall.dto.LoginDTO;
import com.psamall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memMapper;
	
	//회원가입 저장
	@Override
	public void join(MemberVO vo) {
		memMapper.join(vo);
		
	}

	//ID 중복확인
	@Override
	public String idCheck(String m_id) {
		return memMapper.idCheck(m_id);
	}

	//로그인
	@Override
	public MemberVO login_ok(LoginDTO dto) {
		return memMapper.login_ok(dto);
	}

	//아이디 찾기
	@Override
	public String searchId(String m_name, String m_email) {
		return memMapper.searchId(m_name, m_email);
	}

	//임시 비밀번호 발급 전 아이디와 이메일 확인
	@Override
	public String sendNewPw(String m_id, String m_email) {
		return memMapper.sendNewPw(m_id, m_email);
	}

	//임시비밀번호로 비밀번호 업데이트
	@Override
	public void updateTempPw(String m_id, String m_passwd) {
		memMapper.updateTempPw(m_id, m_passwd);
	}

	//회원정보 수정 저장
	@Override
	public void updateModify(MemberVO vo) {
		memMapper.updateModify(vo);
	}

}
