package com.mis.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.domain.PageMaker;
import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.service.UserService;

@Controller
@RequestMapping("/member")
public class UserController {

	@Inject
	private UserService userService;

	// 멘토 목록
	@RequestMapping(value = "/mentoList", method = RequestMethod.GET)
	public String mentoList(HttpSession session, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		cri.setAuthority("M");

		model.addAttribute("list", userService.listSearch(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(userService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/member/mentoList";
	}

	// 멘티 목록
	@RequestMapping(value = "/mentiList", method = RequestMethod.GET)
	public String mentiList(HttpSession session, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		cri.setAuthority("S");

		model.addAttribute("list", userService.listSearch(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(userService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/member/mentiList";
	}

	// 멘토 등록
	@RequestMapping(value = "/mentoRegister", method = RequestMethod.GET)
	public String mentoRegisterGET(HttpSession session) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		return "/member/mentoRegister";
	}

	@RequestMapping(value = "/mentoRegister", method = RequestMethod.POST)
	public String mentoRegisterPOST(HttpSession session, UserVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		userService.mentoCreate(vo);

		return "redirect:/member/mentoList";
	}

	// 멘티 등록
	@RequestMapping(value = "/mentiRegister", method = RequestMethod.GET)
	public String mentiRegisterGET(HttpSession session) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		return "/member/mentiRegister";
	}

	@RequestMapping(value = "/mentiRegister", method = RequestMethod.POST)
	public String mentiRegisterPOST(HttpSession session, UserVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		userService.mentiCreate(vo);

		return "redirect:/member/mentiList";
	}

	// 회원 정보 조회
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("userId") String userId, Model model) throws Exception {

		model.addAttribute("user", userService.read(userId));
	}

	// 회원 정보 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateGET(HttpSession session, @RequestParam("userId") String userId, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		model.addAttribute("user", userService.read(userId));

		return "/member/update";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(HttpSession session, UserVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		userService.update(vo);

		return "redirect:/member/read?userId=" + vo.getUserId();
	}

	// 회원 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deletePOST(HttpSession session, @RequestParam("userId") String userId,
			@RequestParam(value = "authority", required = false) String authority) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		userService.delete(userId);

		if ("M".equals(authority)) {
			return "redirect:/member/mentoList";
		}

		return "redirect:/member/mentiList";
	}

	// 아이디 중복 체크
	@ResponseBody
	@GetMapping("/id-check")
	public Map<String, Object> idCheck(@RequestParam("userId") String userId) {

		boolean available = userService.isUserIdAvailable(userId);

		Map<String, Object> result = new HashMap<>();
		result.put("available", available);

		return result;
	}

	// 회원 권한에 따라 목록으로 이동
	@RequestMapping(value = "/backToList", method = RequestMethod.GET)
	public String backToList(HttpSession session, @RequestParam("userId") String userId) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		UserVO targetUser = userService.read(userId);

		if ("M".equals(targetUser.getAuthority())) {
			return "redirect:/member/mentoList";
		}

		return "redirect:/member/mentiList";
	}
}