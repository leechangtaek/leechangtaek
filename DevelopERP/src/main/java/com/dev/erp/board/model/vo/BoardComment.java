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
public class BoardComment {

	private int BoardCommentNo;
	private int BoardCommentLevel;
	private String email;
	private String BoardCommentContent;
	private int BoardRef;
	private int BoardCommentRef;
	private String BoardCommentDate;
	private String name;
}
