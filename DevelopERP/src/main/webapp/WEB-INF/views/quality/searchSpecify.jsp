<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

     <table class="table table-bordered quality-specify-table" id="dataTable" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th>번호</th>
           <th>내용</th>
         </tr>
       </thead>
       <tbody>
<%--   		<c:forEach items="${speclist }" var="l" varStatus="vs">	 --%>
<!--           <tr> -->
<%--             <td>${vs.count }</td> --%>
<%--             <td>${l.content }</td> --%>
<!--           </tr> -->
<%--         </c:forEach> --%>
       </tbody>
     </table>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>

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


$(".quality-specify-table tbody").on('dblclick','tr',function(){
	var value = $(this).children().eq(1).html();
	console.log(value);
	$("[name=${searchType}]").val(value);
	$("#mySearchModal").modal('hide');
});


function morePage(a){
	console.log("a==="+a);
	var searchType = "${searchType}";
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/quality/searchSpecifyPage.do?searchType=${searchType}&cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/quality/"+a;
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
				$(".quality-specify-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*5+1)+"</td><td>"+p.content+"</td><tr>");
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
