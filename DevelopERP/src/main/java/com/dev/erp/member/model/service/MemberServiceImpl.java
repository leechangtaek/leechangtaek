package com.dev.erp.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.member.model.dao.MemberDAO;
import com.dev.erp.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public List<Map<String, String>> selectDeptList() {
		return memberDAO.selectDeptList();
	}

	@Override
	public List<Map<String, String>> selectJobList() {
		return memberDAO.selectJobList();
	}

	@Override
	public List<Member> memberSelectList() {
		return memberDAO.memberSelectList();
	}

	@Override
	public Member selectOneMember(String email) {
		return memberDAO.selectOneMember(email);
	}

	@Override
	public int updatePassword(Map<String, Object> param) {
		return memberDAO.updatePassword(param);
	}

	@Override
	public Map<String, String> selectOneDept(String email) {
		return memberDAO.selectOneDept(email);
	}
	
	@Override
	public Map<String, String> selectOneJob(String email) {
		return memberDAO.selectOneJob(email);
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

	@Override
	public int updateProfileImage(Member member) {
		return memberDAO.updateProfileImage(member);
	}

	@Override
	public List<Member> memberManage() {
		return memberDAO.memberManage();
	}

	@Override
	public int memberDelete(String email) {
		return memberDAO.memberDelete(email);
	}

	@Override
	public Member memberManageModify(String email) {
		return memberDAO.memberManageModify(email);
	}

	@Override
	public int memberManageModifyEnd(Member member) {
		return memberDAO.memberManageModifyEnd(member);
	}


}

