package com.psamall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//TBL_PRODUCT
@Data
public class ProductVO {

	/*
	 p_num, f_ct_code, s_ct_code, p_name, p_cost, p_discount, p_company, p_detail, 
	 p_image, p_image_folder, p_amount, p_buy_ok, p_regdate, p_updatedate
	 */
	private Integer p_num;
	private Integer f_ct_code;
	private Integer s_ct_code;
	private String p_name;
	private int p_cost;
	private int p_discount;
	private String p_company;
	private String p_detail;
	private String p_image; //업로드 되는 파일 이름
	private String p_image_folder; //날짜 폴더
	private int p_amount;
	private String p_buy_ok;
	private Date p_regdate;
	private Date p_updatedate;
	
	//리뷰개수 표시 위해 컬럼 하나 추가
	private int r_count;
	
	//상품 이미지 파일을 받는 필드
	private MultipartFile uploadFile;
	
}
