<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
 <script src="${pageContext.request.contextPath }/resources/js/jquery.table2excel.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<%-- nav bar tap start --%>
<!-- <ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" href="#">전체</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">제품</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">반제품</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">원재료</a>
  </li>
</ul> -->
<%-- nav bar tap end --%>
<h1 class="h3 mb-2 text-gray-800" >영엽 관리</h1>
<button type="button" class="btn btn-outline-primary" id="searchByPeriod">기간으로 검색하기</button><br /><br />
<div class="search-period off" style="margin-bottom:50px;">
    <div class="row">
       <div class="col">
        <label for="startDate">시작일자</label>&nbsp;&nbsp;&nbsp;
        <input type="date" name="startDate" class="form-control datepicker startDate">
       </div>
       <div class="col">
       <label for="endDate">종료일자</label>&nbsp;&nbsp;&nbsp;
          <input type="date" name="endDate" class="form-control datepicker endDate">	
       </div>
       <div class="col">
       	<button type="button" class="btn btn-outline-secondary" id="search-period-button">조회하기</button>
       </div>
   </div>
</div>
<%-- table start --%>
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">판매 목록</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
  	${salseList }
    <table class="table table-bordered" id="dataTableSalesList" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>판매번호</th>
          <th>Lot번호</th>
          <th>제품명</th>
          <th>판매처</th>
          <th>판매 수량(ea)</th>
          <th>입고 단가(원)</th>
          <th>판매 단가(원)</th>
          <th>판매 이익(원)</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${salesList}" var="s" varStatus="vs">
	        <tr class="getTr">
	          <td>${s.SALES_NO}</td>
	          <td>${s.LOT_NO}</td>
	          <td>${s.PRODUCT_NAME}</td>
	          <td>${s.VENDOR_NAME}</td>
	          <td>${s.QUANTITY}</td>
	          <td>${s.INPRICE }</td>
	          <td>${s.OUTPRICE }</td>
	          <td>${(s.OUTPRICE*s.QUANTITY)-(s.INPRICE*s.QUANTITY) }</td>
        </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>
<button class="btn btn-primary" type="button" id="addSalesBtn">판매 등록</button> &nbsp;&nbsp;
<button class="btn" type="button" id="export-excel-button">
	<img src="${pageContext.request.contextPath }/resources/images/excel.png" alt="" style="width:40px;height:40px;"/>
</button> 
<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="salesAddModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content add-modal-content">
	        <div class="modal-header">
	            <h5 class="modal-title controll-title"></h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	            </button>
	        </div>
	        <div class="modal-body controll-modal-body3">
	            <!-- <p>Modal body text goes here.</p> -->
	        </div>
        </div>
    </div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="myUpdateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content update-modal-content">
        <div class="modal-header">
            <h5 class="modal-title Update-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body update-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

<style>
.tdBOMAddAlign{
	text-align: center;
}
.BOMAddBtn{
	    width: 100%;
}
.search-period .form-control {
    display:inline;
    width: 60%;
}
.off {
	display:none;
}
/* #salesAddModal { */
/*   width: 60%; */
/*   height: 250px; */
/* } */
</style>
<script>
<%--onload start--%>
$(()=>{
	
	$("#dataTableSalesList").DataTable({
		// 3번째 항목을 오름 차순 
		// order : [ [ 열 번호, 정렬 순서 ], ... ]
		order: [ [ 0, "desc" ] ]
	});


	console.log("${salesList}");
	
});
$("#export-excel-button").click(function(){
	  $("#dataTableSalesList").table2excel({
		      // exclude CSS class
		      exclude:".noExl",
		      name:"Worksheet Name",
		      filename:"SomeFile",//do not include extension
		      fileext:".xls" // file extension
  	});
});
<%--onload end--%>
$("#searchByPeriod").click(function(){
	$(".search-period").toggleClass("off");
});
$("#search-period-button").click(function(){
	var startDate = $(".startDate").val();
	var endDate = $(".endDate").val();
	location.href = "${pageContext.request.contextPath}/sales/salesListManagement.do?startDate="+startDate+"&endDate="+endDate;
});

$("#dataTableSalesList tbody tr").click(function(){
	var sales_no = $(this).children().eq(0).html();
	$('.update-modal-body').children().remove();
	 $('.update-modal-body').load("${pageContext.request.contextPath}/sales/cancleSalesForm.do?sales_no="+sales_no,function(){
	        $('#myUpdateModal').modal({backdrop: 'static', keyboard: false});
	        $('#myUpdateModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".Update-title").html("");
	        $(".Update-title").html("출고 취소");
		});
});
<%--modal show--%>
$("#addSalesBtn").click(function(){
	
	$('.controll-modal-body3').load("${pageContext.request.contextPath}/sales/salesAddModal.do",function(){
	        $('#salesAddModal').modal({backdrop: 'static', keyboard: false});
	        $('#salesAddModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        
	        $(".controll-title").html("");
	        $(".controll-title").html("판매 등록");
	    });
	
	
	
    
});

</script>


<!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>