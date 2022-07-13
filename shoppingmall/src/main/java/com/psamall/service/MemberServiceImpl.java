package com.psamall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.MemberVO;
import com.psamall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	//회원가입 저장
	@Override
	public void join(MemberVO vo) {
		mapper.join(vo);
		
	}

	//ID 중복확인
	@Override
	public String idCheck(String m_id) {
		return mapper.idCheck(m_id);
	}

}
