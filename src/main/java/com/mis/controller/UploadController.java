package com.mis.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mis.util.MediaUtils;
import com.mis.util.UploadFileUtils;

@Controller
public class UploadController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Resource
	private ServletContext servletContext;

	// 업로드 화면
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.GET)
	public void uploadAjax() {
	}

	// 파일 업로드
	@ResponseBody
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {

		logger.info("originalName: " + file.getOriginalFilename());

		return new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()),
				HttpStatus.CREATED);
	}

	// 파일 표시
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName,
			@RequestParam(value = "type", required = false) String type) throws Exception {

		InputStream in = null;

		logger.info("fileName: " + fileName + ", type=" + type);

		try {

			String decodedName = URLDecoder.decode(fileName, "UTF-8");

			// 경로 조작 방지
			if (decodedName.contains("..") || decodedName.contains("../") || decodedName.contains("..\\")) {

				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}

			File target = new File(uploadPath + File.separator + decodedName);

			// 이미지 요청인데 파일이 없는 경우 기본 이미지
			if ("image".equals(type) && !target.exists()) {
				return defaultImageEntity();
			}

			in = new FileInputStream(target);

			String formatName = decodedName.substring(decodedName.lastIndexOf(".") + 1).toLowerCase();

			HttpHeaders headers = new HttpHeaders();

			// 이미지
			MediaType mType = MediaUtils.getMediaType(formatName);

			if (mType != null) {

				if ("image".equals(type)) {

					boolean realImage = isRealImage(target);

					if (!realImage) {
						return defaultImageEntity();
					}
				}

				headers.setContentType(mType);

				return new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			}

			// 영상
			if ("mp4".equals(formatName)) {

				headers.setContentType(MediaType.valueOf("video/mp4"));

			} else if ("webm".equals(formatName)) {

				headers.setContentType(MediaType.valueOf("video/webm"));

			} else if ("ogg".equals(formatName) || "ogv".equals(formatName)) {

				headers.setContentType(MediaType.valueOf("video/ogg"));

			} else if ("mov".equals(formatName)) {

				headers.setContentType(MediaType.valueOf("video/quicktime"));

			} else if ("m4v".equals(formatName)) {

				headers.setContentType(MediaType.valueOf("video/x-m4v"));

			} else {

				// 일반 파일 다운로드
				String originalName = decodedName.substring(decodedName.indexOf("_") + 1);

				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(originalName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}

			return new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.OK);

		} catch (Exception e) {

			e.printStackTrace();

			if ("image".equals(type)) {
				return defaultImageEntity();
			}

			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

		} finally {

			if (in != null) {

				try {
					in.close();
				} catch (Exception ignore) {
				}
			}
		}
	}

	// 영상 재생
	@RequestMapping(value = "/displayVideo", method = RequestMethod.GET)
	public void displayVideo(@RequestParam("fileName") String fileName, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String decodedName = URLDecoder.decode(fileName, "UTF-8");

		logger.info("video fileName: " + decodedName);

		// 경로 조작 방지
		if (decodedName.contains("..") || decodedName.contains("../") || decodedName.contains("..\\")) {

			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		File target = new File(uploadPath + File.separator + decodedName);

		if (!target.exists() || !target.isFile()) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		long fileLength = target.length();

		String range = request.getHeader("Range");

		long start = 0;
		long end = fileLength - 1;

		// Range 요청 처리
		if (range != null && range.startsWith("bytes=")) {

			String rangeValue = range.substring(6);

			// 여러 Range 요청이 들어와도 첫 번째 범위만 처리
			if (rangeValue.contains(",")) {
				rangeValue = rangeValue.split(",")[0];
			}

			String[] ranges = rangeValue.split("-", 2);

			try {

				if (!ranges[0].isEmpty()) {
					start = Long.parseLong(ranges[0]);
				}

				if (ranges.length > 1 && !ranges[1].isEmpty()) {
					end = Long.parseLong(ranges[1]);
				}

			} catch (NumberFormatException e) {
				response.setStatus(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
				return;
			}

			if (start < 0 || start >= fileLength || end < start) {

				response.setHeader("Content-Range", "bytes */" + fileLength);

				response.setStatus(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);

				return;
			}

			if (end >= fileLength) {
				end = fileLength - 1;
			}

			response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);

			response.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + fileLength);

		} else {

			response.setStatus(HttpServletResponse.SC_OK);
		}

		long contentLength = end - start + 1;

		response.setHeader("Accept-Ranges", "bytes");

		response.setHeader("Content-Length", String.valueOf(contentLength));

		// 영상 Content-Type
		String formatName = decodedName.substring(decodedName.lastIndexOf(".") + 1).toLowerCase();

		if ("mp4".equals(formatName)) {

			response.setContentType("video/mp4");

		} else if ("webm".equals(formatName)) {

			response.setContentType("video/webm");

		} else if ("ogg".equals(formatName) || "ogv".equals(formatName)) {

			response.setContentType("video/ogg");

		} else if ("mov".equals(formatName)) {

			response.setContentType("video/quicktime");

		} else if ("m4v".equals(formatName)) {

			response.setContentType("video/x-m4v");

		} else {

			response.setStatus(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);

			return;
		}

		RandomAccessFile randomAccessFile = null;

		try {

			randomAccessFile = new RandomAccessFile(target, "r");

			randomAccessFile.seek(start);

			OutputStream out = response.getOutputStream();

			byte[] buffer = new byte[8192];

			long remaining = contentLength;

			while (remaining > 0) {

				int read = randomAccessFile.read(buffer, 0, (int) Math.min(buffer.length, remaining));

				if (read == -1) {
					break;
				}

				out.write(buffer, 0, read);

				remaining -= read;
			}

			out.flush();

		} finally {

			if (randomAccessFile != null) {
				randomAccessFile.close();
			}
		}
	}

	// 실제 이미지인지 확인
	private boolean isRealImage(File file) {

		try {

			return ImageIO.read(file) != null;

		} catch (Exception e) {

			return false;
		}
	}

	// 기본 이미지 반환
	private ResponseEntity<byte[]> defaultImageEntity() throws IOException {

		String defaultPath = servletContext.getRealPath("/resources/img.png");

		if (defaultPath == null) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		File defaultFile = new File(defaultPath);

		if (!defaultFile.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		byte[] data = java.nio.file.Files.readAllBytes(defaultFile.toPath());

		HttpHeaders headers = new HttpHeaders();

		headers.setContentType(MediaType.IMAGE_PNG);

		return new ResponseEntity<>(data, headers, HttpStatus.OK);
	}

	// 업로드된 파일 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("delete file: " + fileName);

		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		MediaType mType = MediaUtils.getMediaType(formatName);

		if (mType != null) {

			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);

			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}

		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();

		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}
}