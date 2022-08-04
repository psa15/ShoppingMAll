package com.psamall.domain;

import lombok.Data;

//TBL_ORDER_D
@Data
public class OrderDetailVO {

	//ord_code, p_num, ord_amount, ord_cost
	private Long ord_code;
	private Integer p_num;
	private int ord_amount;
	private int ord_cost;
}
