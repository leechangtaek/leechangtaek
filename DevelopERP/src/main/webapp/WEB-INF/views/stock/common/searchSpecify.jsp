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
<title>Insert title here</title>
</head>
<body>
	<table class="table table-bordered quality-specify-table" id="dataTable" width="100%" cellspacing="0">
		<thead>
			<tr>
			<th>No</th> 
			
			<c:if test="${searchType == 'rmNo'}">
			<th>원재료번호</th>
			<th>원재료명</th>
			</c:if>
			
			<c:if test="${searchType == 'storeNo'}">
			<th>창고번호</th>
			<th>창고명</th>
			</c:if>
			
			<c:if test="${searchType == 'ptNo'}">
			<th>품목번호</th>
			<th>품목명</th>
			</c:if>
			
			<c:if test="${searchType == 'lotNo'}">
			<th>로트번호</th>
			<th>입고날짜</th>
			</c:if>
			
			</tr>
		</thead>
	       
		<tbody id="tbodyList">
		</tbody>
	</table>
	
<div class="pageBar"></div>

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
	
	//input search
	$("#myInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#tbodyList tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
});


$(".quality-specify-table tbody").on('dblclick','tr',function(){
	var value = $(this).children().eq(1).html();
	var value2 = $(this).children().eq(2).html();
	var value3 = $(this).children().eq(3).html();
	
	var trNum = $("#trNum").val();
	console.log(trNum);
	console.log(value);
	
	if(trNum != "nulla"){
		$(".table-editable tr").eq(trNum).find("td").eq(1).text(value);
		$(".table-editable tr").eq(trNum).find("td").eq(2).text(value2);
		$(".table-editable tr").eq(trNum).find("td").eq(3).text(value3);
		
		console.log($(".table-editable tr").eq(trNum));
		console.log("eq0",$(".table-editable tr").eq(0));
		console.log($(".table-editable tr").eq(trNum).find("td").eq(2));
	}
	
	$("#${searchType}").val(value); // 로트번호
	$("#recDate").val(value2); // 입고일
	$("#quantity").val(value3); // 입고수량
	$("#mySearchModal").modal('hide');
});


function morePage(a){
	console.log("a==="+a);
	var searchType = "${searchType}";
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/stock/common/searchSpecifyPage.do?searchType=${searchType}&cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/stock/common/"+a;
	}
	console.log("url="+url_);
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var speclist = data.speclist;
			$(".quality-specify-table tbody").children().remove();
			for(var i in speclist ) {
				let p = speclist[i];
				console.log(p);		
				$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"
														+p.content2+"</td><td>"
														+p.content+"</td><td style='display:none;'>"
														+p.content3+"</td></tr>");
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

<style>
.searchModalBody{
	height: 350px;
}
</style>

</html>