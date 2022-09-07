package com.psamall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psamall.domain.QuestionFileVO;
import com.psamall.domain.QuestionVO;
import com.psamall.dto.Criteria;
import com.psamall.mapper.QuestionMapper;

import lombok.Setter;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Setter(onMethod_ = @Autowired)
	private QuestionMapper questionMapper;
	
	//질문 저장
	@Override
	public void insertQuestion(QuestionVO vo) {
		
		//질문 저장
		questionMapper.insertQuestion(vo);
		
		//파일 정보 저장
		//첨부파일이 없을 경우
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0)
			return;
		//첨부파일 개수만큼 반복(forEach)
		vo.getAttachList().forEach(attach -> {
			//attach -> : attach(매개변수)
			attach.setQ_num(vo.getQ_num());
			questionMapper.insertFileInfo(attach);
		});
		
	}

	//질문 목록
	@Override
	public List<QuestionVO> getQuestionList(Criteria cri) {
		return questionMapper.getQuestionList(cri);
	}

	//질문 총 개수
	@Override
	public int getQuestionTotalCount(Criteria cri) {
		return questionMapper.getQuestionTotalCount(cri);
	}

	//질문 상세
	@Override
	public QuestionVO getQuestionByQNum(Integer q_num) {
		return questionMapper.getQuestionByQNum(q_num);
	}

	//질문 파일 첨부 목록 가져오기
	@Override
	public List<QuestionFileVO> getFileInfo(Integer q_num) {
		return questionMapper.getFileInfo(q_num);
	}

}
