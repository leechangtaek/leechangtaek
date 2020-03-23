<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획량 계산(modal-body)</title>
<style>
#resultCal{
    font-size: larger;
    text-align: center;
}

</style>
</head>
<body>
	<p id="resultCal"></p>
</body>
<script>
$(()=>{
	var pn = $("#productName").val();
	var ppDate = "${ppDate }";
	var avg = ${avg};
	console.log(pn);
	
	$("#resultCal").html("'"+pn+"' 의 <br/>"+ ppDate + " 생산계획량 = "+ avg);
	
});
</script>

</html>