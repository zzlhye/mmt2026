package com.mis.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mis.domain.UserVO;
import com.mis.service.UserService;

@Controller
@RequestMapping("/mypage")
public class MypageController {

	@Inject
	private UserService userService;

	// 마이페이지
	@RequestMapping(value = "/myInfo", method = RequestMethod.GET)
	public String myInfo(HttpSession session, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		model.addAttribute("teamTerm", userService.getUserTeamTerm(loginUser.getUserId()));

		model.addAttribute("user", userService.read(loginUser.getUserId()));

		return "/mypage/myInfo";
	}

	// 회원 정보 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateGET(HttpSession session, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		model.addAttribute("user", userService.read(loginUser.getUserId()));

		return "/mypage/update";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(HttpSession session, UserVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		vo.setUserId(loginUser.getUserId());
		userService.update(vo);

		UserVO updatedUser = userService.read(loginUser.getUserId());
		session.setAttribute("loginUser", updatedUser);

		return "redirect:/mypage/myInfo";
	}
}