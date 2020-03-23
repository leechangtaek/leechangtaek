<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- Custom styles for this page -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  


	<h1 class="h3 mb-2 text-gray-800">구매 조회</h1>
	
	<br />
	
	<!-- DataTales Example -->
	
	<div class="card shadow mb-4" style="clear:both;">
		<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
	</div>
	  
	
	  <div class="card-body" style='font-size: 14px'>
	    <div class="table-responsive">
			<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
			  <thead>
			    <tr>
			     <th>구매 요청일</th>
			     <th>원재료 번호</th>
			     <th>원재료 이름</th>
			     <th>거래처 번호</th>
			     <th>거래처 이름</th>
			     <th>필요 수량</th>
			    </tr>
			  </thead>
			  
			  <tbody>
		      	<c:forEach items="${purchaseList}" var="purchaseList" varStatus="vs">
			        <tr>
			          <td>${purchaseList.PURCHASE_DATE}</td>
			          <td>${purchaseList.RM_NO}</td>
			          <td>${purchaseList.RM_NAME}</td>
			          <td>${purchaseList.VENDOR_NO}</td> 
			          <td>${purchaseList.VENDOR_NAME}</td> 
			          <td>${purchaseList.PURCHASE_AMOUNT}</td> 
			        </tr>
		        </c:forEach>
			  </tbody>
			  
			</table>
	    </div>
	  </div>
	</div>
	          
	          
	<!-- Modal -->
	<div class="modal" tabindex="-1" role="dialog" id="rmModal">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
		        <div class="modal-header">
		            <h5 class="modal-title controll-title"></h5>
		            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		            </button>
		        </div>
		        <div class="modal-body controll-modal-body">
		            <!-- <p>Modal body text goes here.</p> -->
		        </div>
	        </div>
	    </div>
	</div>
	

<style>
#rmModal{
	z-index: 1060;
}
#dataTable tbody tr:hover td{
	cursor : auto;
	background-color:#ccc;
}
</style>
<script>
$(()=>{
	
	$("#dataTable").DataTable({
		// 3번째 항목을 오름 차순 
		// order : [ [ 열 번호, 정렬 순서 ], ... ]
		order: [ [ 0, "desc" ] ]
	});
	
})
</script>
<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>






