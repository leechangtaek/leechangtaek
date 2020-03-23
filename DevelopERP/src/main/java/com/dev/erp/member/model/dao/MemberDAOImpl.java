package com.dev.erp.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember",member);
	}

	@Override
	public List<Map<String, String>> selectDeptList() {
		return sqlSession.selectList("member.selectDeptList");
	}

	@Override
	public List<Map<String, String>> selectJobList() {
		return sqlSession.selectList("member.selectJobList");
	}

	@Override
	public List<Member> memberSelectList() {
		return sqlSession.selectList("member.memberSelectList");
	}

	@Override
	public Member selectOneMember(String email) {
		return sqlSession.selectOne("member.selectOneMember",email);
	}

	@Override
	public int updatePassword(Map<String, Object> param) {
		return sqlSession.update("member.updatePassword",param);
	}

	@Override
	public Map<String, String> selectOneDept(String email) {
		return sqlSession.selectOne("member.selectOneDept",email);
	}
	
	@Override
	public Map<String, String> selectOneJob(String email) {
		return sqlSession.selectOne("member.selectOneJob",email);
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember",member);
	}

	@Override
	public int updateProfileImage(Member member) {
		return sqlSession.update("member.updateProfileImage",member);
	}

	@Override
	public List<Member> memberManage() {
		return sqlSession.selectList("member.memberManage");
	}

	@Override
	public int memberDelete(String email) {
		return sqlSession.delete("member.memberDelete",email);
	}

	@Override
	public Member memberManageModify(String email) {
		return sqlSession.selectOne("member.memberManageModify", email);
	}

	@Override
	public int memberManageModifyEnd(Member member) {
		return sqlSession.update("member.memberManageModifyEnd",member);
	}


}
