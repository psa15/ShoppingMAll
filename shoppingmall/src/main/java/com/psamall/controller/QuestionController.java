package com.psamall.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.psamall.domain.MemberVO;
import com.psamall.domain.QuestionFileVO;
import com.psamall.domain.QuestionVO;
import com.psamall.service.QuestionService;
import com.psamall.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/qna/*")
public class QuestionController {

	@Resource(name = "uploadPath")
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

		String uploadDateFolderPath = UploadFileUtils.getFolder();

		File uploadpath = new File(uploadPath, uploadDateFolderPath);
		List<QuestionFileVO> attachList = new ArrayList<QuestionFileVO>();

		if (uploadpath.exists() == false) {
			// 경로의 폴더가 존재하지 않으면 폴더들 모두 생성
			uploadpath.mkdirs();
		}

		for (int i = 0; i < uploadFile.length; i++) {

			//System.out.println(uploadFile[i].getOriginalFilename());
			
			  if(!uploadFile[i].isEmpty()) { 
				  UUID uuid = UUID.randomUUID();
				  QuestionFileVO fileInfo = new QuestionFileVO(uuid.toString(),
				  uploadpath.toString(), uploadFile[i].getOriginalFilename());
				  
				  attachList.add(fileInfo); 
			  }
			 
		}

		vo.setAttachList(attachList);

		log.info(attachList);
		System.out.println(vo.getAttachList());

		log.info("QuestionVO: " + vo);
		System.out.println("QuestionVO: " + vo);

		questionService.insertQuestion(vo);

		return "redirect:/user/qna/userQuestionList";
	}

	// 질문 리스트
	@GetMapping("/userQuestionList")
	public void userQuestionList() {

	}
}
