package com.mis.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mis.domain.UserVO;
import com.mis.service.MentoringRelateService;

@Controller
@RequestMapping("/mentoring/relate")
public class MentoringRelateController {

	@Inject
	private MentoringRelateService mentoringRelateService;

	// 반응 등록 / 변경 / 취소
	@PostMapping("/toggle")
	@ResponseBody
	public Map<String, Object> toggle(@RequestParam int mentoringNum, @RequestParam String relateType, HttpSession session) throws Exception {

		Map<String, Object> res = new HashMap<>();

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || loginUser.getUserId() == null) {
			res.put("success", false);
			res.put("message", "login_required");
			return res;
		}

		String currentType = mentoringRelateService.toggle(mentoringNum, loginUser.getUserId(), relateType);

		res.put("success", true);
		res.put("currentType", currentType);
		res.put("total", mentoringRelateService.countAll(mentoringNum));

		res.put("countEmo1", mentoringRelateService.countEmo1(mentoringNum));
		res.put("countEmo2", mentoringRelateService.countEmo2(mentoringNum));
		res.put("countEmo3", mentoringRelateService.countEmo3(mentoringNum));
		res.put("countEmo4", mentoringRelateService.countEmo4(mentoringNum));
		res.put("countEmo5", mentoringRelateService.countEmo5(mentoringNum));
		res.put("countEmo6", mentoringRelateService.countEmo6(mentoringNum));
		res.put("countEmo7", mentoringRelateService.countEmo7(mentoringNum));

		return res;
	}
}