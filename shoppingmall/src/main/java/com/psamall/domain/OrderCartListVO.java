package com.psamall.domain;

import lombok.Data;

//TBL_CART와 TBL_PRODUCT 조인
@Data
public class OrderCartListVO {

	/*
	  c.cart_code, c.p_num, c.m_id, c.cart_amount,
      p. p_name, p.p_cost, p.p_discount, p.p_company, p.p_image, p.p_image_folder
	 */
	
	private Long cart_code;
	private Integer p_num;
	private String m_id;
	private int cart_amount;
	
	private String p_name;
	private int p_cost;
	private int p_discount;
	private String p_company;
	private String p_image;
	private String p_image_folder;
	
}
