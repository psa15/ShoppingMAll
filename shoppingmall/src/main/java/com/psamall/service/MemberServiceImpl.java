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
	
	@Override
	public void insert(MemberVO vo) {
		mapper.insert(vo);
		
	}

}
