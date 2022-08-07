package com.psamall.dto;

import java.util.List;

import lombok.Data;

//OrderProductDTO 클래스를 List 타입의 변수로 선언
@Data
public class OrderProductListDTO {

	private List<OrderProductDTO> checkedValue;
}
