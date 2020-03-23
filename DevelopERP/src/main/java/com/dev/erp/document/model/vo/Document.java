package com.dev.erp.document.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Document {
	private int docNo;
	private int typeNo;
	private String docType;
	private String docTitle;
	private String docStatus;
	private String docWriter;
	private String docLastapproval;
	private String docContent;
	private Date regDate;
	private String startDate;
	private String endDate;
	private String email;
}

