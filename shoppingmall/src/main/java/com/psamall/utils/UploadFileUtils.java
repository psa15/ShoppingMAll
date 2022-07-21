package com.psamall.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

//파일 업로드 관련 기능
public class UploadFileUtils {

	/* 
	1. 파일 업로드 작업
	2. 업로드시 날짜 폴더생성해서 파일 관리
	3. 썸네일 이미지 생성
	4. byte[] 배열로 다운로드
	 */
	
	/* 1. 파일 업로드 작업 */
	public static String uploadFile(String uploadFolder, String uploadDateFolderPath, MultipartFile uploadFile) {
		
		//실제로 업로드 한 파일명이 들어갈 변수
		String uploadFileName = "";
		
		//날짜 폴더 생성		
		File uploadPath = new File(uploadFolder, uploadDateFolderPath);
		
		//경로에 해당하는 폴더가 없으면 다 생성
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		//클라이언트에서 업로드한 파일 이름
		String uploadClientFileName = uploadFile.getOriginalFilename();
		
		//중복되지 않는 고유의 문자열 생성
		UUID uuid = UUID.randomUUID();		
		//서버에 업로드할 때 중복되지 않는 파일이름을 생성 -> 리턴시켜 db에 저장
		uploadFileName = uuid.toString() + "_" + uploadClientFileName;
		
		try {
			//유일한 파일 이름으로 객체 생성
			File saveFile = new File(uploadPath, uploadFileName);
			
			//파일 업로드
			uploadFile.transferTo(saveFile);
			
			/* 3. 썸네일 이미지 생성 */
			if(checkImageType(saveFile)) {
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return uploadFileName;
	}
	
	/* 2. 업로드시 날짜 폴더생성 */
	public static String getFolder() {
			
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//현재 시스템의 날짜
		Date date = new Date();
		
		String str = sdf.format(date); //"2022-6-29" 저장됨
		
		return str.replace("-", File.separator); // "2022-06-29" -> "2022\06\29"
	}
	//이미지 파일여부를 체크
	private static boolean checkImageType(File saveFile) {
		
		boolean isImage = false;
		
		try {
			String contentType = Files.probeContentType(saveFile.toPath());
			//contentType : 현재 업로드 된 파일의 정보가 들어감 ( text/html, text/plain, image 등)
			
			isImage = contentType.startsWith("image");
			//contentType.startsWith("image") : image로 시작하면 true 반환
			
		} catch (IOException e) {
			e.printStackTrace();
		}
				
		return isImage; 
	}
	
	//이미지를 바이트배열로 불러오기 (상품목록)
	public static ResponseEntity<byte[]> getImageFile(String uploadPath, String fileName) {
		
		File file = new File(uploadPath, fileName);
		
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			//브라우저에게 보낼 데이터의 MIME 정보
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//파일 삭제
	public static void deleteFile(String uploadPath, String fileName) {
		
		//fileName을 썸네일 이미지로 가져와서 원본 이미지로 만들기
		String front = fileName.substring(0, 11); //fileName에 속해있는 uploadPath 분리
		String end = fileName.substring(13);
		String originFile = front + end; //원본 이미지 파일
		
		//원본 이미지 삭제
		new File(uploadPath + originFile.replace("/", File.separator)).delete();
		//썸네일 이미지 삭제
		new File(uploadPath + fileName.replace("/", File.separator)).delete();
	}
}
