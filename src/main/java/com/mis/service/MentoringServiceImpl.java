package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.MentoringFileVO;
import com.mis.domain.MentoringVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;
import com.mis.persistence.MentoringComtDAO;
import com.mis.persistence.MentoringDAO;
import com.mis.persistence.MentoringRelateDAO;

@Service
public class MentoringServiceImpl implements MentoringService {

	@Inject
	private MentoringDAO mentoringDao;

	@Inject
	private MentoringRelateDAO relateDao;

	@Inject
	private MentoringComtDAO comtDao;

	// 등록
	@Override
	public void create(MentoringVO vo) throws Exception {

		// 줄바꿈 처리
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		mentoringDao.create(vo);

		// 첨부파일 등록
		if (vo.getFiles() != null) {

			for (String fileName : vo.getFiles()) {

				MentoringFileVO file = new MentoringFileVO();
				file.setMentoringNum(vo.getMentoringNum());
				file.setFileName(fileName);

				mentoringDao.insertFile(file);
			}
		}
	}

	// 조회
	@Override
	public MentoringVO read(int mentoringNum) throws Exception {

		mentoringDao.viewCount(mentoringNum);

		return mentoringDao.read(mentoringNum);
	}

	// 수정
	@Override
	public void update(MentoringVO vo) throws Exception {

		// 줄바꿈 처리
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		mentoringDao.update(vo);

		// 새 첨부파일 등록
		if (vo.getFiles() != null) {

			for (String fileName : vo.getFiles()) {

				MentoringFileVO file = new MentoringFileVO();
				file.setMentoringNum(vo.getMentoringNum());
				file.setFileName(fileName);

				mentoringDao.insertFile(file);
			}
		}
	}

	// 삭제
	@Override
	public void delete(int mentoringNum) throws Exception {

		mentoringRelateDelete(mentoringNum);
		comtDao.deleteAll(mentoringNum);
		mentoringDao.deleteFile(mentoringNum);
		mentoringDao.delete(mentoringNum);
	}

	private void mentoringRelateDelete(int mentoringNum) throws Exception {
		relateDao.deleteAll(mentoringNum);
	}

	// 첨부파일 삭제
	@Override
	public void onlyFileDelete(int fileNum) throws Exception {
		mentoringDao.onlyFileDelete(fileNum);
	}

	// 첨부파일 목록
	@Override
	public List<MentoringFileVO> fileList(int mentoringNum) throws Exception {
		return mentoringDao.fileList(mentoringNum);
	}

	// 최신 연도/학기
	@Override
	public YearTermDTO getLatestYearTerm() throws Exception {
		return mentoringDao.selectLatestYearTerm();
	}

	// 연도/학기 목록
	@Override
	public List<YearTermDTO> getYearTermList() throws Exception {
		return mentoringDao.selectYearTermList();
	}

	// 관리자용 팀 목록
	@Override
	public List<TeamVO> getTeamsByYearTerm(String year, String term) throws Exception {

		return mentoringDao.selectTeamsByYearTerm(year, term);
	}

	// 멘토/멘티용 소속 팀 목록
	@Override
	public List<TeamVO> getMyTeamsByYearTerm(String year, String term, String userId) throws Exception {

		return mentoringDao.selectMyTeamsByYearTerm(year, term, userId);
	}

	// 팀별 멘토링 게시글
	@Override
	public List<MentoringVO> mentoringListByTeamWithThumb(int teamNum) throws Exception {

		return mentoringDao.listByTeamWithThumb(teamNum);
	}

	// 댓글 수
	@Override
	public int countComt(int mentoringNum) throws Exception {
		return mentoringDao.countComt(mentoringNum);
	}
}