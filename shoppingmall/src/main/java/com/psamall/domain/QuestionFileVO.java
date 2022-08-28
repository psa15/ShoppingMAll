package com.psamall.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QuestionFileVO {

	//uuid, uploadpath, filename, q_num
	private String uuid;
	private String uploadpath;
	private String filename;
	private Integer q_num;
	
	public QuestionFileVO(String uuid, String uploadpath, String filename) {
		super();
		this.uuid = uuid;
		this.uploadpath = uploadpath;
		this.filename = filename;
	}
	
	
}
