package com.mis.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	// MediaUtils 확장자를 가지고 이미지 타입인지 판단해주는 역할
	// 별도의 클래스로 구성한 이유: 브라우저에서 파일을 다운로드할 것 인지 보여줄 것인지 결정하기 위해

	private static Map<String, MediaType> mediaMap;

	// mediaMap에 이미지 확장자명에 따른 MIME Type 저장 (MIME Type = 파일의 종류를 알려주는 문자열) 
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}

	public static MediaType getMediaType(String fileName) { 
		// 이미지 MIME Type 꺼내서 반환, 이미지 파일이 아닌 경우 null 반환 
		return mediaMap.get(fileName.toUpperCase());
	}
	
	 // 파일 확장자 추출
	public static String getFormatName(String fileName) {
        return fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
    }
}
