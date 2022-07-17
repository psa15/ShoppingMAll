package com.psamall.service;

import org.omg.PortableInterceptor.AdapterManagerIdHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.AdminVO;
import com.psamall.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = {@Autowired})
	private AdminMapper adMapper;
	
	//관리자 로그인
	@Override
	public AdminVO adLogin(AdminVO vo) {
		return adMapper.adLogin(vo);
	}

	//관리자 최근 접속 날짜 업데이트
	@Override
	public void updateDate(String admin_id) {
		adMapper.updateDate(admin_id);
	}

}
