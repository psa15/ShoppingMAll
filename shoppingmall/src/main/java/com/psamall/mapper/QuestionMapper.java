package com.psamall.mapper;

import com.psamall.domain.QuestionFileVO;
import com.psamall.domain.QuestionVO;

public interface QuestionMapper {

	//질문 저장
	void insertQuestion(QuestionVO vo);
	
	//파일 정보 저장
	void insertFileInfo(QuestionFileVO vo);
}
