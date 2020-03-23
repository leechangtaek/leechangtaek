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
  
  
	<h1 class="h3 mb-2 text-gray-800">구매 입력</h1>
	
	<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="float:right;">
		<div class="input-group" style="margin:30px;">
		
		</div>
	</form>
	
	<br />
	
	<!-- DataTales Example -->
	
	<div class="card shadow mb-4" style="clear:both;">
		<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">구매 요청 목록 (구매 입력할 품목을 선택해주세요) </h6>
	</div>
	  
	
	  <div class="card-body" style='font-size: 14px'>
	    <div class="table-responsive">
			<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
			  <thead>
			    <tr>
			     <th>구매 요청일</th>
			     <th>납기일</th>
			     <th>원재료 번호</th>
			     <th>원재료명</th>
			     <th>거래처 등록번호</th>
			     <th>필요수량</th>
			     <th>전달내용</th>
			     <th>구매 소요일</th>
			    </tr>
			  </thead>
			  
			  
			  <tbody>
		      	<c:forEach items="${purchaseInsertList}" var="purchaseInsertList" varStatus="vs">
			        <c:if test="${purchaseInsertList.REQUIRE_AMOUNT > 0}">
			        	<tr class="purchaseModal">
				          <td>${purchaseInsertList.REQUEST_DATE}</td>
				          <td>${purchaseInsertList.DUE_DATE}</td>
				          <td>${purchaseInsertList.RM_NO}</td>
				          <td>${purchaseInsertList.RM_NAME}</td>
				          <td>${purchaseInsertList.VENDOR_NO}</td>
				          <td>${purchaseInsertList.REQUIRE_AMOUNT}</td>
				          <td>${purchaseInsertList.REQUEST_CONTENTS}</td> 
				          
				          <c:if test="${purchaseInsertList.EXPECT < 0}">
				          	<td><a href="#" style="color:red;"> ${purchaseInsertList.DELIVERY} </a></td> 
				          </c:if>
				          <c:if test="${purchaseInsertList.EXPECT >= 0}">
				          	<td><a href="#" style="color:blue;"> ${purchaseInsertList.DELIVERY}</a></td> 
				          </c:if>
				        </tr>
			        </c:if>
		        </c:forEach>
			  </tbody>
			  
			</table>
	    </div>
	  </div>
	</div>
	          
	          
	<!-- Modal -->
	<div class="modal" tabindex="-1" role="dialog" id="purchaseModal">
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
	

	<script>
	
			
		<%--거래처번호 a태그 클릭시 정보수정 Modal 활성화--%>
		$(".purchaseModal").click(function(){ 	

			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			// td.eq(index)를 통해 값을 가져올 수도 있다.
			var tdRequestDate = td.eq(0).text().substring(0,10);
			var tdDueDate = td.eq(1).text().substring(0,10);
			var tdRmNo = td.eq(2).text();
			var tdRmName = td.eq(3).text();
			var tdVendorNo = td.eq(4).text();
			var tdRequireAmount = td.eq(5).text();
			var tdRequestContents = td.eq(6).text();
			
			console.log(tdRequestDate);
			console.log(tdDueDate);
			console.log(tdRmNo);
			console.log(tdRmName);
			console.log(tdVendorNo);
			console.log(tdRequireAmount);
			console.log(tdRmName);
			
			
			$('.controll-modal-body').load("${pageContext.request.contextPath}/purchase/modalPurchaseInsert.do",function(){
		        $('#purchaseModal').modal({backdrop: 'static', keyboard: false});
		        $('#purchaseModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        $(".controll-title").html("");
		        $(".controll-title").html("원재료 입고 정보 수정");
				$('#purchaseModal #requestDate').val(tdRequestDate);
				$('#purchaseModal #dueDate').val(tdDueDate);
				$('#purchaseModal #rmNo').val(tdRmNo);
				$('#purchaseModal #rmName').val(tdRmName);
				$('#purchaseModal #vendorNo').val(tdVendorNo);
				$('#purchaseModal #requirAmount').val(tdRequireAmount);
				$('#purchaseModal #requestContents').val(tdRequestContents);
			});
			
			
		});
		
		
	</script>


<style>
#rmModal{
	z-index: 1060;
}
#dataTable tbody tr:hover td{
	cursor : pointer;
	background-color:#ccc;
}
</style>

<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>






