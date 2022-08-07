package com.psamall.dto;

import lombok.Data;

//장바구니에서 선택된 상품 주문할 때 사용할 클래스
@Data
public class OrderProductDTO {
	
	//jsp에서 전달받을 값
	private Integer p_num;
	private int cart_amount;
	
	//db에서 가져올 값
	private String p_name;
	private int p_cost;
	private int p_discount;
	private String p_image;
	private String p_image_folder;
}
