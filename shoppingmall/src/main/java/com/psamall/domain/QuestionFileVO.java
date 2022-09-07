package com.psamall.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QuestionFileVO {

	//uuid, uploadpath, filename, q_num
	private String filename;
	private String fileFolder;
	private Integer q_num;
	
	
	
	
}
