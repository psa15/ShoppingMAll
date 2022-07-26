package com.psamall.domain;

import lombok.Data;

//TBL_CART
@Data
public class CartVO {

	//cart_code, p_num, m_id, cart_amount
	private Long cart_code;
	private Integer p_num;
	private String m_id;
	private int cart_amount;
}
