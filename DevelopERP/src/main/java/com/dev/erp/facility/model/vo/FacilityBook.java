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
public class FacilityBook {
	 private int bookNo;
     private int facilityNo;
     private String email;
     private String bookDay;
     private String bookStarttime;
     private String bookEndtime;
}
