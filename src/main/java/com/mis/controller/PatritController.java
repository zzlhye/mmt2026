package com.mis.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.domain.Criteria;
import com.mis.domain.PageMaker;
import com.mis.domain.PatritVO;
import com.mis.domain.UserVO;
import com.mis.dto.YearTermDTO;
import com.mis.service.PatritService;

@Controller
@RequestMapping("/patritBoard")
public class PatritController {

	@Inject
	private PatritService patritService;

	// 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(HttpSession session, @ModelAttribute("cri") Criteria cri, @RequestParam(value = "year", required = false) String year,
			@RequestParam(value = "term", required = false) String term, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/";
		}

		List<YearTermDTO> yearTermList = patritService.selectYearTermList();

		model.addAttribute("yearTermList", yearTermList);

		YearTermDTO latest = patritService.selectLatestYearTerm();

		// 연도/학기 미선택 시 최신값으로 설정
		if (year == null || year.trim().isEmpty() || term == null || term.trim().isEmpty()) {

			if (latest != null) {
				year = latest.getYear();
				term = latest.getTerm();
			}
		}

		model.addAttribute("year", year);
		model.addAttribute("term", term);

		List<PatritVO> list = patritService.selectPatritByYearTermMembersPaging(year, term, cri);

		model.addAttribute("list", list);

		int totalCount = patritService.countPatritByYearTermMembers(year, term);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("pageMaker", pageMaker);

		// 최신 학기 여부
		boolean isLatestTerm = latest != null && latest.getYear().equals(year) && latest.getTerm().equals(term);

		// 최신 팀 참여 여부
		PatritVO myTeam = patritService.selectMyTeamInfo(loginUser.getUserId());

		boolean hasTeam = myTeam != null && myTeam.getYear().equals(year) && myTeam.getTerm().equals(term);

		// 해당 학기 후기 작성 여부
		boolean hasMyPatrit = patritService.countMyPatritByYearTerm(loginUser.getUserId(), year, term) > 0;

		model.addAttribute("canWrite", isLatestTerm && hasTeam && !hasMyPatrit);

		return "/patritBoard/list";
	}

	// 등록
	@RequestMapping(value = "/registerAjax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> registerAjax(HttpSession session, PatritVO vo) throws Exception {

		Map<String, Object> result = new HashMap<>();

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			result.put("success", false);
			result.put("message", "로그인이 필요합니다.");
			return result;
		}

		if (vo.getContent() == null || vo.getContent().trim().isEmpty()) {
			result.put("success", false);
			result.put("message", "내용을 입력해 주세요.");
			return result;
		}

		PatritVO myInfo = patritService.selectMyTeamInfo(loginUser.getUserId());

		if (myInfo == null) {
			result.put("success", false);
			result.put("message", "팀 정보가 없습니다.");
			return result;
		}

		vo.setUserId(loginUser.getUserId());
		vo.setTeamNum(myInfo.getTeamNum());

		patritService.create(vo);

		result.put("success", true);

		return result;
	}

	// 수정
	@RequestMapping(value = "/updateAjax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateAjax(HttpSession session, @RequestParam("patritNum") int patritNum, @RequestParam("content") String content) {

		Map<String, Object> result = new HashMap<>();

		try {

			UserVO loginUser = (UserVO) session.getAttribute("loginUser");

			if (loginUser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다.");
				return result;
			}

			PatritVO patrit = patritService.read(patritNum);

			if (patrit == null) {
				result.put("success", false);
				result.put("message", "글이 존재하지 않습니다.");
				return result;
			}

			boolean isOwner = loginUser.getUserId().equals(patrit.getUserId());

			if (!isOwner) {
				result.put("success", false);
				result.put("message", "수정 권한이 없습니다.");
				return result;
			}

			PatritVO vo = new PatritVO();
			vo.setPatritNum(patritNum);
			vo.setContent(content);

			patritService.update(vo);

			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();

			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
		}

		return result;
	}

	// 삭제
	@RequestMapping(value = "/deleteAjax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAjax(HttpSession session, @RequestParam("patritNum") int patritNum) {

		Map<String, Object> result = new HashMap<>();

		try {

			UserVO loginUser = (UserVO) session.getAttribute("loginUser");

			if (loginUser == null) {
				result.put("success", false);
				result.put("message", "로그인이 필요합니다.");
				return result;
			}

			PatritVO patrit = patritService.read(patritNum);

			if (patrit == null) {
				result.put("success", false);
				result.put("message", "글이 존재하지 않습니다.");
				return result;
			}

			boolean isOwner = loginUser.getUserId().equals(patrit.getUserId());

			boolean isAdmin = "A".equals(loginUser.getAuthority());

			if (!isOwner && !isAdmin) {
				result.put("success", false);
				result.put("message", "삭제 권한이 없습니다.");
				return result;
			}

			patritService.delete(patritNum);

			result.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();

			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
		}

		return result;
	}
}