package com.dev.erp.document.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.document.model.vo.Document;
import com.dev.erp.document.model.vo.DocumentLine;

public interface DocumentDAO {

	List<Document> selectDocList(String empName);

	List<Map<String, String>> selectDocTypeAll();

	int insertDocument(Document document);

	int insertDocumentLine(DocumentLine documentLine);

	List<Map<String, String>> selectMemberList(int cPage, int numPerPage);

	int selectAllCountByAccountNo();

	Document documentDetailView(int docNo);

	int approveDocument(Map<String, Object> param);

	int refuseDocument(Map<String, Object> param);

	List<DocumentLine> documentLineView(int docNo);

	DocumentLine documentPrevWriter(Map<String, Object> map);
	
	DocumentLine documentNextWriter(Map<String, Object> map);

	int updateDocument(int docNo);

	int notUpdateDocument(int docNo);

	DocumentLine selectDocumentLine(Map<String, Object> map2);


}
