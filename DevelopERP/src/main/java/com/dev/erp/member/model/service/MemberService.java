package com.dev.erp.member.model.service;

import java.util.List;
import java.util.Map;

import com.dev.erp.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	List<Map<String, String>> selectDeptList();

	List<Map<String, String>> selectJobList();

	List<Member> memberSelectList();

	Member selectOneMember(String email);

	int updatePassword(Map<String, Object> param);

	Map<String, String> selectOneDept(String email);
	
	Map<String, String> selectOneJob(String email);

	int updateMember(Member member);

	int updateProfileImage(Member member);

	List<Member> memberManage();

	int memberDelete(String email);

	Member memberManageModify(String email);

	int memberManageModifyEnd(Member member);


}
