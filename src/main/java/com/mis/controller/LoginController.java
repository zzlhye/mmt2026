package com.mis.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mis.domain.UserVO;
import com.mis.dto.LoginDTO;
import com.mis.service.UserService;

@Controller
public class LoginController {

	@Inject
	private UserService userService;

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET() throws Exception {

	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public String loginPost(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		UserVO user = userService.login(dto);

		// 로그인 실패 시
		if (user == null) {
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/";
		}

		// 로그인 성공 시 세션에 회원 정보 저장
		session.setAttribute("loginUser", user);

		return "redirect:/home";

	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

}
