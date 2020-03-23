package com.dev.erp.document.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.document.model.service.DocumentService;
import com.dev.erp.document.model.vo.Document;
import com.dev.erp.document.model.vo.DocumentLine;
import com.dev.erp.member.controller.MemberController;
import com.dev.erp.member.model.vo.Member;

@Controller
public class DocumentController {

	private final static Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	DocumentService documentService;
	
	@RequestMapping("/document/documentView.do")
	public ModelAndView documentView(ModelAndView mav,  HttpSession session, 
			  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn) {
		try {
			String empName = Optional.ofNullable(memberLoggedIn).map(Member::getEmpName)
					 .orElseThrow(IllegalStateException::new);
			List<Document> docList = new ArrayList<>();
			docList = documentService.selectDocList(empName);
			mav.addObject("docList",docList);
			mav.setViewName("document/documentView");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/insertDocumentForm.do")
	public ModelAndView insertDocumentForm(ModelAndView mav) {
		try {
			List<Map<String,String>> list = new ArrayList<>();
			list=documentService.selectDocTypeAll();
			mav.addObject("docTypeList",list);
			mav.setViewName("/document/insertDocumentForm");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@PostMapping("/document/enrollDocument.do")
	public ModelAndView enrollDocument(ModelAndView mav, @RequestParam("documentDate")Date documentDate,
										@RequestParam("documentTitle") String documentTitle, @RequestParam("docLastapproval") String docLastapproval,
										@RequestParam("docLastapproval1") String docLastapproval1, @RequestParam("docLastapproval2") String docLastapproval2,
										@RequestParam("docLastapproval3") String docLastapproval3,
										@RequestParam("documentType") String documentType, @RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate,
										@RequestParam("documentContent") String documentContent, @RequestParam("empName") String empName,
										@RequestParam("email") String email) {
		try {
			int typeNo = 0;
			if(documentType.equals("기본")) {
				typeNo=0;
			}else if(documentType.equals("휴가신청서")) {
				typeNo=1;
			}else if(documentType.equals("지출결의서")) {
				typeNo=2;
			}
			if(endDate==null || startDate==null) {
				startDate = "null";
				endDate = "null";
			}
			String docLast="";
			int result=0;
			Document document = new Document();
			if(docLastapproval!=""&&docLastapproval1=="" &&docLastapproval2=="" &&docLastapproval3=="") {
				docLast=docLastapproval;
				document = new Document(0,typeNo,documentType,documentTitle,"진행중",empName,docLast,documentContent,documentDate,startDate,endDate,email);
				DocumentLine documentLine = new DocumentLine(0,0,typeNo,empName,docLast,"Y");
				DocumentLine documentLine1 = new DocumentLine(0,0,typeNo,docLast,null,"Y");
				result = documentService.insertDocument(document);
				int result2 = documentService.insertDocumentLine(documentLine);
				int result3 = documentService.insertDocumentLine(documentLine1);
			}
			if(docLastapproval!=""&&docLastapproval1!=""&&docLastapproval2==""&&docLastapproval3=="") {
				docLast=docLastapproval1;
				document = new Document(0,typeNo,documentType,documentTitle,"진행중",empName,docLast,documentContent,documentDate,startDate,endDate,email);
				DocumentLine documentLine0 = new DocumentLine(0,0,typeNo,empName,docLastapproval,"Y");
				DocumentLine documentLine1 = new DocumentLine(0,0,typeNo,docLastapproval,docLastapproval1,"Y");
				DocumentLine documentLine2 = new DocumentLine(0,0,typeNo,docLastapproval1,null,"Y");
				result = documentService.insertDocument(document);
				int result1 = documentService.insertDocumentLine(documentLine0);
				int result2 = documentService.insertDocumentLine(documentLine1);
				int result3 = documentService.insertDocumentLine(documentLine2);
			}
			if(docLastapproval!=""&&docLastapproval1!=""&&docLastapproval2!=""&&docLastapproval3=="") {
				docLast=docLastapproval2;
				document = new Document(0,typeNo,documentType,documentTitle,"진행중",empName,docLast,documentContent,documentDate,startDate,endDate,email);
				DocumentLine documentLine0 = new DocumentLine(0,0,typeNo,empName,docLastapproval,"Y");
				DocumentLine documentLine1 = new DocumentLine(0,0,typeNo,docLastapproval,docLastapproval1,"Y");
				DocumentLine documentLine2 = new DocumentLine(0,0,typeNo,docLastapproval1,docLastapproval2,"Y");
				DocumentLine documentLine3 = new DocumentLine(0,0,typeNo,docLastapproval2,null,"Y");
				result = documentService.insertDocument(document);
				int result2 = documentService.insertDocumentLine(documentLine0);
				int result3 = documentService.insertDocumentLine(documentLine1);
				int result4 = documentService.insertDocumentLine(documentLine2);
				int result5 = documentService.insertDocumentLine(documentLine3);
			}
			if(docLastapproval!=""&&docLastapproval1!=""&&docLastapproval2!=""&&docLastapproval3!="") {
				docLast=docLastapproval3;
				document = new Document(0,typeNo,documentType,documentTitle,"진행중",empName,docLast,documentContent,documentDate,startDate,endDate,email);
				DocumentLine documentLine0 = new DocumentLine(0,0,typeNo,empName,docLastapproval,"Y");
				DocumentLine documentLine1 = new DocumentLine(0,0,typeNo,docLastapproval,docLastapproval1,"Y");
				DocumentLine documentLine2 = new DocumentLine(0,0,typeNo,docLastapproval1,docLastapproval2,"Y");
				DocumentLine documentLine3 = new DocumentLine(0,0,typeNo,docLastapproval2,docLastapproval3,"Y");
				DocumentLine documentLine4 = new DocumentLine(0,0,typeNo,docLastapproval3,null,"Y");
				result = documentService.insertDocument(document);
				int result2 = documentService.insertDocumentLine(documentLine0);
				int result3 = documentService.insertDocumentLine(documentLine1);
				int result4 = documentService.insertDocumentLine(documentLine2);
				int result5 = documentService.insertDocumentLine(documentLine3);
				int result6 = documentService.insertDocumentLine(documentLine4);
			}
			
			String msg="";
			String loc="/";
			
			if(result>0) {
				msg="전송되었습니다.";
				loc="/document/documentView.do?empName="+empName;
				
			}
			mav.addObject("document",document);
			mav.addObject("msg",msg);
			mav.addObject("loc",loc);
			mav.setViewName("common/msg");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/documentSelectList.do")
	public ModelAndView documentSelectList(ModelAndView mav) {
		try {
			mav.setViewName("document/documentSelectList");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/documentListPage.do")
	@ResponseBody
	public Map<String,Object> documentListPage(@RequestParam(defaultValue="1") int cPage, HttpServletResponse rexsponse) {
		try {
			List<Map<String,String>> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			list = documentService.selectMemberList(cPage,numPerPage);  
			totalContents = documentService.selectAllCountByAccountNo(); 
			String url = "documentListPage.do?";
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("list",list);
			map.put("pageBar", pageBar);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/documentDetailView.do")
	public ModelAndView documentDetailView(ModelAndView mav, @RequestParam("docNo") int docNo,@RequestParam("empName")String empName) {
		try {
			Document document = new Document();
			List<DocumentLine> docLine = new ArrayList<>();
			Map<String,Object> map = new HashMap<>();
			Map<String,Object> map2 = new HashMap<>();
			map.put("docNo",docNo);
			map.put("empName",empName);
			DocumentLine prevWriter = new DocumentLine();
			DocumentLine nextWriter = new DocumentLine();
			document = documentService.documentDetailView(docNo);
			docLine = documentService.documentLineView(docNo);
			map2.put("docNo", docNo);
			map2.put("firstDoc", document.getDocWriter());
			DocumentLine documentLine1 = new DocumentLine();
			documentLine1=documentService.selectDocumentLine(map2);
			if(document.getDocWriter().equals(empName) || documentLine1.getNextWriter().equals(empName)) {
				prevWriter.setReturnYn("N");
				nextWriter.setNextWriter("next");
			}else {
				nextWriter=documentService.documentNextWriter(map);
				map.put("prevWriter", nextWriter.getPrevWriter());
				prevWriter=documentService.documentPrevWriter(map);
			}
	
			mav.addObject("list",document);
			mav.addObject("docLine",docLine);
			mav.addObject("prevWriter",prevWriter);
			mav.addObject("nextWriter",nextWriter);
			mav.setViewName("document/documentDetailView2");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/updateDocument.do")
	public ModelAndView updateDocument(ModelAndView mav, @RequestParam("docNo") int docNo, @RequestParam("empName") String empName, 
										@RequestParam("submitApprove") int submitApprove,@RequestParam("email") String email) {
		try {
			int result1=0;
			int result2=0;
			Map<String,Object> param = new HashMap<>();
			param.put("docNo",docNo);
			param.put("empName",empName);
			Document document = new Document();
			document = documentService.documentDetailView(docNo);
			if(submitApprove ==1) {
				result1 = documentService.approveDocument(param);
				if(document.getDocLastapproval().equals(empName)) {
					int result = documentService.updateDocument(docNo);
				}
			}else {
				result2=1;
				if(document.getDocLastapproval().equals(empName)) {
					int result = documentService.notUpdateDocument(docNo);
				}
			}
			String msg="";
			String loc="/document/documentView.do?empName="+empName;
			if(result1>0) {
				msg="결재가 승인되었습니다.";
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("common/msg");
			}
			if(result2>0) {
				msg="결재가 거절되었습니다.";
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("common/msg");
			}
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/document/goPrint.do")
	public void goPrint() {
		
	}
	
}
