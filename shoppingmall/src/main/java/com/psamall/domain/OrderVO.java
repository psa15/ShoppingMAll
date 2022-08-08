package com.psamall.domain;

import java.util.Date;

import lombok.Data;

//TBL_ORDER
@Data
public class OrderVO {

	//ord_code, m_id, ord_name, ord_postcode, ord_addr, ord_addr_d, ord_tel, ord_email, ord_totalcost, ord_date, ord_default_addr
	private Long ord_code;
	private String m_id;
	private String ord_name; //배송받는 사람 이름
	private String ord_postcode;
	private String ord_addr;
	private String ord_addr_d;
	private String ord_tel;
	private String ord_email;
	private int ord_totalcost;
	private Date ord_date;
	private String ord_message; //배송 메시지
	
	private String ord_status; //주문상태 컬럼 : 상품 준비중(DEFAULT) / 베송 준비 중 / 배송 보류 / 배송 대기 / 배송 중 / 배송 완료
	private String pay_status; //결제 상태 컬럼: 입금 전 / 추가 입금 대기 / 입금 완료(수동) / 입금 완료(자동) / 결제 완료
	private String cs_status;	//cs 상태 : 취소 / 교환 / 반품 / 환불
}
