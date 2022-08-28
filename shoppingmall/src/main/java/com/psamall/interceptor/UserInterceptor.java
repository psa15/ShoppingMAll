package com.psamall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.psamall.domain.MemberVO;

import lombok.extern.log4j.Log4j;

//사용자 로그인
@Log4j
public class UserInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean result = false;
		//preHandle()메소드의 리턴타입이 boolean
		
		//인증된 사용자인지 여부를 체크 - 세션 객체를 확인
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		//session.getAttribute("loginStatus");의 결과가 Object 형이어서 loginStatus의 원래 데이터 타입인 MemberVO로 변환
		
		if(user == null) {
			//인증 정보가 존재하지 않는다(비로그인 사용자)
			result = false;
			
			//비동기식 요청 : 서버에 요청을 보내놓고 결과 도착 유무에 상관없이 다른 것을 할 수 있음
			//동기식 요청 : 서버에 요청을 보내놓고 결과 도착 해야 다른 작업 가능
			
			//ajax요청인지 여부를 체크(비동기식 요청)
			if(isAjaxRequest(request)) {
//				log.info("ajax요청임");
				System.out.println("ajax요청임");
				response.sendError(400);// ajax요청시 응답에러 코드 400 리턴.
				//접근했던 주소(getDestination()메소드) 사용 X
				
			} else {
				System.out.println("ajax요청 아님");
				
				//ex)사용자가 장바구니에 접근하려고 했다는 정보를 가지고 있는 메소드!
				getDestination(request); //로그인이 끝난 후 보낼 주소 -> 로그인 메소드에서 사용
				
				response.sendRedirect("/member/login");
			}						
			
		}else {
			//인증 정보가 존재한다. 로그인 사용자
			result = true;
		}
		
		
		return result; //true이면 controller로 제어가 넘어감
	}

	//ajax요청인지 확인
	//request 안에 ajax로 요청이 들어왔는지의 정보를 가지고 있음
	private boolean isAjaxRequest(HttpServletRequest request) {

		boolean isAjax = false;
		
		//ajax구문에서 요청 시 헤더에 AJAX : "true" 를 작업
		String header = request.getHeader("AJAX");
		
		if("true".equals(header)) {
			isAjax = true;
		}
		
		return isAjax;
	}

	//브라우저가 인터셉터로 넘어올 때 요청했던 주소
	private void getDestination(HttpServletRequest request) {

		String uri = request.getRequestURI(); //브라우저가 요청한 주소(쿼리스트링 제외)(ex. /user/cart/cartList)
		String query = request.getQueryString(); //주소의 ? 뒤에 부분 (ex. p_num=10)
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		String destination = uri + query; // ex) /user/cart/cartList?p_num=10 or /user/cart/cartList
		
		if(request.getMethod().equals("GET")) {
			//사용자가 비로그인 상태에서 요청한 원래 주소를 세션으로 저장해두기
			request.getSession().setAttribute("destination", destination);
		}
		
	}
}
