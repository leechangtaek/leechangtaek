package com.dev.erp.facility.model.vo;

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
public class Facility {

	private String facilityNo;
	private String facilityName;
	private String facilityPhone;
	private String facilityLocation;
}
