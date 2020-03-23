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

public class BoardClub{
	private int clubNo;
	private Date clubDate;
	private String clubWriter;
	private String clubName;
	private String clubTitle;
	private String clubComment;
	private String clubWhere;

}