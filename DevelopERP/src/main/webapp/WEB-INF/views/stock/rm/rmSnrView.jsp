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
  


<!-- ============================ 원재료 입출고 관리 부분 ==================================== -->
	<h1 class="h3 mb-2 text-gray-800">원재료 입출고 관리</h1>
	
	<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="float:right;">
		<div class="input-group" style="margin:30px;">
		
			<div class="input-group-append">
				<button class="btn btn-primary" type="button" id="rmSnrInsert_button">
					  신규 입고 등록하기 
				</button> &nbsp;&nbsp;&nbsp;&nbsp;
				
				<button class="btn btn-primary" type="button" id="rmSnrUpdate_button">
					  입고 품목 수정하기 
				</button> &nbsp;&nbsp;&nbsp;&nbsp;
				
				<button class="btn btn-primary" type="button" id="rmSnrDelete_button">
					  입고 품목 삭제하기 &nbsp;&nbsp;&nbsp;
				</button> 
			</div>
		</div>
	</form>
	
	<br />
	
	<!-- DataTales Example -->
	
	<div class="card shadow mb-4" style="clear:both;">
		<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
	</div>
	  
	<%-- nav bar tap start --%>
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" href="${pageContext.request.contextPath }/stock/rm/rmSnrView.do">원재료 입출고 관리</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="${pageContext.request.contextPath }/stock/rm/rmView.do">원재료 재고 조회</a>
	  </li>
	</ul>
	<%-- nav bar tap end --%>
	
	  <div class="card-body" style='font-size: 14px'>
	    <div class="table-responsive">
			<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
			  <thead>
			    <tr>
			     <th>입고 날짜</th>
			     <th>로트 번호</th>
			     <th>원재료번호</th>
			     <th>원재료이름</th>
			     <th>거래처번호</th>
			     <th>거래처이름</th>
			     <th>입고 수량</th>
			    </tr>
			  </thead>
			  
			  
			  <tbody>
		      	<c:forEach items="${rmSnrList}" var="rmSnr" varStatus="vs">
			        <tr>
			          <td>${rmSnr.REC_DATE}</td>
			          <td>${rmSnr.LOT_NO}</td>
			          <td>${rmSnr.RM_NO}</td>
			          <td>${rmSnr.RM_NAME}</td> 
			          <td>${rmSnr.VENDOR_NO}</td>    
			          <td>${rmSnr.VENDOR_NAME}</td>   
			          <td>${rmSnr.QUANTITY}</td>
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
	
	  
	<script>
	
		$("#rmSnrInsert_button").click(function(){
		 $('.controll-modal-body').load("${pageContext.request.contextPath}/stock/rm/modalRmSnrInsert.do",function(){
		        $('#rmModal').modal({backdrop: 'static', keyboard: false});
		        $('#rmModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        $(".controll-title").html("");
		        $(".controll-title").html("신규 입고 등록하기");
			});
		});
		
		$("#rmSnrUpdate_button").click(function(){
		 $('.controll-modal-body').load("${pageContext.request.contextPath}/stock/rm/modalRmSnrUpdate.do",function(){
		        $('#rmModal').modal({backdrop: 'static', keyboard: false});
		        $('#rmModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        $(".controll-title").html("");
		        $(".controll-title").html("원재료 입고 정보 수정");
			});
		});
		
		$("#rmSnrDelete_button").click(function(){
			 $('.controll-modal-body').load("${pageContext.request.contextPath}/stock/rm/modalRmSnrDelete.do",function(){
			        $('#rmModal').modal({backdrop: 'static', keyboard: false});
			        $('#rmModal').modal({show:true});
			        $(".modal-backdrop.in").css('opacity', 0.4);
			        $(".controll-title").html("");
			        $(".controll-title").html("원재료 입고 정보 삭제");
				});
			});
	</script>


<style>
#rmModal{
	z-index: 1060;
}
</style>

<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>






