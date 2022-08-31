package com.psamall.service;

import java.util.List;

import com.psamall.domain.QuestionVO;
import com.psamall.dto.Criteria;

public interface QuestionService {

	//질문 저장
	void insertQuestion(QuestionVO vo);
	
	//질문 목록
	List<QuestionVO> getQuestionList(Criteria cri);
	
	//질문 총 개수
	int getQuestionTotalCount(Criteria cri);
}
