package com.mis.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.domain.MentoringVO;
import com.mis.domain.TeamMemberVO;
import com.mis.domain.TeamVO;
import com.mis.domain.UserVO;
import com.mis.domain.WeeklyVO;
import com.mis.dto.YearTermDTO;
import com.mis.service.MentoringRelateService;
import com.mis.service.MentoringService;
import com.mis.service.TeamService;
import com.mis.service.WeeklyService;

@Controller
@RequestMapping("/mentoring")
public class MentoringController {

	@Inject
	private MentoringService mentoringService;

	@Inject
	private WeeklyService weeklyService;

	@Inject
	private TeamService teamService;

	@Inject
	private MentoringRelateService mentoringRelateService;

	// 멘토링 대시보드
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(String year, String term, Model model, HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		// 연도/학기 목록
		model.addAttribute("yearTermList", mentoringService.getYearTermList());

		// 최초 진입 시 최신 연도/학기 선택
		if (year == null || term == null) {

			YearTermDTO latest = mentoringService.getLatestYearTerm();

			if (latest != null) {
				year = latest.getYear();
				term = latest.getTerm();
			}
		}

		List<TeamVO> teamList;

		// 관리자: 전체 팀 / 멘토·멘티: 소속 팀
		if ("A".equals(loginUser.getAuthority())) {
			teamList = mentoringService.getTeamsByYearTerm(year, term);
		} else {
			teamList = mentoringService.getMyTeamsByYearTerm(year, term, loginUser.getUserId());
		}

		model.addAttribute("selectedYear", year);
		model.addAttribute("selectedTerm", term);
		model.addAttribute("teamList", teamList);

		return "/mentoring/dashboard";
	}

	// 멘토링 목록
	@RequestMapping(value = "/mentoringList", method = RequestMethod.GET)
	public String mentoringList(@RequestParam("teamNum") int teamNum, Model model, HttpSession session)
			throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		List<WeeklyVO> weeklyList = weeklyService.teamWeeklyList(teamNum);

		List<MentoringVO> mentoringList = mentoringService.mentoringListByTeamWithThumb(teamNum);

		TeamVO team = teamService.read(teamNum);

		List<TeamMemberVO> teamMember = teamService.listMembers(teamNum);

		// 주차별 활동 가능 여부
		ZoneId zone = ZoneId.of("Asia/Seoul");
		LocalDate today = LocalDate.now(zone);

		for (WeeklyVO weekly : weeklyList) {

			if (weekly.getStartDate() == null || weekly.getEndDate() == null) {

				weekly.setOpen(false);
				continue;
			}

			LocalDate startDate = weekly.getStartDate().toInstant().atZone(zone).toLocalDate();

			LocalDate endDate = weekly.getEndDate().toInstant().atZone(zone).toLocalDate();

			weekly.setOpen(!today.isBefore(startDate) && !today.isAfter(endDate));
		}

		// 주차별 멘토링 게시글
		Map<Integer, List<MentoringVO>> mentoringByWeek = new LinkedHashMap<>();

		for (MentoringVO mentoring : mentoringList) {

			mentoringByWeek.computeIfAbsent(mentoring.getWeekName(), key -> new ArrayList<>()).add(mentoring);
		}

		// 댓글 / 반응 수
		Map<Integer, Integer> comtCountMap = new HashMap<>();
		Map<Integer, Integer> reactionCountMap = new HashMap<>();

		for (MentoringVO mentoring : mentoringList) {

			int mentoringNum = mentoring.getMentoringNum();

			comtCountMap.put(mentoringNum, mentoringService.countComt(mentoringNum));

			reactionCountMap.put(mentoringNum, mentoringRelateService.countAll(mentoringNum));
		}

		model.addAttribute("team", team);
		model.addAttribute("teamMember", teamMember);
		model.addAttribute("weeklyList", weeklyList);
		model.addAttribute("mentoringList", mentoringList);
		model.addAttribute("mentoringByWeek", mentoringByWeek);
		model.addAttribute("comtCountMap", comtCountMap);
		model.addAttribute("reactionCountMap", reactionCountMap);

		return "/mentoring/mentoringList";
	}

	// 등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session, Model model, MentoringVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		model.addAttribute("weekly", weeklyService.read(vo.getWeeklyNum()));

		model.addAttribute("team", teamService.read(vo.getTeamNum()));

		return "/mentoring/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(HttpSession session, MentoringVO vo) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		mentoringService.create(vo);

		return "redirect:/mentoring/mentoringList?teamNum=" + vo.getTeamNum();
	}

	// 조회
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(@RequestParam("mentoringNum") int mentoringNum, Model model, HttpSession session)
			throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		String userId = loginUser.getUserId();

		model.addAttribute("mentoring", mentoringService.read(mentoringNum));

		model.addAttribute("files", mentoringService.fileList(mentoringNum));

		model.addAttribute("countComt", mentoringService.countComt(mentoringNum));

		model.addAttribute("myReactionType", mentoringRelateService.getType(mentoringNum, userId));

		model.addAttribute("reactionTotal", mentoringRelateService.countAll(mentoringNum));

		model.addAttribute("countEmo1", mentoringRelateService.countEmo1(mentoringNum));

		model.addAttribute("countEmo2", mentoringRelateService.countEmo2(mentoringNum));

		model.addAttribute("countEmo3", mentoringRelateService.countEmo3(mentoringNum));

		model.addAttribute("countEmo4", mentoringRelateService.countEmo4(mentoringNum));

		model.addAttribute("countEmo5", mentoringRelateService.countEmo5(mentoringNum));

		model.addAttribute("countEmo6", mentoringRelateService.countEmo6(mentoringNum));

		model.addAttribute("countEmo7", mentoringRelateService.countEmo7(mentoringNum));

		return "/mentoring/read";
	}

	// 수정
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void update(@RequestParam("mentoringNum") int mentoringNum, Model model) throws Exception {

		MentoringVO mentoring = mentoringService.read(mentoringNum);

		model.addAttribute("mentoring", mentoring);

		model.addAttribute("weekly", weeklyService.read(mentoring.getWeeklyNum()));

		model.addAttribute("team", teamService.read(mentoring.getTeamNum()));

		model.addAttribute("files", mentoringService.fileList(mentoringNum));
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(MentoringVO vo) throws Exception {

		mentoringService.update(vo);

		return "redirect:/mentoring/read?mentoringNum=" + vo.getMentoringNum();
	}

	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("mentoringNum") int mentoringNum, @RequestParam("teamNum") int teamNum)
			throws Exception {

		mentoringService.delete(mentoringNum);

		return "redirect:/mentoring/mentoringList?teamNum=" + teamNum;
	}

	// 첨부파일 삭제
	@PostMapping(value = "/onlyFileDelete", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String onlyFileDelete(@RequestParam("fileNum") int fileNum) throws Exception {

		mentoringService.onlyFileDelete(fileNum);

		return "deleted";
	}
}