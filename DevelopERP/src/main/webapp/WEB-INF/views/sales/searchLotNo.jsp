<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
         	<th>번호</th>
           <th>Lot번호</th>
           <th>제품번호</th>
           <th>거래처 번호</th>
           <th>재고량</th>
           <th>입고가</th>
           <th>출고가</th>
         </tr>
       </thead>
       <tbody >
       </tbody>
     </table>
     </div>
     </div>
     <input type="hidden" id="trNum" value="nulla"/>
     <input type="hidden" id="valForSearch" value="a"/>
</div>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>

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
.searchLotModal-content {
	width:1000px !important;
	height: 100%;
}
</style>

<script>
$(()=>{
	//console.log("${searchType}");
	morePage(0);
	
// 	input search
	$("#myInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#tbodyList tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
	
	
	
	
});


$(".quality-specify-table tbody").on('dblclick','tr',function(){
	var value = $(this).children().eq(1).html();
	var value1 = $(this).children().eq(2).html();
	var value2 = $(this).children().eq(3).html();
	var value3 = $(this).children().eq(4).html();
	var value4 = $(this).children().eq(5).html();
	var value5 = $(this).children().eq(6).html();
	var trNum = $("#trNum").val();
	//console.log(trNum);
	//console.log(value);
	
	if(trNum != "nulla"){
		$(".table-editable tr").eq(trNum).find("td").eq(1).text(value);
		$(".table-editable tr").eq(trNum).find("td").eq(2).text(value1);
		$(".table-editable tr").eq(trNum).find("td").eq(3).text(value2);
		$(".table-editable tr").eq(trNum).find("td").eq(4).text(value3);
		$(".table-editable tr").eq(trNum).find("td").eq(5).text(value4);
		$(".table-editable tr").eq(trNum).find("td").eq(6).text(value5);
	}
	
	$("#salesQuantity").focus();
	$("#searchLotModal").modal('hide');
});


function morePage(a){
	//console.log("a==="+a);
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/sales/searchSpecifyPage.do?searchType=${searchType}&cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/sales/"+a;
	}
	//console.log("url="+url_);
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
				console.log(data);
				var speclist = data.map.speclist;
				$(".quality-specify-table tbody").children().remove();
				for(var i in speclist ) {
					let p = speclist[i];
					//console.log(p);	
					$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.map.cPage-1)*5+1)+"</td><td>"+p.LOT_NO+"</td><td>"+p.PL_NO+"</td><td>"+p.VENDOR_NO+"</td><td>"+p.QUANTITY+"</td><td>"+p.INPRICE+"</td><td>"+p.OUTPRICE+"</td><tr>");
				}
				$(".pageBar").html(data.map.pageBar);
				$("span.page-link").attr('onclick',"morePage(this.id)");
			},

		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
	})	
}


</script>


