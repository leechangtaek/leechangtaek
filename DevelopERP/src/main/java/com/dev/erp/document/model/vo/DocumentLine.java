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
public class DocumentLine {

	private int lineNo;
	private int docNo;
	private int typeNo;
	private String prevWriter;
	private String nextWriter;
	private String returnYn;
}
