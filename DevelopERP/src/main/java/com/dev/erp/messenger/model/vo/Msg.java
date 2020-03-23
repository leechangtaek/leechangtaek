package com.dev.erp.messenger.model.vo;

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
public class Msg {
	private long chatNo;
	private String chatId;
	private String email;
	private String msg;
	private long time;
	private MsgType type;
}
