package com.psamall.domain;

import java.util.Date;

import lombok.Data;

//TBL_PAYMENT
@Data
public class PaymentVO {

	/*
	 pay_code, ord_code, pay_method, pay_date, pat_tot_price, 
	 pay_rest_price, pay_noAccount_price, pay_noAccount_username, pay_noAccount_bank
	 */
	
	private Integer pay_code;
	private Long ord_code;
	private String pay_method;
	private Date pay_date;
	private int pat_tot_price;
	private int pay_rest_price;
	private int pay_noAccount_price;
	private String pay_noAccount_username;
	private String pay_noAccount_bank;
}
