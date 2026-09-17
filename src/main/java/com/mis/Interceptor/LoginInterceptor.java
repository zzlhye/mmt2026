package com.mis.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mis.domain.UserVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String LOGIN_USER = "loginUser"; // 세션에 로그인 정보를 저장할 때 이름

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 로그인 처리(로그인 정보를 세션객체에 담기) 하기 전에 로그인 정보 삭제
		HttpSession session = request.getSession();

		// 중복 로그인 방지를 위해 로그인 정보가 이미 있으면 지우기
		if (session.getAttribute(LOGIN_USER) != null) {
			session.removeAttribute(LOGIN_USER);
		}

		return true;

	}

	// 로그인 성공 후 세션에 로그인 정보 저장 + 페이지 이동
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();

		ModelMap modelMap = modelAndView.getModelMap();
		UserVO userVO = (UserVO) modelMap.get("userVO");

		if (userVO != null) {
			// 1) 로그인 정보 있으면 세선 객체에 저장
			System.out.println("로그인 성공=> 세션 객체에 저장");

			session.setAttribute(LOGIN_USER, userVO);

			// 2) 사용자가 보고 있었던 페이지 저장
			Object dest = session.getAttribute("dest");

			// 3) 로그인 처리 후 페이지 이동 (사용자가 보고 있었던 페이지로 이동, 없으면 메인으로 이동)
			response.sendRedirect(dest != null ? (String) dest : "/");
		}

	}

}
