package com.psamall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.psamall.domain.CatetgoryVO;
import com.psamall.service.AdProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//관리자가 상품관리할 수 있는 기능 제공
@Controller
@Log4j
@RequestMapping("/admin/product/*")
public class AdProductController {

	//상품 등록을 위한 bean 주입
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private AdProductService adPService;
	
	//상품 등록 폼 + 1차 카테고리 불러오기
	@GetMapping("/addProduct")
	public void addProduct(Model model) {
		model.addAttribute("firstCateList", adPService.firstCateList());
	}
	//2차 카테고리 불러오기
	@ResponseBody
	@GetMapping("/secondCateList/{f_CategoryCode}")
	public ResponseEntity<List<CatetgoryVO>> secondCateList(@PathVariable("f_CategoryCode") Integer firstCategoryCode) {
		
		ResponseEntity<List<CatetgoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CatetgoryVO>>(adPService.secondCateList(firstCategoryCode), HttpStatus.OK);
		
		return entity;
	}
	
	//CKEditor를 통한 이미지 업로드 작업(상세설명에 사용하는 설명 이미지파일)
	@PostMapping("/imageUpload") //CKEdiotr의 환경설정 중 : filebrowserUploadUrl: '/admin/product/imageUpload’
	public void imageUpload(HttpServletRequest req, HttpServletResponse resp, MultipartFile upload) {
		//MultipartFile upload : <input type="file" name="upload">
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		//클라이언트의 브라우저에게 보내는 정보
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename();//클라이언트가 업로드한 원본 파일 명
			byte[] bytes = upload.getBytes();

			//서버측 업로드 폴더 - 프로젝트 외부 폴더
			String uploadPath = "C:\\Dev\\upload\\ckeditor\\";
			log.info("서버측 업로드 폴더(외부): " + uploadPath);
			
			uploadPath = uploadPath + fileName;
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			
			//CKEditor에 보낼 파일 정보
			printWriter = resp.getWriter();
			
			//클라이언트에서 요청할 이미지 주소 정보
			String fileUrl = "/upload/" + fileName;
			
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"} CKEditor 4.x  version에서 요구하는  json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
	}
	
	
	//상품 저장
}