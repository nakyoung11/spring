package com.koreait.matzip;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.koreait.matzip.user.model.UserPARAM;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("인터셉터!");
		HttpSession hs = request.getSession();
		UserPARAM loginUser = (UserPARAM) hs.getAttribute(Const.LOGIN_USER);
		boolean isLoginout = loginUser == null;

		String uri = request.getRequestURI();
		String[] uriArr = uri.split("/");

		if (uriArr.length < 2) { // 주소가 이상한경우
			return false;
		}

		switch (uriArr[1]) {
		case ViewRef.URI_USER:
			switch(uriArr[2]) {
			case "login":case "ajacIdChk":
				if(isLoginout) {
					response.sendRedirect("rest/map");
					return false;
				}
			}

		case ViewRef.URI_RESTAURANT:
			switch (uriArr[2]) {
			case "restReg":
				if (isLoginout) {
					response.sendRedirect("/user/login");
					return false;
				}

			}

		}
		response.sendRedirect("/user/login");
		return false;
	}
}
