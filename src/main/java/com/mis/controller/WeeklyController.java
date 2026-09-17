package com.mis.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mis.domain.UserVO;
import com.mis.domain.WeeklyVO;
import com.mis.service.WeeklyService;

@Controller
@RequestMapping("/weekly")
public class WeeklyController {

	@Inject
	private WeeklyService weeklyService;

	// 주차 등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void register(@RequestParam("teamNum") int teamNum, Model model) throws Exception {

		model.addAttribute("teamNum", teamNum);
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(WeeklyVO vo, @RequestParam("teamNum") int teamNum, HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		vo.setTeamNum(teamNum);
		vo.setUserId(loginUser.getUserId());

		weeklyService.create(vo);

		return "redirect:/mentoring/mentoringList?teamNum=" + teamNum;
	}

	// 주차 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(@RequestParam("weeklyNum") int weeklyNum, Model model, HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		model.addAttribute("weekly",weeklyService.read(weeklyNum));

		return "/weekly/update";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePost(WeeklyVO vo, HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		weeklyService.update(vo);

		return "redirect:/mentoring/mentoringList?teamNum=" + vo.getTeamNum();
	}

	// 주차 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("weeklyNum") int weeklyNum, @RequestParam("teamNum") int teamNum) throws Exception {

		weeklyService.delete(weeklyNum);

		return "redirect:/mentoring/mentoringList?teamNum=" + teamNum;
	}
}
