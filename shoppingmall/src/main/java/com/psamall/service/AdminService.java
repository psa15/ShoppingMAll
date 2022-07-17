package com.psamall.service;

import com.psamall.domain.AdminVO;

public interface AdminService {

	//관리자 로그인
	AdminVO adLogin(AdminVO vo);
	
	//관리자 최근 접속날짜 업데이트
	void updateDate(String admin_id);
}
