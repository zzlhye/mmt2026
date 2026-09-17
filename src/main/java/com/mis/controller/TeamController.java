package com.mis.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mis.domain.PageMaker;
import com.mis.domain.SearchCriteria;
import com.mis.domain.TeamVO;
import com.mis.domain.UserVO;
import com.mis.dto.YearTermDTO;
import com.mis.service.TeamService;
import com.mis.service.UserService;

@Controller
@RequestMapping("/team")
public class TeamController {

	@Inject
	private TeamService teamService;

	@Inject
	private UserService userService;

	// 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(HttpSession session, @ModelAttribute("cri") SearchCriteria cri,
			@RequestParam(value = "year", required = false) String year,
			@RequestParam(value = "term", required = false) String term, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		// 연도/학기 목록
		List<YearTermDTO> yearTermList = teamService.selectYearTermList();
		model.addAttribute("yearTermList", yearTermList);

		// 최초 진입 시 최신 연도/학기 선택
		if (year == null || year.trim().isEmpty() || term == null || term.trim().isEmpty()) {

			YearTermDTO latest = teamService.selectLatestYearTerm();

			if (latest != null) {
				year = latest.getYear();
				term = latest.getTerm();
			}
		}

		cri.setYear(year);
		cri.setTerm(term);

		model.addAttribute("year", year);
		model.addAttribute("term", term);

		// 목록
		model.addAttribute("list", teamService.listSearch(cri));

		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(teamService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/team/list";
	}

	// 등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		return "/team/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(HttpSession session, TeamVO vo, @RequestParam("mentoId") String mentorId,
			@RequestParam(value = "mentiId", required = false) List<String> menteeIds) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		teamService.registerTeam(vo, mentorId, menteeIds);

		return "redirect:/team/list";
	}

	// 조회
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(@RequestParam("teamNum") int teamNum, Model model) throws Exception {

		model.addAttribute("team", teamService.read(teamNum));
		model.addAttribute("teamMember", teamService.listMembers(teamNum));

		return "/team/read";
	}

	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(@RequestParam("teamNum") int teamNum, Model model) throws Exception {

		model.addAttribute("team", teamService.read(teamNum));
		model.addAttribute("teamMember", teamService.listMembers(teamNum));

		return "/team/update";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(TeamVO vo, @RequestParam("mentoId") String mentorId,
			@RequestParam(value = "mentiId", required = false) List<String> menteeIds) throws Exception {

		teamService.updateTeam(vo, mentorId, menteeIds);

		return "redirect:/team/read?teamNum=" + vo.getTeamNum();
	}

	// 멘토링 목록에서 팀 소개 수정
	@RequestMapping(value = "/teamUpdate", method = RequestMethod.POST)
	public String teamUpdatePOST(TeamVO vo) throws Exception {

		teamService.update(vo);

		return "redirect:/mentoring/mentoringList?teamNum=" + vo.getTeamNum();
	}

	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("teamNum") int teamNum) throws Exception {

		teamService.delete(teamNum);

		return "redirect:/team/list";
	}

	// 멘토 목록
	@RequestMapping(value = "/mentoList", method = RequestMethod.GET)
	public String mentoList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		cri.setAuthority("M");

		model.addAttribute("list", userService.listSearch(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(userService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/team/mentoList";
	}

	// 멘티 목록
	@RequestMapping(value = "/mentiList", method = RequestMethod.GET)
	public String mentiList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		cri.setAuthority("S");

		model.addAttribute("list", userService.listSearch(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(userService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "/team/mentiList";
	}
}