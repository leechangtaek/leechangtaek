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
<title>작업지시서 등록폼 - 세부사항 modal body</title>
</head>
<body>
     <table class="table table-bordered joDetails-table" id="dataTable" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th>No.</th>
           <c:if test="${searchType eq 'customer'}" >
           <th>납품처</th>
           <th>담당자</th>
           </c:if>
           <c:if test="${searchType eq 'productName'}" >
           <th>제품번호</th>
           <th>제품명</th>
           </c:if>
         </tr>
       </thead>
       <tbody>
       
       </tbody>
     </table>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>
</body>

<style>
.quality-specify-table tbody tr:hover td{
	cursor : auto;
	background-color:#ccc;
}

</style>

<script>
$(()=>{
	console.log("${searchType}");
	morePage(0);
});

$(".joDetails-table tbody").on('dblclick','tr',function(){
	//납품처 행 선택시 해당 담당자 뿌려주기
	if("${searchType}" == 'customer'){
		var value = $(this).children().eq(1).html();
		console.log(value);
		$("#${searchType}").val(value);
		var value2 = $(this).children().eq(2).html();
		$("#manager").val(value2);
	}
	//제품명 뿌려주기
	if("${searchType}" == 'productName'){
		var value = $(this).children().eq(2).html();
		console.log(value);
		$("#${searchType}").val(value);
		
		var plNo = $(this).children().eq(1).html();
		$("#plNo").val(plNo);
	}
	
	$("#searchDetailsModal").modal('hide');
});


function morePage(a){
	console.log("a==="+a);
	var searchType = "${searchType}";
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/productplan/searchDetailsPage.do?searchType=${searchType}&cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/productplan/"+a;
	}
	
	console.log("url="+url_);
	$.ajax({
		url : url_,
		dataType : "json",
		contentType: "application/json; charset=utf-8",
		success : data => {
			var list = data.detailsList;
			$(".joDetails-table tbody").children().remove();
			for(var i in list ) {
				let p = list[i];
				console.log(p);	
				$(".joDetails-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content1+"</td><td>"+p.content2+"</td><tr>");
			}
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"morePage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
		
	});
	
}



</script>

</html>