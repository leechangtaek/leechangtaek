package com.dev.erp.quality.model.vo;

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
public class Quality {
	private int qualityNo;
	private String lotNo;
	private int storeNo;
	private String type;
	private String qualityComment;
	private Date regDate;
	private int ptNo;
	private int rmNo;
	private String pName;
}
