package com.mis.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.domain.NoticeVO;
import com.mis.domain.PageMaker;
import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Inject
	private NoticeService noticeService;

	// 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(HttpSession session, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		// 로그인 안 한 상태면 로그인 페이지로 이동
		if (loginUser == null) {
			return "redirect:/";
		}

		// 선택된 페이지의 게시글 정보 가져오기 10개
		model.addAttribute("list", noticeService.listSearch(cri));

		// 페이징 네비게이션이 추가
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noticeService.listSearchCount(cri));

		// 페이징 정보 화면 전달
		model.addAttribute("pageMaker", pageMaker);

		return "/notice/list";

	}

	// 등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		// 로그인 안 한 상태면 로그인 페이지로 이동
		if (loginUser == null) {
			return "redirect:/";
		}

		return "/notice/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(HttpSession session, NoticeVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		vo.setUserId(loginUser.getUserId());

		noticeService.create(vo);

		return "redirect:/notice/list";
	}

	// 조회
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("noticeNum") int noticeNum, Model model) throws Exception {

		// 게시글
		model.addAttribute("notice", noticeService.read(noticeNum));

		// 첨부파일
		model.addAttribute("files", noticeService.fileList(noticeNum));
	}

	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void update(@RequestParam("noticeNum") int noticeNum, Model model) throws Exception {

		model.addAttribute("notice", noticeService.read(noticeNum));

		// 첨부파일
		model.addAttribute("files", noticeService.fileList(noticeNum));
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(NoticeVO vo) throws Exception {

		noticeService.update(vo);

		return "redirect:/notice/read?noticeNum=" + vo.getNoticeNum();
	}

	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("noticeNum") int noticeNum) throws Exception {

		noticeService.delete(noticeNum);

		return "redirect:/notice/list";
	}

	// 첨부파일 삭제
	@PostMapping(value = "/onlyFileDelete", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String onlyFileDelete(@RequestParam("fileNum") int fileNum) throws Exception {
		noticeService.onlyFileDelete(fileNum);
		return "deleted";
	}

}
