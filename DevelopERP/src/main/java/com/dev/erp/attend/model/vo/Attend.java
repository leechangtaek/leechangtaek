package com.dev.erp.attend.model.vo;

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
public class Attend {
	private String email;
	private String deptCode;
	private String attendStart;
	private String attendStartForm;
	private String attendEnd;
	private String attendEndForm;
	private String earlyAttend;
	private String earlyAttendForm;
	private String reason;
}
