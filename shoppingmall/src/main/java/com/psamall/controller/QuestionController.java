 package com.psamall.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.psamall.domain.MemberVO;
import com.psamall.domain.QuestionFileVO;
import com.psamall.domain.QuestionVO;
import com.psamall.dto.Criteria;
import com.psamall.dto.PageDTO;
import com.psamall.service.QuestionService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/qna/*")
public class QuestionController {

	@javax.annotation.Resource(name = "uploadPath")
	private String uploadPath;

	@Setter(onMethod_ = @Autowired)
	private QuestionService questionService;

	// 질문 작성 폼
	@GetMapping("/userAddQuestion")
	public void userQuestion() {

	}

	// 질문 저장
	@PostMapping("/addQuestion")
	public String addQuestion(HttpSession session, QuestionVO vo,
			@RequestParam("uploadFile") MultipartFile[] uploadFile) {

		// 질문 저장
		String m_id = ((MemberVO) session.getAttribute("loginStatus")).getM_id();
		vo.setM_id(m_id);

		//파일 업로드
		String uploadDateFolderPath = UploadFileUtils.getFolder();

		File uploadpath = new File(uploadPath, uploadDateFolderPath);
		List<QuestionFileVO> attachList = new ArrayList<QuestionFileVO>();

		if (uploadpath.exists() == false) {
			// 경로의 폴더가 존재하지 않으면 폴더들 모두 생성
			uploadpath.mkdirs();
		}

		System.out.println(uploadFile);
		for (int i = 0; i < uploadFile.length; i++) {

			//System.out.println(uploadFile[i].getOriginalFilename());
			
			  if(!uploadFile[i].isEmpty()) { 
				  
				  vo.setQ_file_exist("Y");
				 
				  QuestionFileVO fileInfo = new QuestionFileVO();
				  fileInfo.setFileFolder(uploadDateFolderPath);
				  fileInfo.setFilename(UploadFileUtils.uploadFile(uploadPath, uploadDateFolderPath, uploadFile[i]));
				  
				  attachList.add(fileInfo); 
			  }
			 
		}

		vo.setAttachList(attachList);

		//log.info(attachList);
		//System.out.println(vo.getAttachList());

		//log.info("QuestionVO: " + vo);
		System.out.println("QuestionVO: " + vo);

		questionService.insertQuestion(vo);

		return "redirect:/user/qna/userQuestionList";
	}

	// 질문 리스트
	@GetMapping("/userQuestionList")
	public void userQuestionList(Model model, Criteria cri) {

		model.addAttribute("questionList", questionService.getQuestionList(cri));
		
		int total = questionService.getQuestionTotalCount(cri);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		
		model.addAttribute("pageMaker", pageDTO);
	}
	
	//질문상세 페이지 전 비밀번호 입력 페이지
	@GetMapping("/userQuestionCheck")
	public void userQuestionCheck(@ModelAttribute("q_num") Integer q_num) {
		
	}
	//질문 비밀번호 확인
	@PostMapping("/userQuestionCheck")
	public String userQuestionCheck(@RequestParam("q_num") Integer q_num, @RequestParam("q_password") String q_password, RedirectAttributes rttr) {
		
		String url = "";
		
		QuestionVO vo = questionService.getQuestionByQNum(q_num);
		String db_q_password = vo.getQ_password();
		
		log.info("데이터베이스 저장된 비밀번호: " + db_q_password);
		log.info("사용자가 입력한 비밀번호: " + q_password);
		
		if(q_password.equals(db_q_password)) {
			url = "/user/qna/userQuestionDetail?q_num=" + q_num;
		} else {
			url = "/user/qna/userQuestionCheck?q_num=" + q_num;
			rttr.addFlashAttribute("msg", "wrongPw");
		}
		
		return "redirect:" + url;
	}
	
	//질문 상세 페이지
	@GetMapping("/userQuestionDetail")
	public void userQuestionDetail(@RequestParam("q_num") Integer q_num, Model model) {
		
		//질문 테이블 정보
		model.addAttribute("questionVO", questionService.getQuestionByQNum(q_num));
		
		//파일 첨부 목록		
		model.addAttribute("fileInfo", questionService.getFileInfo(q_num));
		
	}
	
	//일반파일이 업로드 됐을 때 클릭하면 다운로드, a태그여서 getmapping
	//다운로드할 때 produces = {MediaType.APPLICATION_OCTET_STREAM_VALUE}
	//ResponseEntity<Resource> : Resource인터페이스 - org.springframework.core.io
	@GetMapping(value = "/download", produces = {MediaType.APPLICATION_OCTET_STREAM_VALUE})
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		//@RequestHeader("User-Agent") : 클라이언트가 사용하는 것이 브라우저인지, 기기인지 어떤종류의 브라우저, 무슨 기기 등의 정보
		
		ResponseEntity<Resource> entity = null;
		
		//FileSystemResource : 자원관리 해주는 클래스?;
		Resource resource = new FileSystemResource(uploadPath + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename(); //"C:\\Dev\\upload\\" + fileName
		
		//클라이언트가 보낸 파일명
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		// _(언더바) 뒤쪽에 오는 이름이 클라이언트가 업로드한 이름
		
		HttpHeaders headers = new HttpHeaders();
		
		String downloadName = null;
		
		try {
			
			downloadName = new String(resourceOriginalName.getBytes("utf-8"), "ISO-8859-1");
			//서버측의,,,,? 바이트 배열로 보내는거?
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			//Content-Disposition : 웹페이지 자체이거나 웹페이지의 일부인지, 아니면 attachment로써 다운로드 되거나 로컬에 저장될 용도록 쓰이는 것인지를 알려주는 헤더
			//웹페이지냐, 파일이냐를 알려주는거
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		
		entity = new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		return entity;
	}
}
