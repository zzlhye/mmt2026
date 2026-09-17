package com.mis.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mis.domain.MentoringComtVO;
import com.mis.service.MentoringComtService;

@RestController
@RequestMapping("/mentoringComt")
public class MentoringComtController {

	@Inject
	private MentoringComtService service;

	// 댓글 등록
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody MentoringComtVO vo) {

		try {
			service.create(vo);

			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();

			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

	// 댓글 목록
	@RequestMapping(value = "/all/{mentoringNum}", method = RequestMethod.GET)
	public ResponseEntity<List<MentoringComtVO>> list(@PathVariable("mentoringNum") int mentoringNum) {

		try {
			List<MentoringComtVO> list = service.list(mentoringNum);

			return new ResponseEntity<List<MentoringComtVO>>(list, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();

			return new ResponseEntity<List<MentoringComtVO>>(HttpStatus.BAD_REQUEST);
		}
	}

	// 댓글 삭제
	@RequestMapping(value = "/{comtNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("comtNum") int comtNum) {

		try {
			service.delete(comtNum);

			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();

			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}

}