package com.psamall.domain;

import java.util.Date;

import lombok.Data;

//TBL_REVIEW
@Data
public class ReviewVO {

	//r_num, m_id, p_num, r_content, r_score, r_regdate
	private Integer r_num;
	private String m_id;
	private Integer p_num;
	private String r_content;
	private int r_score;
	private Date r_regdate;
}
