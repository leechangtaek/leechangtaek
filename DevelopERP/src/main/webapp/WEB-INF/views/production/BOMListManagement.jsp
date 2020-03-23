<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
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


<%-- table start --%>
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">BOM 목록</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTableBOMList" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>품목코드</th>
          <th>품목명</th>
          <th>품목구분</th>
          <th>BOM구성 품목수</th>
          <th>총수량</th>
          <th>BOM등록</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${productList}" var="p" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${p.PL_NO}</a></td>
	          <td>${p.PRODUCT_NAME}</td>
	          <td>${p.PT_TYPE}</td>
	          <c:if test="${p.CNT != null}">
	          <td>${p.CNT}개</td>
	          </c:if>
	          <c:if test="${p.CNT == null}">
	          <td></td>
	          </c:if>
	          <c:if test="${p.SUM != null}">
	          <td>${p.SUM}</td>
	          </c:if>
	          <c:if test="${p.SUM == null}">
	          <td></td>
	          </c:if>
	          <c:choose>
			         <c:when test = "${p.PT_TYPE eq '완제품' && p.CNT == null}">
			            <td class="tdBOMAddAlign"><button class="btn btn-primary BOMAddBtn" type="button">BOM등록</button></td>
			         </c:when>
			         <c:when test = "${p.PT_TYPE eq '완제품' && p.CNT != null}">
			            <td class="tdBOMAddAlign"><button class="btn btn-success BOMAddBtn" type="button">BOM수정</button></td>
			         </c:when>
			         <c:otherwise>
			         	<td class="tdBOMAddAlign"></td>
			         </c:otherwise>
         		</c:choose>
	        </tr>
        </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>

<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="BOMAddModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
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


<style>
.tdBOMAddAlign{
	text-align: center;
}
.BOMAddBtn{
	    width: 100%;
}
</style>
<script>
<%--onload start--%>
$(()=>{
	
	$("#dataTableBOMList").DataTable({
		// 3번째 항목을 오름 차순 
		// order : [ [ 열 번호, 정렬 순서 ], ... ]
		order: [ [ 2, "asc" ] ]
	});
	
})
<%--onload end--%>


<%--modal show--%>
$(".BOMAddBtn").click(function(){
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this).parent().parent();
	var td = tr.children();
	//console.log(tr)
	//console.log(td)
	
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	var tdPtNo = td.eq(0).text();
	var tdPtName = td.eq(1).text();
	
	//BOM 동록인지 수정인지 판별 Ajax
	$.ajax({
 		url: "${pageContext.request.contextPath}/production/selectBOMForm.do",
 		data: {tdPtNo : tdPtNo},
 		contentType : "application; charset=utf-8",
 		dataType: "json",
 		success: data => {
 			//console.log(data);
 			//console.log(data.isUsable);
 			if(data.isUsable == true){
 				$('.controll-modal-body3').load("${pageContext.request.contextPath}/production/addBOMForm.do",function(){
 			        $('#BOMAddModal').modal({backdrop: 'static', keyboard: false});
 			        $('#BOMAddModal').modal({show:true});
 			        $(".modal-backdrop.in").css('opacity', 0.4);
 			        
 			        $(".controll-title").html("");
 			        $(".controll-title").html("BOM 등록");
 			        $("#productCode").val(tdPtNo);
 			        $("#productInfo").val(tdPtName);
 			    });
 			} //end of if
 			else{
 				$('.controll-modal-body3').load("${pageContext.request.contextPath}/production/updateBOMForm.do?tdPtNo="+data.tdPtNo,function(){
 			        $('#BOMAddModal').modal({backdrop: 'static', keyboard: false});
 			        $('#BOMAddModal').modal({show:true});
 			        $(".modal-backdrop.in").css('opacity', 0.4);
 			        
 			        $(".controll-title").html("");
 			        $(".controll-title").html("BOM 수정");
 			        $("#productCode").val(tdPtNo);
 			        $("#productInfo").val(tdPtName);
 			    });
 			} //end of if
 			
 			
 		},
 		error : (jqxhr, textStatus, errorThrown)=>{
 			//console.log(jqxhr, textStatus, errorThrown);
 		}
 	});
	
	
	
    
});

</script>


<!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>