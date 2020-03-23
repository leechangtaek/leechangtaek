package com.dev.erp.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.member.model.exception.MemberException;
import com.dev.erp.member.model.service.MemberService;
import com.dev.erp.member.model.vo.Member;

@SessionAttributes(value= {"memberLoggedIn","dept_title","job_name"})
@Controller
public class MemberController {

	private final static Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@PostMapping("/member/memberEnrollEnd.do")
	public ModelAndView memberEnrollEnd(ModelAndView mav, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("emp_name") String emp_name,
			@RequestParam("dept_code") String dept_code, @RequestParam("job_code") String job_code,@RequestParam("ssn1") String ssn1,
			@RequestParam("ssn2") String ssn2,@RequestParam("phone") String phone
			) {
		try {
			Member member = new Member(0,emp_name,(ssn1+"-"+ssn2),email,phone,dept_code,job_code,null,null,"N",password,"profile.png");
			String rawPassword=member.getPassword();
			String encryptedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			int result =memberService.insertMember(member);
				
			String msg="";
			String loc="/member/memberEnroll.do";
			if(result>0) {
				msg="회원추가성공!";
			}
			mav.addObject("loc",loc);
			mav.addObject("msg",msg);
			
			mav.setViewName("common/msg");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/member/memberEnroll.do")
	public ModelAndView memberEnroll(ModelAndView mav) {
		try {
			List<Map<String,String>> deptList = memberService.selectDeptList();
			List<Map<String,String>> jobList = memberService.selectJobList();
			
			mav.addObject("dept",deptList);
			mav.addObject("job",jobList);
			mav.setViewName("member/memberEnroll");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberEmailDuplicatedCheck.do")
	@ResponseBody
	public Map<String,Object> memberEmailDuplicatedCheck(@RequestParam("email") String email, HttpServletResponse response) {
		try {
			Map<String, Object> map = new HashMap<>();
			List<Member> emailList = memberService.memberSelectList();
			int result=0;
			for(int i=0; i<emailList.size(); i++) {
				if(email.equals(emailList.get(i).getEmail())) {
					result =1;//기존의 값과 일치하는경우
				}else {
					result=0; //아닌경우
				}
			}
			map.put("email", email);
			
			boolean isUsable = memberService.selectOneMember(email)==null?true:false;//기존의 값이 없는경우 true
			map.put("isUsable", isUsable);
			map.put("result", result);
			
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@PostMapping("/member/memberLogin.do")
	public ModelAndView memberLogin(@RequestParam String email, @RequestParam String password, ModelAndView mav, HttpSession session) {
		
		try {
			Member m = memberService.selectOneMember(email);
			Map<String, String> deptOne = memberService.selectOneDept(email);
			Map<String, String> jobOne = memberService.selectOneJob(email);
			String msg="";
			String loc="/";
			if(m ==null) {
				msg="존재하지 않는 이메일입니다.";
				loc="/";
			}
			else {
				if(bcryptPasswordEncoder.matches(password, m.getPassword())) {
					msg="로그인 성공!";
					mav.addObject("memberLoggedIn", m);
					mav.addObject("dept_title",deptOne);
					mav.addObject("job_name", jobOne);
					loc="/main/main.do?email="+email;
				}else {
					msg="비밀번호가 틀렸습니다.";
					loc="/";
				}
			}
			mav.addObject("msg",msg);
			mav.addObject("loc",loc);
			mav.setViewName("common/msg");
			
		}catch(Exception e) {
			throw new MemberException("회원관리오류!",e);
		}
		return mav;
	}
	
	@RequestMapping("/member/memberLogOut.do")
	public String memberLogout(SessionStatus sessionStatus, Model model) {
		try {
			//setComplete 메소드 호출로 해당세션 폐기
			if(!sessionStatus.isComplete()) {
				sessionStatus.setComplete();
			}
			String msg="로그아웃되었습니다!";
			String loc="/";
			model.addAttribute("msg", msg);
			model.addAttribute("loc", loc);
			
			
			return "common/msg";//  /spring 으로 리다이렉트
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberAlterPassword.do")
	public ModelAndView memberAlterPassword(ModelAndView mav) {
		try {
			mav.setViewName("member/memberAlterPassword");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberUpdateInfo.do")
	public ModelAndView memberUpdateInfo(ModelAndView mav) {
		try {
			List<Map<String,String>> deptList = memberService.selectDeptList();
			List<Map<String,String>> jobList = memberService.selectJobList();
			
			mav.addObject("dept",deptList);
			mav.addObject("job",jobList);
			mav.setViewName("member/memberUpdateInfo");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/member/memberPasswordCheck.do")
	@ResponseBody
	public Map<String,Object> memberPasswordCheck(@RequestParam("password") String password, @RequestParam("email") String email, HttpServletResponse response) {
		try {
			Map<String, Object> map = new HashMap<>();
			Member m = memberService.selectOneMember(email);
			boolean isUsable;
			if(bcryptPasswordEncoder.matches(password, m.getPassword())) {
				isUsable=true;
			}else {
				isUsable=false;
			}
			map.put("isUsable",isUsable);
				
			
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@PostMapping("/member/updatePasswordEnd.do")
	@ResponseBody
	public ModelAndView updatePasswordEnd(ModelAndView mav, @RequestParam("password_Chk") String password_Chk, @RequestParam("email") String email) {
		try {
			String encryptedPassword = bcryptPasswordEncoder.encode(password_Chk);
			Map<String, Object> param = new HashMap<>();
			param.put("email", email);
			param.put("password", encryptedPassword);
			int result = memberService.updatePassword(param);
			String msg="";
			String loc="/main/main.do?email="+email;
			if(result>0) {
				msg="비밀번호 변경성공!";
			}
			mav.addObject("loc",loc);
			mav.addObject("msg",msg);
			
			mav.setViewName("common/msg");
			
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberFindMypage.do")
	public ModelAndView memberFindMypage(ModelAndView mav, @RequestParam("email") String email) {
		try {
			Map<String, String> deptOne = memberService.selectOneDept(email);
			Map<String, String> jobOne = memberService.selectOneJob(email);
			
			mav.addObject("dept_title",deptOne);
			mav.addObject("job_name",jobOne);
			
			
			mav.setViewName("main/main");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@PostMapping("/member/memberUpdateInfoEnd.do")
	public ModelAndView memberUpdateInfoEnd(ModelAndView mav,@RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("emp_name") String emp_name,
			@RequestParam("dept_code") String dept_code, @RequestParam("job_code") String job_code,@RequestParam("ssn1") String ssn1,
			@RequestParam("phone") String phone, @RequestParam("profileImage") String profileImage) {
		try {
			Member member = new Member(0,emp_name,ssn1,email,phone,dept_code,job_code,null,null,"N",password,profileImage);
			String rawPassword=member.getPassword();
			String encryptedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			
			int result =memberService.updateMember(member);
			Map<String, String> deptOne = memberService.selectOneDept(email);
			Map<String, String> jobOne = memberService.selectOneJob(email);
				
			String msg="";
			String loc="/main/main.do?email="+email;
			if(result>0) {
				msg="회원정보수정성공!";
				mav.addObject("memberLoggedIn", member);
				mav.addObject("dept_title",deptOne);
				mav.addObject("job_name", jobOne);
			}
			
			mav.addObject("loc",loc);
			mav.addObject("msg",msg);
			
			mav.setViewName("common/msg");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberProfile.do")
	public ModelAndView memberProfile(ModelAndView mav, @RequestParam("email") String email, 
									@RequestParam(value="uploadFile",required=false) MultipartFile profileImage, 
									HttpServletRequest request) {
		try {
			String saveDirectory = request.getSession()
										  .getServletContext()
										  .getRealPath("/resources/upload/member");
			Member member = new Member();
			File dir = new File(saveDirectory);
			if(dir.exists() == false)
				dir.mkdir();
				if(!profileImage.isEmpty()) {
					String originalFileName = profileImage.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = (int)(Math.random()*1000);
					String renamedFileName = sdf.format(new Date())+"_"+rndNum+ext;
					try {
						profileImage.transferTo(new File(saveDirectory+"/"+renamedFileName));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					member.setEmail(email);
					member.setProfileImage(renamedFileName);
				}
			int result = memberService.updateProfileImage(member);
			member = memberService.selectOneMember(email);
			if(result>0) {
				mav.addObject("memberLoggedIn",member);
				String loc = "/main/main.do?email="+email;
				String msg = "프로필사진이 수정되었습니다";
				mav.addObject("msg",msg);
				mav.addObject("loc",loc);
				mav.setViewName("common/msg");
			}
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("member/memberManage.do")
	public ModelAndView memberManage(ModelAndView mav)
	{
		try {
		List<Member> list=memberService.memberManage();
		mav.addObject("list",list);
	mav.setViewName("member/memberManage");
	return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberDelete.do")
	public ModelAndView memberDelete(ModelAndView mav,@RequestParam String email)
	{
		try {
		int result =memberService.memberDelete(email);
		mav.addObject("loc", "/member/memberManage.do");
		mav.addObject("msg", result>0?"삭제 성공!":"삭제 실패!");
		mav.setViewName("common/msg");
	
	return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberManageModify.do")
	public ModelAndView memberManageModify(ModelAndView mav,@RequestParam String email)
	{
		try {
		Member member=memberService.memberManageModify(email);
		List<Map<String,String>> deptList = memberService.selectDeptList();
		List<Map<String,String>> jobList = memberService.selectJobList();
		String empNo1=member.getEmpNo().substring(0,6);
		String empNo2=member.getEmpNo().substring(7,14);
		mav.addObject("empNo1",empNo1);
		mav.addObject("empNo2",empNo2);
		mav.addObject("dept",deptList);
		mav.addObject("job",jobList);
		mav.addObject("member", member);
		mav.setViewName("member/memberManageModify");
	
	return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/member/memberManageModifyEnd.do")
	public ModelAndView memberManageModifyEnd(ModelAndView mav,Member member,@RequestParam String empNo1,@RequestParam String empNo2) {
		try {
		member.setEmpNo(empNo1+"-"+empNo2);
		int result=memberService.memberManageModifyEnd(member);
		mav.addObject("loc", "/member/memberManage.do");
		mav.addObject("msg", result>0?"수정 성공!":"수정 실패!");
		mav.setViewName("common/msg");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
}
