package com.psamall.service;

import java.util.List;

import com.psamall.domain.QuestionFileVO;
import com.psamall.domain.QuestionVO;
import com.psamall.dto.Criteria;

public interface QuestionService {

	//질문 저장
	void insertQuestion(QuestionVO vo);
	
	//질문 목록
	List<QuestionVO> getQuestionList(Criteria cri);
	//질문 총 개수
	int getQuestionTotalCount(Criteria cri);
	
	//질문 상세
	QuestionVO getQuestionByQNum(Integer q_num);
	//질문 파일 첨부 목록 가져오기
	List<QuestionFileVO> getFileInfo(Integer q_num);
}
