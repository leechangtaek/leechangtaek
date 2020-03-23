package com.dev.erp.member.model.vo;

import java.io.Serializable;
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
public class Member implements Serializable {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;

	private int empId;
	private String empName;
	private String empNo;
	private String email;
	private String phone;
	private String deptCode;
	private String jobCode;
	private Date hireDate;
	private Date quitDate;
	private String quitYn;
	private String password;
	private String profileImage;
}
