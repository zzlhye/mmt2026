package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.NoticeFileVO;
import com.mis.domain.NoticeVO;
import com.mis.domain.SearchCriteria;
import com.mis.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO noticeDao;

	@Override
	public void create(NoticeVO vo) throws Exception {

		// TextArea 줄바꿈 처리
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		// 게시글 등록
		noticeDao.create(vo);

		// 기본키 받아오기
		int noticeNum = vo.getNoticeNum();

		// 첨부파일 등록
		// 첨부파일 존재 여부 확인 (파일 업로드 했을 경우에만 실행, 업로드된 파일이 없다면 실행 안 함)
		if (vo.getFiles() != null) {

			// 다중 첨부파일 저장
			for (int i = 0; i < vo.getFiles().length; i++) {

				NoticeFileVO fVo = new NoticeFileVO();
				fVo.setNoticeNum(noticeNum); // 게시글 기본키
				fVo.setFileName(vo.getFiles()[i]); // 업로드된 첨부파일명 + 경로

				noticeDao.insertFile(fVo);
			}
		}
	}

	@Override
	public NoticeVO read(int noticeNum) throws Exception {

		// 조회수 업데이트
		noticeDao.viewCount(noticeNum);

		// 게시글 조회
		return noticeDao.read(noticeNum);
	}

	@Override
	public void update(NoticeVO vo) throws Exception {
		// TextArea 줄바꿈 처리
		vo.setContent(vo.getContent().replace("\\r\\n", "<br>"));

		// 게시글 수정
		noticeDao.update(vo);

		// 소속된 첨부파일 삭제
		// dao.deleteFile(vo.getNoticeNum());

		// 첨부파일 등록
		// 첨부파일 존재 여부 확인 (파일 업로드 했을 경우에만 실행, 업로드된 파일이 없다면 실행 안 함)
		if (vo.getFiles() != null) {

			// 다중 첨부파일 저장
			for (int i = 0; i < vo.getFiles().length; i++) {

				NoticeFileVO fVo = new NoticeFileVO();
				fVo.setNoticeNum(vo.getNoticeNum()); // 게시글 기본키
				fVo.setFileName(vo.getFiles()[i]); // 업로드된 첨부파일명

				noticeDao.insertFile(fVo);
			}
		}

	}

	@Override
	public void delete(int noticeNum) throws Exception {
		// 첨부파일 삭제
		noticeDao.deleteFile(noticeNum);

		// 게시글 삭제
		noticeDao.delete(noticeNum);
	}

	@Override
	public void onlyFileDelete(int fileNum) throws Exception {
		noticeDao.onlyFileDelete(fileNum);

	}

	@Override
	public List<NoticeFileVO> fileList(int noticeNum) throws Exception {
		return noticeDao.fileList(noticeNum);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return noticeDao.listSearchCount(cri);
	}

	@Override
	public List<NoticeVO> listSearch(SearchCriteria cri) throws Exception {
		return noticeDao.listSearch(cri);
	}

}
