package com.psamall.domain;

import lombok.Data;

@Data
public class ChartVO {

	private String primary_cd; //1차 카테고리 이름
	private int sales_p;	//1차 카테고리 별 매출 통계
	private String secondary_cd;	//2차 카테고리 이름
	private int sales_s;	//2차 카테고리 별 매출 통계
	private String month;	//각 월
	private int monthly_sales;	//월 별 매출
	private String year;	//각 년도
	private int total;	//년도별 총 매출
}
