package com.dev.erp.document.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.document.model.vo.Document;
import com.dev.erp.document.model.vo.DocumentLine;

@Repository
public class DocumentDAOImpl implements DocumentDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Document> selectDocList(String empName) {
		return sqlSession.selectList("document.selectDocList",empName);
	}

	@Override
	public List<Map<String, String>> selectDocTypeAll() {
		return sqlSession.selectList("document.selectDocTypeAll");
	}

	@Override
	public int insertDocument(Document document) {
		return sqlSession.insert("document.insertDocument",document);
	}

	@Override
	public int insertDocumentLine(DocumentLine documentLine) {
		return sqlSession.insert("document.insertDocumentLine",documentLine);
	}

	@Override
	public List<Map<String, String>> selectMemberList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("document.selectMemberList",null,rowBounds);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return sqlSession.selectOne("document.selectAllCountByAccountNo");
	}

	@Override
	public Document documentDetailView(int docNo) {
		return sqlSession.selectOne("document.documentDetailView",docNo);
	}


	@Override
	public List<DocumentLine> documentLineView(int docNo) {
		return sqlSession.selectList("document.documentLineView",docNo);
	}

	@Override
	public int approveDocument(Map<String, Object> param) {
		return sqlSession.update("document.approveDocument",param);
	}

	@Override
	public int refuseDocument(Map<String, Object> param) {
		return sqlSession.update("document.refuseDocument",param);
	}

	@Override
	public DocumentLine documentPrevWriter(Map<String, Object> map) {
		return sqlSession.selectOne("document.documentPrevWriter",map);
	}

	@Override
	public DocumentLine documentNextWriter(Map<String, Object> map) {
		return sqlSession.selectOne("document.documentNextWriter",map);
	}

	@Override
	public int updateDocument(int docNo) {
		return sqlSession.update("document.updateDocument",docNo);
	}

	@Override
	public int notUpdateDocument(int docNo) {
		return sqlSession.update("document.notUpdateDocument",docNo);
	}

	@Override
	public DocumentLine selectDocumentLine(Map<String, Object> map2) {
		return sqlSession.selectOne("document.selectDocumentLine",map2);
	}

}
