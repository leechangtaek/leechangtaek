<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>인쇄창</title>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
 <style>
 .table-approval-line-stamp th{
border:1px solid #ccc; 
text-align:center;
padding:3px;
}
.table-approval-line-stamp td{
border:1px solid #ccc;
}
.table-approval-line-content th{
border:1px solid #ccc; 
padding:3px;
}
.table-approval-line-content td{
border:1px solid #ccc;
}
 </style>
 
<script>

$(()=>{
	 $("#B").html(opener.document.getElementById("printzone").value);
	 console.log(opener.document.getElementById("printzone"));
	 window.print();
	 
})
</script>
</head>

<body>
<div id="B">
</div>
</body>
</html>