package com.dev.erp.document.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.document.model.dao.DocumentDAO;
import com.dev.erp.document.model.vo.Document;
import com.dev.erp.document.model.vo.DocumentLine;

@Service
public class DocumentServiceImpl implements DocumentService {

	@Autowired
	DocumentDAO documentDAO;

	@Override
	public List<Document> selectDocList(String empName) {
		return documentDAO.selectDocList(empName);
	}

	@Override
	public List<Map<String, String>> selectDocTypeAll() {
		return documentDAO.selectDocTypeAll();
	}

	@Override
	public int insertDocument(Document document) {
		return documentDAO.insertDocument(document);
	}

	@Override
	public int insertDocumentLine(DocumentLine documentLine) {
		return documentDAO.insertDocumentLine(documentLine);
	}

	@Override
	public List<Map<String, String>> selectMemberList(int cPage, int numPerPage) {
		return documentDAO.selectMemberList(cPage,numPerPage);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return documentDAO.selectAllCountByAccountNo();
	}

	@Override
	public Document documentDetailView(int docNo) {
		return documentDAO.documentDetailView(docNo);
	}


	@Override
	public List<DocumentLine> documentLineView(int docNo) {
		return documentDAO.documentLineView(docNo);
	}

	@Override
	public int approveDocument(Map<String, Object> param) {
		return documentDAO.approveDocument(param);
	}

	@Override
	public int refuseDocument(Map<String, Object> param) {
		return documentDAO.approveDocument(param);
	}

	@Override
	public DocumentLine documentPrevWriter(Map<String, Object> map) {
		return documentDAO.documentPrevWriter(map);
	}

	@Override
	public DocumentLine documentNextWriter(Map<String, Object> map) {
		return documentDAO.documentNextWriter(map);
	}

	@Override
	public int updateDocument(int docNo) {
		return documentDAO.updateDocument(docNo);
	}

	@Override
	public int notUpdateDocument(int docNo) {
		return documentDAO.notUpdateDocument(docNo);
	}

	@Override
	public DocumentLine selectDocumentLine(Map<String, Object> map2) {
		return documentDAO.selectDocumentLine(map2);
	}

}
