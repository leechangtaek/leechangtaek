package com.dev.erp.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

/**
 * String[] <-> String
 * 
 * 3개의 getter (string -> String[]) 
 * - resultset에서 컬럼명
 * - resultset에서 컬럼 인덱스
 * - 프로시져(CallableStatement)
 * 
 * 1개의 setter (String[] -> string)
 *
 */
public class StringArrayTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		if(parameter != null) {
			ps.setString(i,String.join(",", parameter));
		}else {
			ps.setString(i,"");
		}
		
	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		String str = rs.getString(columnName);
		String[] strArr = null;
		if(str != null)
			strArr = str.split(",");
		
		return strArr;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String str = rs.getString(columnIndex);
		String[] strArr = null;
		if(str != null)
			strArr = str.split(",");
		
		return strArr;
		
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String str = cs.getString(columnIndex);
		String[] strArr = null;
		if(str != null)
			strArr = str.split(",");
		
		return strArr;
	}

}
