package com.psamall.domain;

import lombok.Data;

@Data
public class CartListVO {
	/*
	 C.CART_CODE, C.M_ID, C.P_NUM, C.CART_AMOUNT, 
            M.M_POINT, 
            P.P_BUY_OK, P.P_COST, P.P_IMAGE, P.P_IMAGE_FOLDER, P.P_NAME,  P.P_DISCOUNT, P.P_COMPANY
		
	 */
	
	private Long cart_code;
	private Integer p_num;
	private String m_id;
	private int cart_amount;
	
	private int m_point;
	
	private String p_buy_ok;
	private int p_cost;
	private String p_image;
	private String p_image_folder;
	private String p_name;
	private int p_discount;
	private String p_company;
}
