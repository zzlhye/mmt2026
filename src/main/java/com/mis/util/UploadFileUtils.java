package com.mis.util;

import org.springframework.http.MediaType;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

	// 파일 저장 경로(uploadPath), 원본 파일 이름(originalName), 파일 데이터(byte[] fileData) 3개의
	// 데이터를 파라미터로 전송받는 uploadFile()함수
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {

		// 1. UUID를 이용한 고유한 값 생성 (중복된 이름의 파일을 저장하지 않기 위해 UUID 키값 생성)
		UUID uid = UUID.randomUUID();

		// 2. UUID를 이용한 고유한 값_파일명 (실제 저장할 파일명 = UUID + _ + 원본파일명)
		String savedName = uid.toString() + "_" + originalName;

		// 3. 저장될 경로를 계산(날짜 경로 = 연 + 월 + 일)
		String savedPath = calcPath(uploadPath);

		// 4. 기본경로+폴더 경로+파일이름 (파일 객체 생성 = 기본 저장경로 + 날짜경로 + UUID_파일명
		File target = new File(uploadPath + savedPath, savedName);

		// 5. 원본파일을 저장하는 부분 (fileData를 파일객체에 복사)
		FileCopyUtils.copy(fileData, target);

		// formatName: 원본파일의 확장자를 의미한다.
		// --> 6.확장자를 이용해 이미지 파일인 경우와 아닌 경우를 나누어 처리 (파일 확장자 추출)
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);

		// 업로드 파일명 : 썸네일 이미지 파일명 or 일반 파일명
		String uploadedFileName = null;

		// 이미지 타입의 파일인 경우에는 썸네일을 생성하고 그렇지 않은 경우에는 makeIcon()을 통해서 만듬
		// 결과를 만들어 내는데 makeIcon은 경로 처리를 하는 문자열의 치환용도이다.
		// 확장자에 따라 썸네일 이미지 생성 or 일반 파일 아이콘 생성
		if (MediaUtils.getMediaType(formatName) != null) {
			// 썸네일 이미지 생성, 썸네일 이미지 파일명
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);

		} else {
			// 파일 아이콘 생성
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}

		// 업로드 파일명 반환
		return uploadedFileName;

	}

	// 아이콘 생성 : 이미지 파일이 아닐 경우
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {

		// 아이콘 파일명 = 기본 저장경로 + 날짜 경로 + 구분자 + 파일명
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	/**
	 * uploadPath: 기본경로 path: 년/월/일 폴더 fileName: 현재 업로드 된 파일의 이름
	 */
	// 썸네일 이미지를 생성하는 메소드( pom.xml에 imageScalr 라이브어리가 추가되었는지 확인) = 이미지 파일의 경우 썸네일 생성
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		// BufferedImage는 실제 이미지가 아닌 메모리상의 이미지
		// 원본파일을 메모리상으로 로딩하고 크기에 맞게 작은 이미지 파일에 원본 파일을 복사
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));

		// // 원본 이미지를 자동 품질로 높이 200 기준으로 비율 유지하며 리사이징
		// BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,
		// Scalr.Mode.FIT_TO_HEIGHT, 200);

		// 원본 이미지를 고품질(QUALITY) 방식으로 정확히 너비 200, 높이 290 크기로 강제 리사이징 (비율 무시)
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.QUALITY, Scalr.Mode.FIT_EXACT, 200, 290);

		// 저장되는 썸네일 이미지의 파일이름을 's_'로 시작하도록 함 (썸네일 이미지 파일명)
		// 's_' 를 제외하면 원본파일의 이름임
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;

		// 썸네일 이미지 파일 객체 생성
		File newFile = new File(thumbnailName);

		// 파일 확장자 추출
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		// 썸네일 파일 저장
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
		// 문자열을 치환하는 이유 : 브라우저에 윈도우의 경로로 사용하는 문자가 인식되지 않기 때문에 /로 치환
	}

	// 폴더 생성하는 기능이 필요하기 때문에 기본적인 경로uploadPath를 파라미터로 전달현재 시스템의 날짜에 맞는 테이터를 얻고 기본 경로와
	// 함께 makeDir()전달되어 폴더 생성
	// 날짜별 경로 추출
	private static String calcPath(String uploadPath) {

		Calendar cal = Calendar.getInstance();

		// 년
		String yearPath = File.separator + cal.get(Calendar.YEAR);

		// 년 + 월
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);

		// 년 + 월 + 일
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		// 파일 저장 경로 + 날짜 경로 생성
		makeDir(uploadPath, yearPath, monthPath, datePath);

		logger.info(datePath);

		// 날짜 경로 반환
		return datePath;
	}

	// 파일 저장 기본 경로 + 날짜 경로 생성
	private static void makeDir(String uploadPath, String... paths) {

		// 기본 경로 + 날짜 경로가 이미 존재 = 메서드 종료
		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}

		// 날짜 경로가 존재하지 않음 = 경로 생성을 위한 반복문 수행
		for (String path : paths) {
			// 기본 경로 + 날짜 경로에 해당하는 파일 객체 생성
			File dirPath = new File(uploadPath + path);

			// 파일 객체에 해당하는 경로가 존재하지 않음
			if (!dirPath.exists()) {
				// 경로 생성
				dirPath.mkdir();
			}
		}
	}

	// 파일 삭제처리 메서드
	public static void removeFile(String uploadPath, String fileName) {

		// 파일 확장자 추출
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		// 파일 확장자를 통해 이미지 파일인지 판별
		MediaType mediaType = MediaUtils.getMediaType(formatName);

		// 이미지 파일인 경우, 원본파일 삭제
		if (mediaType != null) {
			// 원본 이미지의 경로 + 파일명 추출
			// 날짜 경로 추출
			String front = fileName.substring(0, 12);

			// UUID + 파일명 추출
			String end = fileName.substring(14);

			// 원본 이미지 파일 삭제 (구분자 변환)
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}

		// 파일 삭제(일반 파일 or 썸네일 이미지 파일 삭제)
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
	}

}