package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.PreTrainingFileVO;
import com.mis.domain.PreTrainingVO;
import com.mis.domain.SearchCriteria;
import com.mis.persistence.PreTrainingDAO;

@Service
public class PreTrainingServiceImpl implements PreTrainingService {

	@Inject
	private PreTrainingDAO preDao;

	@Override
	public void create(PreTrainingVO vo) throws Exception {
		// TextArea 줄바꿈 처리
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		// 게시글 등록
		preDao.create(vo);

		// 기본키 받아오기
		int preNum = vo.getPreNum();

		// 첨부파일 등록
		// 첨부파일 존재 여부 확인 (파일 업로드 했을 경우에만 실행, 업로드된 파일이 없다면 실행 안 함)
		if (vo.getFiles() != null) {

			// 다중 첨부파일 저장
			for (int i = 0; i < vo.getFiles().length; i++) {

				PreTrainingFileVO fVo = new PreTrainingFileVO();
				fVo.setPreNum(preNum); // 게시글 기본키
				fVo.setFileName(vo.getFiles()[i]); // 업로드된 첨부파일명 + 경로

				preDao.insertFile(fVo);
			}
		}
	}

	@Override
	public PreTrainingVO read(int preNum) throws Exception {

		preDao.viewCount(preNum);
		return preDao.read(preNum);

	}

	@Override
	public void update(PreTrainingVO vo) throws Exception {
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		// 게시글 수정
		preDao.update(vo);

		// 소속된 첨부파일 삭제
		// dao.deleteFile(vo.getNoticeNum());

		// 첨부파일 등록
		// 첨부파일 존재 여부 확인 (파일 업로드 했을 경우에만 실행, 업로드된 파일이 없다면 실행 안 함)
		if (vo.getFiles() != null) {

			// 다중 첨부파일 저장
			for (int i = 0; i < vo.getFiles().length; i++) {

				PreTrainingFileVO fVo = new PreTrainingFileVO();
				fVo.setPreNum(vo.getPreNum()); // 게시글 기본키
				fVo.setFileName(vo.getFiles()[i]); // 업로드된 첨부파일명

				preDao.insertFile(fVo);
			}
		}

	}

	@Override
	public void delete(int preNum) throws Exception {
		// 첨부파일 삭제
		preDao.deleteFile(preNum);

		// 게시글 삭제
		preDao.delete(preNum);
	}

	@Override
	public void onlyFileDelete(int fileNum) throws Exception {
		preDao.onlyFileDelete(fileNum);

	}

	@Override
	public List<PreTrainingFileVO> fileList(int preNum) throws Exception {
		return preDao.fileList(preNum);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return preDao.listSearchCount(cri);
	}

	@Override
	public List<PreTrainingVO> listSearch(SearchCriteria cri) throws Exception {
		return preDao.listSearch(cri);
	}

}
