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
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary"></h6>
</div>
<div class="card-body">
<div class="table-responsive">
  	<!-- <div class="input-group-append">
		<input type="text" id="myInput" class="form-control" placeholder="Search..." aria-label="Search..." aria-describedby="basic-addon2">
    	<i class="fas fa-search fa-lg"></i>
  	</div> -->
     <table class="table table-bordered quality-specify-table" id="dataTable2" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th>No</th>
		   <c:if test="${searchType == 'accountNo'}">
           <th>거래처번호</th>
           <th>거래처명</th>
           <th>거래구분코드</th>
           </c:if>
           <c:if test="${searchType == 'ptNo'}">
           <th>품목번호</th>
           <th>품목명</th>
           </c:if>
           <c:if test="${searchType == 'rawMaterial'}">
           <th>품목번호</th>
           <th>품목명</th>
           </c:if>
           <c:if test="${searchType == 'vendorTypes'}">
           <th>거래처 구분코드</th>
           <th>거래처구분명</th>
           </c:if>
           <c:if test="${searchType == 'rawMaterialDetail'}">
           <th>품목번호</th>
           <th>품목명</th>
           <th>관리번호</th>
           <th>거래처구분코드</th>
           </c:if>
           <c:if test="${searchType == 'storeNo'}">
           <th>창고번호</th>
           <th>창고이름</th>
           </c:if>
           <c:if test="${searchType == 'showJobOrder'}">
           <th>작업지시번호</th>
           <th>납품처</th>
           <th>납기일</th>
           <th>담당자</th>
           <th>제품명</th>
           <th>지시수량</th>
           <th>품목코드</th>
           </c:if>
           <c:if test="${searchType == 'receivingLotNo'}">
           <th>입고날짜</th>
           <th>로트번호</th>
           <th>입고수량</th>
           </c:if>
         </tr>
       </thead>
       <tbody id="tbodyList">
       </tbody>
     </table>
     </div>
     </div>
     <input type="hidden" id="trNum" value="nulla"/>
     <input type="hidden" id="valForSearch" value="a"/>
</div>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>
</body>

<style>
.quality-specify-table tbody tr:hover td{
	cursor : auto;
	background-color:#ccc;
}
.fa-lg {
    font-size: 1.53333em;
    line-height: 1.45em;
    vertical-align: 0.2333em;
    padding-left: 11px;
}
</style>

<script>
$(()=>{
	//console.log("specify="+"${searchType}");
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
	var value4 = $(this).children().eq(4).html();
	var value5 = $(this).children().eq(5).html();
	var value6 = $(this).children().eq(6).html();
	var value7 = $(this).children().eq(7).html();
	var trNum = $("#trNum").val();
	//console.log(trNum);
	//console.log(value);
	
	if(trNum != "nulla"){
		console.log("1");
		if($("#valForSearch").val() == "receivingLotNo"){
			//console.log("lotNo")
			$(".table-editable tr").eq(trNum).find("td").eq(4).text(value2);
			$(".table-editable tr").eq(trNum).find("td").eq(5).text(value3);
		}
		else{
			$(".table-editable tr").eq(trNum).find("td").eq(1).text(value);
			$(".table-editable tr").eq(trNum).find("td").eq(2).text(value2);
		}
	}
	if($("#${searchType}").attr('name') == 'accountNo'){
		console.log("2");
		$("#vendorType").val(value3);
	}
	if($("#${searchType}").attr('name') == 'rawMaterialDetail'){
		console.log("3");
		$("#ptNo").val(value3);
		$("#vendorType").val(value4);
		$("#storeNo").val(1);
		$("#rmName").val(value2);
		$("#quantity").focus();
	}
	if($("#${searchType}").attr('name') == 'showJobOrder'){
		console.log("4");
		$("#${searchType}").val(value);
		$("#addReleasing-Modal #rProduct").val(value5);
		$("#addReleasing-Modal #rQuantity").val(value6);
		$("#addReleasing-Modal #rCode").val(value7);
	}
	if($("#valForSearch").val() == "update"){
		console.log("update COM")
		$("#updateWarehousing #ptNo").val(value3);
		$("#updateWarehousing #vendorType").val(value4);
		$("#updateWarehousing #rawMaterialDetail").val(value);
		$("#updateWarehousing #quantity").focus();
	}
	
	console.log("5");
	$("#${searchType}").val(value);
	$("#vendorTypess").val(value);
	$("#mySearchModal").modal('hide');
});


function morePage(a){
	//console.log("a==="+a);
	var searchType = "${searchType}";
	var thisCode = "${thisCode}";
	//console.log("searchType="+searchType);
	//console.log("thisCode="+thisCode);
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/enrollment/searchSpecifyPage.do?searchType=${searchType}&cPage=1&thisCode=${thisCode}";
	}
	else {
		url_="${pageContext.request.contextPath}/enrollment/"+a+"&thisCode=${thisCode}";
	}
	//console.log("url="+url_);
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			//console.log("data?=",data);
			if(data.searchType == 'accountNo'){
				var speclist = data.speclist;
				$(".quality-specify-table tbody").children().remove();
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content2+"</td><td>"+p.content+"</td><td>"+p.content3+"</td><tr>");
				}
				$(".pageBar").html(data.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			}
			else if(data.searchType == 'rawMaterialDetail'){
				var speclist = data.speclist;
				$(".quality-specify-table tbody").children().remove();
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content2+"</td><td>"+p.content+"</td><td>"+p.content3+"</td><td>"+p.content4+"</td><tr>");
				}
				$(".pageBar").html(data.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			}
			else if(data.searchType == 'showJobOrder'){
				var speclist = data.speclist;
				$(".quality-specify-table tbody").children().remove();
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content2+"</td><td>"+p.content+"</td><td>"+p.content3+"</td><td>"+p.content4+"</td><td>"+p.content5+"</td><td>"+p.content6+"</td><td>"+p.content7+"</td><tr>");
				}
				$(".pageBar").html(data.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			}
			else if(data.searchType == 'receivingLotNo'){
				var speclist = data.speclist;
				$(".quality-specify-table tbody").children().remove();
				if(data.speclist.length == 0){
					$(".quality-specify-table tbody").append("<tr><td colspan='4' style='TEXT-ALIGN: center'>해당 품목의 원재료가 존재하지 않습니다.</td><tr>");
				}
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content2+"</td><td>"+p.content+"</td><td>"+p.content3+"</td><tr>");
				}
				$(".pageBar").html(data.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			}
			else{
				var speclist = data.speclist;
				$(".quality-specify-table tbody").children().remove();
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content2+"</td><td>"+p.content+"</td><tr>");
				}
				$(".pageBar").html(data.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			}
			
		},
		error:(x,s,e)=>{
			/* console.log("ajax요청실패",x,s,e); */
		}
		
	});
	
}


</script>



</html>