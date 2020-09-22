package com.koreait.matzip;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String uri = request.getRequestURI();
		System.out.println("uri :"+uri);
		String[] uriArr = uri.split("/");
		
		if(uriArr[1].equals("res")) { //리소스 통과
			return true;
		}else if(uriArr.length<3) { //주소가 아닌경우
			return false;
		}
		
		System.out.println("인터셉터!");
		boolean isLogout = SecurityUtils.isLogout(request);

		System.out.println("1:"+uriArr[1]);
		switch (uriArr[1]) {
		case ViewRef.URI_USER:
			System.out.println("2:"+uriArr[2]);
			switch(uriArr[2]) {
			case "login": case "join":
				if(!isLogout) {//로그인
					response.sendRedirect("/rest/map");
					return false;
				}
			}

		case ViewRef.URI_REST:
			switch (uriArr[2]) {
			case "restReg":
				if (isLogout) {//로그아웃
					response.sendRedirect("/user/login");
					return false;
				}

			}

		}

		return true;
	}
}
