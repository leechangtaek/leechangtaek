package com.dev.erp.board.model.vo;



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

public class BoardNotice {
	private int noticeNo;
	private Date noticeDate;
	private String noticeWriter;
	private String noticeTitle;
	private Date noticePlanStart;
	private Date noticePlanEnd;
	private Date noticeActualEnd;
	private String noticeComment;
}