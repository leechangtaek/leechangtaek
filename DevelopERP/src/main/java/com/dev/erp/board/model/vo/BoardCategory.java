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

public class BoardCategory {
	private int categoryNo;
	private int boardNo;
	private String categoryComment;
	private String categoryWriter;
	private String categoryTitle;
	private String categoryStatus;
	private Date categoryDate;

}