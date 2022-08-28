package com.psamall.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

//질문 게시판 TBL_QNA
@Data
public class QuestionVO {

	//Q_NUM, M_ID, Q_TITLE, Q_CONTENT, Q_REGDATE, Q_PASSWORD, Q_OPEN, Q_FILE_EXIST
	//q_num, m_id, q_title, q_content, q_regdate, q_password, q_open, q_file_exist
	private Integer q_num;	//게시글 번호
	private String m_id;	//작성자 id
	private String q_title;	//게시글 제목
	private String q_content;	//게시글 내용
	private Date q_regdate;	//게시글 작성 날짜
	private String q_password;	//게시글 비밀번호
	private String q_open;	//게시글 공개 여부 Y/N
	private String q_file_exist;	//게시글 파일 첨부 여부 Y/N
	
	private List<QuestionFileVO> attachList;
}
